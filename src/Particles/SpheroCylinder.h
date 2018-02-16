/*
 * SpheroCylinder.h
 *
 *  Created on: 02/feb/2015
 *      Author: Flavio 
 */

#ifndef SPHEROCYLINDER_H_
#define SPHEROCYLINDER_H_

#include "BaseParticle.h"

/**
 * @brief Spherocylinder.
 */
template<typename number>
class SpheroCylinder: public BaseParticle<number> {
protected:

public:
	SpheroCylinder(number length);
	virtual ~SpheroCylinder();

	number length;
	LR_vector<number> * dir;

	enum {
		TOP = 0,
		BOT = 1
	};
	virtual void set_positions();
	virtual bool is_rigid_body() { return true; }

	void set_initial_forces (llint step, number box); 
	void set_ext_potential (llint step, number box); 

	void set_length (number arg);
};

#endif /* SPHEROCYLINDER_H_ */
