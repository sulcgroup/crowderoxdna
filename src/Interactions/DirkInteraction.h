/*
 * DirkInteraction.h
 *
 *  Created on: 8/Oct/2013
 *      Author: Flavio
 */

#ifndef DIRKINTERACTION_H_
#define DIRKINTERACTION_H_

#include "BaseInteraction.h"
#include "InteractionUtils.h"

/**
 * @brief Class to simulate Dirk's particles (hard cylinders with a DHS head)
 *
 * 
 * The diameter of the cylinders is assumed to be 1.
 * The length is the length of the cylinder;
 * DHS_radius is the radius of the dipolar sphere
 * DHS_rcut is the cutoff for the Reaction Field treatment
 * DHS_eps is the dielectric constant of the Reaction Field treatment
 *
 * The cylinder is treated like in HardCylinderInteraction
 *
 * The hard sphere head is treated like in DHSInteraction
 *
 * interaction_type = Dirk
 *
 * Input options:
 *
 * @verbatim
length = <float> (lenght of the cylinders)
DHS_radius = <float> (radius of the diploar hard sphere on top of each cylinder)
DHS_rcut = <float> (distance cutoff for the reaction field treatment)
DHS_eps = <float> (background dielectric constant for the reaction field treatment)
@endverbatim
 */
template <typename number>
class DirkInteraction: public BaseInteraction<number, DirkInteraction<number> > {
protected:
	/// length of the line segment 
	number _length;
	
	/// radius of the dipolar hard sphere on one face
	number _DHS_radius;

	/// dielectric constant for reaction field
	number _DHS_eps;

	/// cutoff for reaction field treatment
	number _DHS_rcut, _DHS_sqr_rcut;
	
	/// Reaction field factor
	number _DHS_rf_fact;
	
	/// helper variable
	number _compar;
	
	/// potential
	inline number _dirk_pot (BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	
public:
	enum {
		CYLINDER_OVERLAP = 0,
		DHSPERE_OVERLAP = 1,
		DHSPERE_ATTRACTION = 2,
	};
	
	DirkInteraction();
	virtual ~DirkInteraction();

	virtual void get_settings(input_file &inp);
	virtual void init();

	virtual void allocate_particles(BaseParticle<number> **particles, int N);

	virtual number pair_interaction(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r=NULL, bool update_forces=false);
	virtual number pair_interaction_bonded(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r=NULL, bool update_forces=false);
	virtual number pair_interaction_nonbonded(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r=NULL, bool update_forces=false);
	virtual number pair_interaction_term(int name, BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r=NULL, bool update_forces=false) {
		return this->_pair_interaction_term_wrapper(this, name, p, q, r, update_forces);
	}

	virtual void check_input_sanity(BaseParticle<number> **particles, int N);

	bool generate_random_configuration_overlap (BaseParticle<number> * p, BaseParticle<number> *q, number box_side);
};

/*
template<typename number>
number DirkInteraction<number>::_dirk_pot_old (BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces) {
	if (update_forces) throw oxDNAException ("No forces, figlio di ndrocchia");
	
	if ((*r).norm() > this->_sqr_rcut) return (number) 0.f;
	
	// overlap between cylinders
	bool cylinder_overlap = InteractionUtils::cylinder_overlap (p, q, (*r), _length);
	if (cylinder_overlap) {
		this->set_is_infinite (true);
		return (number) 1.e12;
	}
	
	// overlap between DHS
	LR_vector<number> dhsp = p->orientation.v3 * (_length / 2.); 
	LR_vector<number> dhsq = q->orientation.v3 * (_length / 2.); 

	LR_vector<number> dhsdr = (*r) + dhsq - dhsp; 
	number dhsdrnorm = dhsdr.norm();
	if (dhsdrnorm <= (4. * _DHS_radius * _DHS_radius)) {
		this->set_is_infinite(true);
		if (false) printf ("1 overlap %d %d - %#g %#g %#g - %#g %#g %#g - %#g %#g %#g - %#g %#g %#g -- %#g %#g\n", p->index, q->index,
				p->pos.x, p->pos.y, p->pos.z,
				p->orientationT.v3.x, p->orientationT.v3.y, p->orientationT.v3.z,
				q->pos.x, q->pos.y, q->pos.z,
				q->orientationT.v3.x, q->orientationT.v3.y, q->orientationT.v3.z, sqrt(dhsdrnorm), sqrt((*r).norm()));
		return (number) 1.e12;
	}
	
	// dhsq - cylinderp
	bool ov1 = InteractionUtils::sphere_spherocylinder_overlap (-((*r) + dhsq), _DHS_radius, p->orientation.v3, _length, (number)0.5f);
	if (!ov1) ov1 = InteractionUtils::sphere_box_overlap (-((*r) + dhsq), _DHS_radius, p->orientation, (number)1.f, (number)1.f, _length);
	if (ov1) {
		this->set_is_infinite(true);
		return (number) 1.e12;
	}
	
	// dhsq - cylinderp
	bool ov2 = InteractionUtils::sphere_spherocylinder_overlap ( ((*r) - dhsp), _DHS_radius, q->orientation.v3, _length, (number)0.5f);
	if (!ov2) ov2 = InteractionUtils::sphere_box_overlap ( ((*r) - dhsp), _DHS_radius, q->orientation, (number)1.f, (number)1.f, _length);
	if (ov2) {
		this->set_is_infinite(true);
		return (number) 1.e12;
	}
	
	// DHS potential;
	if (dhsdrnorm > _DHS_sqr_rcut) return 0.f;
	
	// direct part
	//number energy = - (1. / (dhsdrnorm * sqrt(dhsdrnorm))) * (3.f * (*r).z * (*r).z / dhsdrnorm - (number) 1.f);

	// reaction field part
	//energy += - _DHS_rf_fact; 
	
	//number dot = p->orientation.v3 * q->orientation.v3;
	//number energy = - (1. / (dhsdrnorm * sqrt(dhsdrnorm))) * (3 * (p->orientation.v3 * (*r)) * (q->orientation.v3 * (*r)) / dhsdrnorm - dot); 
	//energy += - _DHS_rf_fact * dot; 
	
	number dot = p->orientation.v1 * q->orientation.v1;
	number energy = - (1. / (dhsdrnorm * sqrt(dhsdrnorm))) * (3 * (p->orientation.v1 * (dhsdr)) * (q->orientation.v1 * (dhsdr)) / dhsdrnorm - dot); 
	energy += - _DHS_rf_fact * dot; 
	
	return energy;
}
*/

template<typename number>
number DirkInteraction<number>::_dirk_pot (BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces) {
	if (update_forces) throw oxDNAException ("No forces, figlio di ndrocchia");
	
	number rnorm = (*r).norm(); 
	if (rnorm > this->_sqr_rcut) return (number) 0.f;

	// overlap between DHS
	if (rnorm <= (4. * _DHS_radius * _DHS_radius)) {
		this->set_is_infinite(true);
		return (number) 1.e12;
	}
	
	LR_vector<number> pcyl = p->orientation.v3 * _length / 2.;
	LR_vector<number> qcyl = q->orientation.v3 * _length / 2.;
	// overlap between cylinders
	LR_vector<number> drcyl = (*r) + qcyl - pcyl; 
	if (drcyl.norm() < _length * _length + 0.25 + 0.01) {
		bool cylinder_overlap = InteractionUtils::cylinder_overlap (p, q, drcyl, _length);
		if (cylinder_overlap) {
			this->set_is_infinite (true);
			return (number) 1.e12;
		}
	}
	
	
	// dhsq - cylinderp
	drcyl = *r - pcyl;
	if (drcyl.norm () < _compar) {
		if (InteractionUtils::cylinder_sphere_overlap (drcyl, p->orientation.v3, _length, _DHS_radius)) {
			this->set_is_infinite(true);
			return (number) 1.e12;
		}
	}
	
	// dhsp - cylinderq
	drcyl =  (*r + qcyl);
	if (drcyl.norm () < _compar) {
		if (InteractionUtils::cylinder_sphere_overlap (drcyl, q->orientation.v3, _length, _DHS_radius)) {
			this->set_is_infinite(true);
			return (number) 1.e12;
		}
	}
	
	// DHS potential;
	if (rnorm > _DHS_sqr_rcut) return 0.f;
	
	// direct part
	number energy = - (1. / (rnorm * sqrt(rnorm))) * (3.f * (*r).z * (*r).z / rnorm - (number) 1.f);
	energy += - _DHS_rf_fact; 
	
	// real dipolar hard spheres...	
	//number dot = p->orientation.v1 * q->orientation.v1;
	//number energy = - (1. / (rnorm * sqrt(rnorm))) * (3 * (p->orientation.v1 * (*r)) * (q->orientation.v1 * (*r)) / rnorm - dot); 
	//energy += - _DHS_rf_fact * dot; 
	
	return energy;
}


#endif /* HARDSPHEROCYLINDERINTERACTION_H_ */
