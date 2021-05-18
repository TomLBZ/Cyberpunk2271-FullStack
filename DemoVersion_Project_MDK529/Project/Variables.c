#include "Variables.h"
#include "cmsis_os2.h"

// Volatile Variables Definition
volatile unsigned int ledState;
volatile unsigned long _dac_tick_;
volatile movingStatus runningLED_status = IDLE;

// RTOS-related Variables Declaration
osMessageQueueId_t motorQ;
osMessageQueueId_t uartRXQ;
osMessageQueueId_t uartTXQ;
osMessageQueueId_t musicQ;
osMessageQueueId_t ledQ;
osMessageQueueId_t controlQ;
osThreadId_t led_Id;
osThreadId_t mus_Id;
osThreadId_t mot_Id;
osThreadId_t misc_Id;
osThreadId_t uart_Id;
osThreadId_t tled_Id;

// Other Variables Declaration
uint8_t led_R4;
uint8_t led_G4;
uint8_t led_B4;
uint8_t led_Counter;
uint8_t green_led_segment[] = {PTC7_Pin, PTC0_Pin, PTC16_Pin, PTC17_Pin, PTC5_Pin, PTC6_Pin, PTC10_Pin, PTC11_Pin};
const Music badApple = {
	.mode = SF,
	.npm = 240,
	.script = "d6 d7 1 2 3 0 6 5 3 0 d6 0 3 2 1 d7 d6 d7 1 2 3 0 2 1 d7 d6 d7 1 d7 d6 d5 d7 "
						"d6 d7 1 2 3 0 6 5 3 0 d6 0 3 2 1 d7 d6 d7 1 2 3 0 2 1 d7 0 1 0 2 0 3 0 "
						"5 6 3 2 3 0 2 3 5 6 3 2 3 0 2 3 2 1 d7 d5 d6 0 d5 d6 d7 1 2 3 d6 0 3 5 "
						"5 6 3 2 3 0 2 3 5 6 3 2 3 0 2 3 2 1 d7 d5 d6 0 d5 d6 d7 1 2 3 d6 0 3 5 "
						"5 6 3 2 3 0 2 3 5 6 3 2 3 0 2 3 2 1 d7 d5 d6 0 d5 d6 d7 1 2 3 d6 0 3 5 "
						"5 6 3 2 3 0 2 3 5 6 3 2 3 0 6 7 u1 7 6 5 3 0 2 3 2 1 d7 d5 d6 0 "
};
