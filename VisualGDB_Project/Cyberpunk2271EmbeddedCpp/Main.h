#pragma once
#include "RTE_Components.h"
#include  CMSIS_device_header
#include "cmsis_os2.h"
#include "Variables.h"
#include "Macros.h"

#define CONST_ONBOARD_LED_REFRESH_RESOLUTION_MS			1 // resolution t
#define CONST_ONBOARD_LED_BITS							4 // bits n
#define CONST_ONBOARD_LED_COLOR_CHANGE_PERIOD_MS		135 // multiple of t(2^n - 1), must <= 255 

using namespace GPIO;

__NO_RETURN static void thread_analog_inputs(void *argument);

__NO_RETURN static void thread_onboard_led(void *argument);