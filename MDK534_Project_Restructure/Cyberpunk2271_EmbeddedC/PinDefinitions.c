#include "PinDefinitions.h"

const Pin ONBOARDLED_PIN_R = _ONBOARDLED_PIN_R;
const Pin ONBOARDLED_PIN_G = _ONBOARDLED_PIN_G;
const Pin ONBOARDLED_PIN_B = _ONBOARDLED_PIN_B;
const Pin MUSIC_PIN = _ANALOG_OUTPUT_MUSIC_PIN;
const Pin PinLeftFrontForward = _MOTOR_LFF_PIN;
const Pin PinLeftFrontBackward = _MOTOR_LFR_PIN;
const Pin LeftBackForward = _MOTOR_LBF_PIN;
const Pin LeftBackBackward = _MOTOR_LBR_PIN;
const Pin RightFrontForward = _MOTOR_RFF_PIN;
const Pin RightFrontBackward = _MOTOR_RFR_PIN;
const Pin RightBackForward = _MOTOR_RBF_PIN;
const Pin RightBackBackward = _MOTOR_RBR_PIN;

const GPIO_PORT Ports[] =
{
	GPIO_PORT_B,
	GPIO_PORT_C,
	GPIO_PORT_D,
	GPIO_PORT_E,
	GPIO_PORT_NULL
};

const Pin InputPins[] =
{
	_ANALOG_INPUT_PIN,
	_NULL_PIN
};

const Pin MusicPins[] = 
{
	_ANALOG_OUTPUT_MUSIC_PIN,
	_NULL_PIN
};

const Pin OnboardLED_Pins[] =
{
	_ONBOARDLED_PIN_R,
	_ONBOARDLED_PIN_G,
	_ONBOARDLED_PIN_B,
	_NULL_PIN
};

const Pin ExternalDAC_Pins[] = 
{
	_EXTERNAL_DAC_PIN0,
	_EXTERNAL_DAC_PIN1,
	_EXTERNAL_DAC_PIN2,
	_EXTERNAL_DAC_PIN3,
	_EXTERNAL_DAC_PIN4,
	_EXTERNAL_DAC_PIN5,
	_EXTERNAL_DAC_PIN6,
	_EXTERNAL_DAC_PIN7,
	_NULL_PIN
};

const Pin MotorPins[] =
{
	_MOTOR_LFF_PIN,
	_MOTOR_LFR_PIN,
	_MOTOR_LBF_PIN,
	_MOTOR_LBR_PIN,
	_MOTOR_RFF_PIN,
	_MOTOR_RFR_PIN,
	_MOTOR_RBF_PIN,
	_MOTOR_RBR_PIN,
	_NULL_PIN
};
