#pragma once
#include "GPIO.h"

using namespace GPIO;

// Constant Variables
extern const Pin RED_LED_PIN;
extern const Pin GREEN_LED_PIN;
extern const Pin BLUE_LED_PIN;
extern const Pin NULL_PIN;
extern const Pin ANALOG_INPUT_PIN;
extern const GPIO_PORT Ports[];

extern const Pin OutputPins[];
extern const Pin InputPins[];
// Variables
extern uint8_t ONBOARD_LED_R_4BIT;
extern uint8_t ONBOARD_LED_G_4BIT;
extern uint8_t ONBOARD_LED_B_4BIT;
