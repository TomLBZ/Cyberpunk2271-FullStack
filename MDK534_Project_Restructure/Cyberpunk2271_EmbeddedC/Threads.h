#ifndef THREADS_FLAG
#define THREADS_FLAG

#include "RTE_Components.h"
#include  CMSIS_device_header
#include "cmsis_os2.h"
#include "OnboardLED.h"
#include "Macros.h"
#include "PinDefinitions.h"
#include "Music.h"
#include "Chassis.h"

__NO_RETURN void thread_analog_inputs(void *argument);

__NO_RETURN void thread_onboard_led(void *argument);

__NO_RETURN void thread_music(void *argument);

__NO_RETURN void thread_chassis(void *argument);

#endif
