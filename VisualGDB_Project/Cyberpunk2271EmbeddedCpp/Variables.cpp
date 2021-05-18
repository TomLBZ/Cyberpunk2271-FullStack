#include "Variables.h"
// Constant Variables
const Pin RED_LED_PIN { GPIO_PORT_B, 18, 1 };

const Pin GREEN_LED_PIN { GPIO_PORT_B, 19, 1 };

const Pin BLUE_LED_PIN { GPIO_PORT_D, 1, 1 };

const Pin ANALOG_INPUT_PIN { GPIO_PORT_B, 2, 0 };

// NULL Pin
const Pin NULL_PIN {GPIO_PORT_NULL, 0, 0};

const GPIO_PORT Ports[] 
{
	GPIO_PORT_B,
	GPIO_PORT_D,
	GPIO_PORT_NULL
};

const Pin OutputPins[] 
{ 
	RED_LED_PIN,
	GREEN_LED_PIN,
	BLUE_LED_PIN,
	NULL_PIN
};

const Pin InputPins[]
{
	ANALOG_INPUT_PIN,
	NULL_PIN
};

// Variables
uint8_t ONBOARD_LED_R_4BIT;
uint8_t ONBOARD_LED_G_4BIT;
uint8_t ONBOARD_LED_B_4BIT;
