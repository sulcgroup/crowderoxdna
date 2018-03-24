#include "CrowderDNA2Interaction.h"

#include "../Particles/DNANucleotide.h"
#include "../Particles/CrowderParticle.h" //maybe not define a unique own particle


template<typename number>
CrowderDNA2Interaction<number>::CrowderDNA2Interaction() : DNA2Interaction<number>() {
	//this->_int_map[CROWDER_EXC_VOLUME] = (number (DNA2Interaction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_debye_huckel;
	// I assume these are needed. I think the interaction map is used for when the observables want to print energy

	this->_int_map[this->BACKBONE] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_backbone;
	this->_int_map[this->COAXIAL_STACKING] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_coaxial_stacking;
	this->_int_map[this->CROSS_STACKING] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_cross_stacking;

	this->_int_map[this->BONDED_EXCLUDED_VOLUME] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_bonded_excluded_volume;
	this->_int_map[this->STACKING] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_stacking;

	this->_int_map[this->HYDROGEN_BONDING] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_hydrogen_bonding;
	this->_int_map[this->NONBONDED_EXCLUDED_VOLUME] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_nonbonded_excluded_volume;
	this->_int_map[this->DEBYE_HUCKEL] = (number (DNAInteraction<number>::*)(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)) &CrowderDNA2Interaction<number>::_debye_huckel;


}



template<typename number>
bool CrowderDNA2Interaction<number>::_is_crowder(BaseParticle<number> *p)
{
 	if (p->btype == CROWDERTYPE) // || q->type == CROWDERTYPE)
  		return true;
  	else
  		return false;
}

template<typename number>
bool CrowderDNA2Interaction<number>::_crowder_present(BaseParticle<number> *p, BaseParticle<number> *q)
{
 	if (this->_is_crowder(p) || this->_is_crowder(q))
  		return true;
  	else
  		return false;
}

template<typename number>
number CrowderDNA2Interaction<number>::_backbone(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{
 if (this->_crowder_present(p,q))
	 return 0.f;
 else
	 return this->DNA2Interaction<number>::_backbone(p,q,r,update_forces);
}

template<typename number>
number CrowderDNA2Interaction<number>::_bonded_excluded_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{
  if (this->_crowder_present(p,q))
		 return 0.f;
  else
		 return this->DNA2Interaction<number>::_bonded_excluded_volume(p,q,r,update_forces);
}

template<typename number>
number CrowderDNA2Interaction<number>::_stacking(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{

	  if (this->_crowder_present(p,q))
			 return 0.f;
	  else
			 return this->DNA2Interaction<number>::_stacking(p,q,r,update_forces);
}


template<typename number>
number CrowderDNA2Interaction<number>::_nonbonded_excluded_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{
	  //printf(" I call the function NONBONDED on %d %d %d %d \n",p->index, q->index, p->type,q->type);
	  //fflush(stdout);
	  if (! this->_crowder_present(p,q))
	  {
		  return this->DNA2Interaction<number>::_nonbonded_excluded_volume(p,q,r,update_forces);
	  }
	  else
	  {
		  if( this->_is_crowder(p) && this->_is_crowder(q))
		  {
			  return this->_crowder_crowder_exc_volume(p,q,r,update_forces);
		  }
		  else
		  {
              return this->_crowder_DNA_exc_volume(p,q,r,update_forces);
		  }
	  }

}


template<typename number>
number CrowderDNA2Interaction<number>::_crowder_crowder_exc_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{
	// printf(" I call the function CROWDER CROWDER\n");
	 if( !( this->_is_crowder(p) && this->_is_crowder(q)   ) )
     {
	   return 0.f;
	 }

	 LR_vector<number> force(0, 0, 0);
	 LR_vector<number> rcenter = *r; // + q->int_centers[DNANucleotide<number>::BASE] - p->int_centers[DNANucleotide<number>::BASE];
	 number energy = this->_crowder_repulsive_lj(rcenter, force, this->_stiffness,this->_cc_sigma, this->_cc_rstar,this->_cc_b,this->_cc_rc, update_forces);

	 if(update_forces) {
	 		p->force -= force;
	 		q->force += force;
	 }

	 return energy;
}


template<typename number>
number CrowderDNA2Interaction<number>::_crowder_DNA_exc_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{
	 //printf("Calling crodwer DNA on %d %d \n",p->index,q->index);
	 BaseParticle<number> *crowder;
	 BaseParticle<number> *nuc;

	 LR_vector<number> force(0, 0, 0);
     LR_vector<number> rcenter = *r;

	 if( !this->_is_crowder(p) && this->_is_crowder(q) )
     {
		 //rcenter = -rcenter;
		 crowder = q;
		 nuc = p;
	 }
	 else if (this->_is_crowder(p) && !this->_is_crowder(q) )
	 {
		 rcenter = -rcenter;
		 crowder = p;
		 nuc = q;
	 }
	 else
	 {
		 return 0.f;
	 }

	 LR_vector<number> r_to_back = rcenter  - nuc->int_centers[DNANucleotide<number>::BACK];
	 LR_vector<number> r_to_base = rcenter  - nuc->int_centers[DNANucleotide<number>::BASE];

	 LR_vector<number> torquenuc(0,0,0);

	 number energy = this->_crowder_repulsive_lj(r_to_back, force, this->_stiffness,this->_c_back_sigma, this->_c_back_rstar,this->_c_back_b,this->_c_back_rc, update_forces);
	 if (update_forces) {
		    torquenuc  -= nuc->int_centers[DNANucleotide<number>::BACK].cross(force);
	 		nuc->force -= force;
		 	crowder->force += force;
	 }


	 energy += this->_crowder_repulsive_lj(r_to_base, force, this->_stiffness, this->_c_base_sigma, this->_c_base_rstar,this->_c_base_b,this->_c_base_rc, update_forces);

	 if(update_forces) {

		    torquenuc  -= nuc->int_centers[DNANucleotide<number>::BASE].cross(force);
		    nuc->torque += nuc->orientationT * torquenuc;

		    //crowder->torque -= crowder->orientationT * torquenuc;
	 		nuc->force -= force;
	 		crowder->force += force;
	 }


	 return energy;
}



template<typename number>
number CrowderDNA2Interaction<number>::_crowder_repulsive_lj(const LR_vector<number> &r, LR_vector<number> &force,number stiffness, number sigma, number rstar, number b, number rc, bool update_forces) {
	// this is a bit faster than calling r.norm()
	number rnorm = SQR(r.x) + SQR(r.y) + SQR(r.z);
	number energy = (number) 0;

	if(rnorm < SQR(rc)) {
		if(rnorm > SQR(rstar)) {
			number rmod = sqrt(rnorm);
			number rrc = rmod - rc;
			energy = this->_stiffness * b * SQR(rrc);
			if(update_forces) force = -r * (2 * this->_stiffness * b * rrc / rmod);
		}
		else {
			number tmp = SQR(sigma) / rnorm;
			number lj_part = tmp * tmp * tmp;
			energy = 4 * this->_stiffness * (SQR(lj_part) - lj_part);
			if(update_forces) force = -r * (24 * this->_stiffness * (lj_part - 2*SQR(lj_part)) / rnorm);
		}
	}

	if(update_forces && energy == (number) 0) force.x = force.y = force.z = (number) 0;

	return energy;
}




template<typename number>
number CrowderDNA2Interaction<number>::_hydrogen_bonding(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{

	  if (this->_crowder_present(p,q))
			 return 0.f;
	  else
			 return this->DNA2Interaction<number>::_hydrogen_bonding(p,q,r,update_forces);
}


template<typename number>
number CrowderDNA2Interaction<number>::_cross_stacking(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{

	  if (this->_crowder_present(p,q))
			 return 0.f;
	  else
			 return this->DNA2Interaction<number>::_cross_stacking(p,q,r,update_forces);
}

template<typename number>
number CrowderDNA2Interaction<number>::_coaxial_stacking(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{

	  if (this->_crowder_present(p,q))
			 return 0.f;
	  else
			 return this->DNA2Interaction<number>::_coaxial_stacking(p,q,r,update_forces);

}


template<typename number>
number CrowderDNA2Interaction<number>::_debye_huckel(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{

	  if (this->_crowder_present(p,q))
			 return 0.f;
	  else
			 return this->DNA2Interaction<number>::_debye_huckel(p,q,r,update_forces);
}


template<typename number>
number CrowderDNA2Interaction<number>::pair_interaction_bonded(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces)
{
	LR_vector<number> computed_r(0, 0, 0);
	if(r == NULL) {
		if (q != P_VIRTUAL && p != P_VIRTUAL) {
			computed_r = q->pos - p->pos;
			r = &computed_r;
		}

		if(!this->_check_bonded_neighbour(&p, &q, r)) return (number) 0;
	}


	// The methods with "this->" in front of them are inherited from DNAInteraction. The
	// other one belongs to CrowderDNA2Interaction
	number energy = _backbone(p, q, r, update_forces);
	energy += this->_bonded_excluded_volume(p, q, r, update_forces);
	energy += this->_stacking(p, q, r, update_forces);

	return energy;
}

template<typename number>
number CrowderDNA2Interaction<number>::pair_interaction_nonbonded(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces) {
	LR_vector<number> computed_r(0, 0, 0);
	if(r == NULL) {
		computed_r = this->_box->min_image(p->pos, q->pos);
		r = &computed_r;
	}

    if (r->norm() >= this->_sqr_rcut) return (number) 0.f;

	// The methods with "this->" in front of them are inherited from DNAInteraction. The
	// other two methods belong to CrowderDNA2Interaction
	number energy = this->_nonbonded_excluded_volume(p, q, r, update_forces);
	energy += this->_hydrogen_bonding(p, q, r, update_forces);
	energy += this->_cross_stacking(p, q, r, update_forces);
	energy += _coaxial_stacking(p, q, r, update_forces);
	energy += _debye_huckel(p, q, r, update_forces);

	return energy;
}

template<typename number>
void CrowderDNA2Interaction<number>::get_settings(input_file &inp) {
	DNA2Interaction<number>::get_settings(inp);

	getInputNumber(&inp, "crowder_radius", &_crowder_radius, 1);
	OX_LOG(Logger::LOG_INFO,"Using crowder radius %g", _crowder_radius);

	_stiffness = 1.0f;
	if( getInputNumber(&inp, "crowder_stiffness", &_stiffness, 0) == KEY_FOUND )
	{
	  OX_LOG(Logger::LOG_INFO,"Using stiffness for the excluded volume potential radius %g", _stiffness);
	}
}

template<typename number>
void CrowderDNA2Interaction<number>::init() {
	DNA2Interaction<number>::init();
        //fill in the constants:
        bool smooth = true;
        smooth &= _fill_in_constants(2.*_crowder_radius, _cc_sigma,_cc_rstar,_cc_b,_cc_rc);
        smooth &= _fill_in_constants(_crowder_radius+EXCL_S1/2., _c_back_sigma,_c_back_rstar,_c_back_b,_c_back_rc);
        smooth &= _fill_in_constants(_crowder_radius+EXCL_S2/2., _c_base_sigma,_c_base_rstar,_c_base_b,_c_base_rc);
        
        if (! smooth)
        {
           throw oxDNAException("Error in CrowderDNA2Interaction initialization: Cannot find a smooth exc vol potential for specified crowder radius");
        }
        if (_c_back_b < 0 || _c_base_b < 0 || _cc_b < 0)
        {
           throw oxDNAException("Error in CrowderDNA2Interaction initialization: Cannot find repulsive exc vol potential for specified crowder radius");
        }

        OX_LOG(Logger::LOG_DEBUG,"Crowder-crowder interaction constants: sigma=%f, rs=%f,b=%f, rc=%f ",_cc_sigma,_cc_rstar,_cc_b,_cc_rc); 
        OX_LOG(Logger::LOG_DEBUG,"Crowder-back interaction constants: sigma=%f, rs=%f,b=%f, rc=%f ",_c_back_sigma,_c_back_rstar,_c_back_b,_c_back_rc);
        OX_LOG(Logger::LOG_DEBUG,"Crowder-base interaction constants: sigma=%f, rs=%f,b=%f, rc=%f ",_c_base_sigma,_c_base_rstar,_c_base_b,_c_base_rc);
 
        number crowder_back_cut = 2.0f * sqrt((POS_MM_BACK1)*(POS_MM_BACK1) + (POS_MM_BACK2)*(POS_MM_BACK2)) + _c_back_rc;
        number crowder_base_cut = 2.0f * fabs(POS_BASE)+ _c_base_rc;
        if (crowder_back_cut < crowder_base_cut)
        {
             _c_dna_rcut = crowder_base_cut;
        }
        else
        {
             _c_dna_rcut = crowder_back_cut;
        }

        _cc_rcut = _cc_rc;
        _dna_dna_rcut = this->_rcut;

        if(this->_rcut < _cc_rcut)
        {
          this->_rcut = _cc_rcut; 
        }
        if(this->_rcut < _c_dna_rcut)
        {
          this->_rcut = _c_dna_rcut; 
        }
        this->_sqr_rcut = SQR(this->_rcut);
}

template<typename number>
void CrowderDNA2Interaction<number>::check_input_sanity(BaseParticle<number> **particles, int N) {
     this->DNA2Interaction<number>::check_input_sanity(particles,N);
   //TODO: maybe check for overlap with crowders?
}


template<typename number>
void CrowderDNA2Interaction<number>::allocate_particles(BaseParticle<number> **particles, int N) {
	for(int i = 0; i < N; i++) particles[i] = new DNANucleotide<number>(this->_grooving);
}

template<typename number>
void CrowderDNA2Interaction<number>::read_topology(int N_from_conf, int *N_strands, BaseParticle<number> **particles) {
	//IBaseInteraction<number>::read_topology(N_from_conf, N_strands, particles);


	//*N_strands = N;
	this->allocate_particles(particles, N_from_conf);
	for (int i = 0; i < N_from_conf; i ++) {
		   particles[i]->index = i;
		   particles[i]->type = 0;
		   particles[i]->strand_id = i;
	}

	int my_N, my_N_strands;

	char line[512];
	std::ifstream topology;
	topology.open(this->_topology_filename, ios::in);

	if(!topology.good()) throw oxDNAException("Can't read topology file '%s'. Aborting", this->_topology_filename);

	topology.getline(line, 512);

	sscanf(line, "%d %d\n", &my_N, &my_N_strands);

	char base[256];
	int strand, i = 0;
	while(topology.good()) {
		topology.getline(line, 512);
		if(strlen(line) == 0 || line[0] == '#') continue;
		if(i == N_from_conf) throw oxDNAException("Too many particles found in the topology file (should be %d), aborting", N_from_conf);

		int tmpn3, tmpn5;

		int res = sscanf(line, "%d %s %d %d", &strand, base, &tmpn3, &tmpn5);


		if(res < 4) throw oxDNAException("Line %d of the topology file has an invalid syntax", i+2);

		BaseParticle<number> *p = particles[i];

		if(tmpn3 < 0) p->n3 = P_VIRTUAL;
		else p->n3 = particles[tmpn3];
		if(tmpn5 < 0) p->n5 = P_VIRTUAL;
		else p->n5 = particles[tmpn5];

		// store the strand id
		// for a design inconsistency, in the topology file
		// strand ids start from 1, not from 0

		if(atoi(base) == -1) //this is a crowder particle
		{
		  //printf("I loaded a crowder! \n");
		  p->strand_id = strand -1;
		  p->type = 0;
		  p->btype = CROWDERTYPE;
		}
		else  //this is a regular DNA particle
		{
		  p->strand_id = strand - 1;

		  // the base can be either a char or an integer
		  if(strlen(base) == 1) {
		     p->type = Utils::decode_base(base[0]);
		     p->btype = Utils::decode_base(base[0]);
		  }
		  else {
			 if(atoi (base) > 0) p->type = atoi (base) % 4;
			 else p->type = 3 - ((3 - atoi(base)) % 4);
		     p->btype = atoi(base);
		  }

		  if(p->type == P_INVALID) throw oxDNAException ("Particle #%d in strand #%d contains a non valid base '%c'. Aborting", i, strand, base);
		}
		p->index = i;
		i++;

		// here we fill the affected vector
		if (p->n3 != P_VIRTUAL) p->affected.push_back(ParticlePair<number>(p->n3, p));
		if (p->n5 != P_VIRTUAL) p->affected.push_back(ParticlePair<number>(p, p->n5));
	}

	if(i < N_from_conf) throw oxDNAException ("Not enough particles found in the topology file (should be %d). Aborting", N_from_conf);

	topology.close();

	if(my_N != N_from_conf) throw oxDNAException ("Number of lines in the configuration file and\nnumber of particles in the topology files don't match. Aborting");

	*N_strands = my_N_strands;
}





template class CrowderDNA2Interaction<float>;
template class CrowderDNA2Interaction<double>;
