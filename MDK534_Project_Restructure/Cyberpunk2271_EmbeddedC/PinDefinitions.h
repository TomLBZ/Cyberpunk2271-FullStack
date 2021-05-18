#ifndef PINDEF_FLAG
#define PINDEF_FLAG

#include "GPIO.h"

#define _ONBOARDLED_PIN_R { GPIO_PORT_B, 18, 1 }
#define _ONBOARDLED_PIN_G { GPIO_PORT_B, 19, 1 }
#define _ONBOARDLED_PIN_B { GPIO_PORT_D, 1, 1 }

#define _ANALOG_INPUT_PIN { GPIO_PORT_B, 2, 0 }
#define _ANALOG_OUTPUT_MUSIC_PIN { GPIO_PORT_E, 30, 0 }
#define _NULL_PIN {GPIO_PORT_NULL, 0, 0}

#define _EXTERNAL_DAC_PIN0 { GPIO_PORT_B, 8, 1 }
#define _EXTERNAL_DAC_PIN1 { GPIO_PORT_B, 9, 1 }
#define _EXTERNAL_DAC_PIN2 { GPIO_PORT_B, 10, 1 }
#define _EXTERNAL_DAC_PIN3 { GPIO_PORT_B, 11, 1 }
#define _EXTERNAL_DAC_PIN4 { GPIO_PORT_E, 2, 1 }
#define _EXTERNAL_DAC_PIN5 { GPIO_PORT_E, 3, 1 }
#define _EXTERNAL_DAC_PIN6 { GPIO_PORT_E, 4, 1 }
#define _EXTERNAL_DAC_PIN7 { GPIO_PORT_E, 5, 1 }

#define _MOTOR_LFF_PIN { GPIO_PORT_D, 0, 4 } // TPM0CH0
#define _MOTOR_LFR_PIN { GPIO_PORT_D, 2, 4 } // TPM0CH2
#define _MOTOR_LBF_PIN { GPIO_PORT_D, 3, 4 } // TPM0CH3
#define _MOTOR_LBR_PIN { GPIO_PORT_C, 2, 4 } // TPM0CH1
#define _MOTOR_RFF_PIN { GPIO_PORT_C, 8, 3 } // TPM0CH4
#define _MOTOR_RFR_PIN { GPIO_PORT_C, 9, 3 } // TPM0CH5
#define _MOTOR_RBF_PIN { GPIO_PORT_B, 3, 3 } // TPM2CH1
#define _MOTOR_RBR_PIN { GPIO_PORT_B, 2, 3 } // TPM2CH0

extern const GPIO_PORT Ports[];

extern const Pin MusicPins[];
extern const Pin InputPins[];
extern const Pin OnboardLED_Pins[];
extern const Pin ExternalDAC_Pins[];
extern const Pin MotorPins[];

#endif
