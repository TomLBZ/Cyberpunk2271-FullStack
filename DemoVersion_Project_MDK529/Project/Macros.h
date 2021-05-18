// Function Macros Declarations:
#ifndef MACROS_FLAG
#define MACROS_FLAG // Flag: Defined Function Macros

#include "MKL25Z4.h"            // Device header

#define MASK(x) (1 << (x))
#define BUS_CLOCK_MAX (CORE_CLOCK_MAX / 2) // BUS CLOCK 24 MHz
#define MOTOR_PWM_PERIOD ((BUS_CLOCK_MAX >> COUNTER_PS) / MOTOR_PWM_FREQUENCY)

#endif
