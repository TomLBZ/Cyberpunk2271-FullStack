// Const Macros Declarations:
#ifndef CONSTANTS_FLAG
#define CONSTANTS_FLAG // Flag: Defined Constant Macros

#include "MKL25Z4.h"            // Device header

// LED Pins
#define RED_LED (18) 		// PortB Pin 18
#define GREEN_LED (19) 	// PortB Pin 19
#define BLUE_LED (1) 		// PortD Pin 1
#define PTC7_Pin 	(7)		// PortC Pin 7
#define PTC0_Pin 	(0)		// PortC Pin 0
#define PTC16_Pin (16)	// PortC Pin 16
#define PTC17_Pin (17)	// PortC Pin 17
#define PTC5_Pin 	(5)		// PortC Pin 5
#define PTC6_Pin 	(6)		// PortC Pin 6
#define PTC10_Pin (10)	// PortC Pin 10
#define PTC11_Pin (11)	// PortC Pin 11
#define PTA17_Pin (17)	// PortA Pin 17

// Music Pins
#define DAC_Pin		(30)	// Port E Pin 30

// PWM Pins
#define PTC9_Pin  (9) // PWM C9 chan 0.5
#define PTC8_Pin  (8) // PWM C8 chan 0.4
#define PTA5_Pin  (5) // PWM A5 chan 0.2
#define PTA4_Pin  (4) // PWM A4 chan 0.1

#define PTB0_Pin	(0) // PWM B0 chan 1.0
#define PTB1_Pin	(1) // PWM B1 chan 1.1
#define PTB2_Pin	(2) // PWM B2 chan 2.0
#define PTB3_Pin	(3) // PWM B3 chan 2.1

// UART Pins
#define UART_TX_PORTE22 (22) // UART Port E 22
#define UART_RX_PORTE23 (23) // UART Port E 23

// Constants
#define CORE_CLOCK_MAX (0x02DC6C00) // 48000000Hz is the Maximum Core Clock Speed
#define COUNTER_PS (0) // 2:0 bits of PS, controlling Prescaler, set to 1.
#define PIT_STARTING_VALUE (0xFA0) // Make the frequency 6k Hz under 24MHz max Bus Clock
#define FORCE_STOP_TICKS (4) // Time needed for PWM module to stabalize output.
#define HALF_NOTE_RATIOF ((float)1.059463094) // Ratio between adjacent half notes.
#define BAUD_RATE (9600) // Baud Rate (default)
#define HANDSHAKE_R (224) // Handshake Message 0b11100000 from the App
#define HANDSHAKE_T (28) // Handshake Message 0b00011100 to the App
#define NO_OP (0) // Handshake Message to the App
#define MOTOR_PWM_FREQUENCY (0x2EE0) // PWM frequency = 12k Hz
#define MAX_POWER (255) // 6-bit power
#define MSG_COUNT (1) // Queue Length for message queues
#define LED_CYCLES (15) // for 4 bit color depth, led cycles maxed at 15.
#define FLOAT_PRECISION_UNIT ((float)0.001) // for float comparisons
#define DAC_LEVELS (4095) // DAC voltage levels

// Event Flags
#define LED_THREAD_FLAG (0x0001) // event flag for LED updates
#define MUS_THREAD_FLAG (0x0002) // event flag for Music updates
#define MOT_THREAD_FLAG (0x0003) // event flag for Motor updates
#define OTH_THREAD_FLAG (0x0004) // event flag for Other updates
#define MISC_THREAD_FLAG (0x0005) // event flag for Other updates
#define UART_THREAD_FLAG (0x0006) // event flag for Other updates

#endif
