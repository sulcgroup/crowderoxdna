/*
 * CrowderParticle.cpp
 *
 *  Created on: 15/mar/2013
 *      Author: lorenzo
 */

#include "CrowderParticle.h"
#include "../Utilities/oxDNAException.h"

#define HALF_ISQRT3 0.28867513459481292f

template<typename number>
CrowderParticle<number>::CrowderParticle(number radius, number stiffness) : BaseParticle<number>(), _radius(radius),
                                                                            _stiffness(stiffness) {
	this->type = CROWDERTYPE;
	this->N_int_centers = 0;
	//this->int_centers = new LR_vector<number>[N_patches];
	//_base_patches = new LR_vector<number>[N_patches];

	//_set_base_patches();
}

template<typename number>
CrowderParticle<number>::~CrowderParticle() {
	//delete[] _base_patches;
}



template<typename number>
void CrowderParticle<number>::set_positions() {

}

template class CrowderParticle<float>;
template class CrowderParticle<double>;
