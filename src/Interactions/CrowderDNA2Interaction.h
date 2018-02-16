/**
 * @brief Implements crowder particle + DNA2 interaction;
 *
 * 
 * Fan (January 2018)
 *
 * To use the crowder+DNA2 model, set
 *
 * interaction_type = CrowderDNA2
 *
 * in the input file
 *
 * Input options:
 *
 * @verbatim
 salt_concentration = <float>  (sets the salt concentration in M)
 crowder_radius = <float>  (sets the radius of the spherical crowder particle)
 crowder_stiffness = <float> (sets the magnitude of the excluded volume repulsion potential between DNA particle vs crowder and crowder vs crowder
 [dh_lambda = <float> (the value that lambda, which is a function of temperature (T) and salt concentration (I), should take when T=300K and I=1M, defaults to the value from Debye-Huckel theory, 0.3616455)]
 [dh_strength = <float> (the value that scales the overall strength of the Debye-Huckel interaction, defaults to 0.0543)]
 [dh_half_charged_ends = <bool>  (set to false for 2N charges for an N-base-pair duplex, defaults to 1)]
 @endverbatim
 */

#ifndef CROWDER_DNA2_INTERACTION_H
#define CROWDER_DNA2_INTERACTION_H

#define POW6(x)  ((x)*(x)*(x)*(x)*(x)*(x))
#define POW7(x)  ((x)*(x)*(x)*(x)*(x)*(x)*(x))
#define POW14(x) ((x)*(x)*(x)*(x)*(x)*(x)*(x))*((x)*(x)*(x)*(x)*(x)*(x)*(x))

#include "DNA2Interaction.h"

template<typename number>
class CrowderDNA2Interaction: public DNA2Interaction<number> {

protected:
    number _crowder_radius; //crowder particle radius
    number _stiffness; // stiffness of the crowder-crowder repulsion

    number _cc_sigma;
    number _cc_rstar;
    number _cc_b; //parameter of the crowder-crowder lennard-jones repulsion
    number _cc_rc; //parameter of the crowder-crowder lennard-jones repulsion

    number _c_back_sigma;
    number _c_back_rstar;
    number _c_back_b; //parameter of the crowder-backbone repulsion
    number _c_back_rc; //parameter of the crowde-backbone repulsion

    number _c_base_sigma;
    number _c_base_rstar;
    number _c_base_b; //parameter of the crowder-base repulsion
    number _c_base_rc; //parameter of the crowder-base repulsion

    number _dna_dna_rcut; //cutoff of interaction distance between DNA particles
    number _c_dna_rcut; //cutoff of interaction distance between crowder and DNA
    number _cc_rcut; //cutoff of interaction distance between crowder and crowder


    bool _fill_in_constants(number interaction_radius, number& sigma, number& rstar, number &b, number &rc) 
    {
      rstar = interaction_radius;
      sigma = rstar + 0.05f;
      b = _calc_b(sigma,rstar);
      rc = _calc_rc(sigma,rstar);
      return _check_repulsion_smoothness(sigma,rstar,b,rc);

    }

    number _calc_b(number sigma,number R)
    {
    	return 36.0f * POW6(sigma)  * SQR((- POW6(R) + 2.0f * POW6(sigma)))   / (POW14(R) *(-POW6(R)+ POW6(sigma)));
    }

    number _calc_rc(number sigma,number R)
    {
      	return R *(4.0f *  POW6(R) -7.0f * POW6(sigma)  ) /(3.0f * (POW6(R) -2.0f *  POW6(sigma) ));
    }

    bool _check_repulsion_smoothness(number sigma,number rstar, number b, number rc) { /*TODO IMPLEMENT ME*/  return false;};
    bool _crowder_present(BaseParticle<number> *p, BaseParticle<number> *q);

public:


	virtual number _backbone(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _bonded_excluded_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _stacking(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _nonbonded_excluded_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _hydrogen_bonding(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _cross_stacking(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _coaxial_stacking(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _debye_huckel(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);

	virtual number _crowder_crowder_exc_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);
	virtual number _crowder_DNA_exc_volume(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r, bool update_forces);

	number _crowder_repulsive_lj(const LR_vector<number> &r, LR_vector<number> &force,number stiffness, number sigma, number rstar, number b, number rc, bool update_forces) ;



	CrowderDNA2Interaction();
	virtual ~CrowderDNA2Interaction() {}
    
	virtual number pair_interaction_bonded(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r=NULL, bool update_forces=false);
	virtual number pair_interaction_nonbonded(BaseParticle<number> *p, BaseParticle<number> *q, LR_vector<number> *r=NULL, bool update_forces=false);

	virtual void check_input_sanity(BaseParticle<number> **particles, int N);

	virtual void allocate_particles(BaseParticle<number> **particles, int N);
	virtual void read_topology(int N_from_conf, int *N_strands, BaseParticle<number> **particles);

	virtual void get_settings(input_file &inp);
	virtual void init();

};


#endif /* CROWDERDNA2_INTERACTION_H */
