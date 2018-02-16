/*
 * CrowderParticle.h
 *
 *  Created on: 15/mar/2018
 *      Author: fan
 */

#ifndef CROWDERPARTICLE_H_
#define CROWDERPARTICLE_H_

#include "BaseParticle.h"

#define CROWDERTYPE (-1)
/**
 * @brief Incapsulates a spherical particle Used by DNA2CrowderInteraction.
 */
template<typename number>
class CrowderParticle : public BaseParticle<number> {
protected:
	//number _radius;
    //number _stiffness;

public:
	CrowderParticle(number radius, number stiffness);
	virtual ~CrowderParticle();

	void set_positions();

	virtual bool is_rigid_body() {
		return true;
	}
};

#endif /* CROWDERPARTICLE_H_ */
