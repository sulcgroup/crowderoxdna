/*
 * HBEnergy.h
 *
 *  Created on: Feb 14, 2013
 *      Author: petr
 */

#ifndef PAIRENERGY_H_
#define PAIRENERGY_H_

#include "BaseObservable.h"

/**
 * @brief Prints out all the interactions between all pairs of nucleotides with non-zero interaction energies (default) or between a pair of nucleotides (if specified)
 *
 * @verbatim
particle1_id = <int> (particle 1 id)
particle2_id = <int> (particle 2 id)
@endverbatim
 */
template<typename number>
class PairEnergy: public BaseObservable<number> {
protected:
	int _particle1_id;
	int _particle2_id;
	bool _print_all_particles;

public:
	PairEnergy();
	virtual ~PairEnergy();

	std::string get_output_string(llint curr_step);

	virtual void get_settings(input_file &my_inp, input_file &sim_inp);
};

#endif /* PAIRENERGY_H_ */
