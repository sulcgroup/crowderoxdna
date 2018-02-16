/*
 * MutualTrap.cpp
 *
 *  Created on: 18/oct/2011
 *      Author: Flavio 
 */

#include "MutualTrap.h"
#include "../Particles/BaseParticle.h"

template<typename number>
MutualTrap<number>::MutualTrap() : BaseForce<number>() {
	_ref_id = -2;
	_particle = -2;
	_p_ptr = NULL;
	_r0 = -1.;
	PBC = false;
}

template <typename number>
void MutualTrap<number>::get_settings (input_file &inp) {
	getInputInt (&inp, "particle", &_particle, 1);
	getInputInt (&inp, "ref_particle", &_ref_id, 1);
	getInputNumber (&inp, "r0", &_r0, 1);
	getInputNumber (&inp, "stiff", &this->_stiff, 1);
	getInputBool (&inp, "PBC", &PBC, 0);
}

template <typename number>
void MutualTrap<number>::init (BaseParticle<number> ** particles, int N, number * my_box_side_ptr){
	if (_ref_id < 0 || _ref_id >= N) throw oxDNAException ("Invalid reference particle %d for Mutual Trap", _ref_id);
	_p_ptr = particles[_ref_id];

	this->box_side_ptr = my_box_side_ptr;
	
	if (_particle >= N || N < -1) throw oxDNAException ("Trying to add a MutualTrap on non-existent particle %d. Aborting", _particle);
	if (_particle == -1) throw oxDNAException ("Cannot apply MutualTrap to all particles. Aborting");

	OX_LOG (Logger::LOG_INFO, "Adding MutualTrap (stiff=%g, r0=%g, ref_particle=%d, PBC=%d on particle %d", this->_stiff, this->_r0, _ref_id, PBC, _particle);
	particles[_particle]->add_ext_force(this);
	
}

template<typename number>
LR_vector<number> MutualTrap<number>::_distance(LR_vector<number> u, LR_vector<number> v) {
	if (this->PBC) return v.minimum_image(u, *(this->box_side_ptr));
	else return v - u;
}

template<typename number>
LR_vector<number> MutualTrap<number>::value (llint step, LR_vector<number> &pos) {
	LR_vector<number> dr = this->_distance(pos, _p_ptr->get_abs_pos(*(this->box_side_ptr)));
	return (dr / dr.module()) * (dr.module() - _r0) * this->_stiff;
}

template<typename number>
number MutualTrap<number>::potential (llint step, LR_vector<number> &pos) {
	LR_vector<number> dr = this->_distance(pos, _p_ptr->get_abs_pos(*(this->box_side_ptr)));
	return pow (dr.module() - _r0, 2) * ((number) 0.5) * this->_stiff;
}

template class MutualTrap<double>;
template class MutualTrap<float>;
