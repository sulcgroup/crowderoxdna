/*
 * CUDABaseThermostat.h
 *
 *  Created on: Feb 15, 2013
 *      Author: rovigatti
 */

#ifndef CUDABASETHERMOSTAT_H_
#define CUDABASETHERMOSTAT_H_

#include "../../Backends/Thermostats/BaseThermostat.h"
#include "../CUDAUtils.h"
#include "../CUDA_rand.cuh"

/**
 * @brief Abstract class for CUDA thermostats
 *
 * This abstract class inherits from IBaseThermostat and, as such, any instantiable child class has
 * to implement the apply() method. The best practice to write CUDA thermostats would be to first
 * write a CPU thermostat and then let the CUDA class inherit from it, like CUDABrownianThermostat does.
 * For this reason, this inheritance must be virtual to avoid compilation errors. More on this can be
 * found at http://en.wikipedia.org/wiki/Virtual_inheritance.
 */
template<typename number, typename number4>
class CUDABaseThermostat: public virtual IBaseThermostat<number> {
protected:
	CUDA_kernel_cfg _launch_cfg;
	curandState *_d_rand_state;
	llint _seed;

	/**
	 * @brief This method initialize _d_rand_state
	 *
	 * This optional method must be called if the child thermostat class needs to use _d_rand_state.
	 * It is better to call it from within the init(int N) inherited method.
	 * @param N size of the _d_rand_state. It is usually just the number of particles
	 */
	virtual void _setup_rand(int N);

public:
	CUDABaseThermostat() : _d_rand_state(NULL), _seed(0) { };
	virtual ~CUDABaseThermostat();

	virtual void set_seed(llint seed) { _seed = seed; }
	virtual void get_cuda_settings(input_file &inp);
	virtual void apply_cuda(number4 *d_pos, GPU_quat<number> *d_orientations, number4 *d_vel, number4 *d_L, llint curr_step) = 0;
	virtual bool would_activate(llint curr_step) = 0;
};

#endif /* CUDABASETHERMOSTAT_H_ */
