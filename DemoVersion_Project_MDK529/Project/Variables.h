#ifndef VARIABLES_FLAG
#define VARIABLES_FLAG // Flag: Defined Variables

#include "Data.h"
#include "cmsis_os2.h"
#include "Constants.h"

// Volatile Variables Declaration
extern volatile unsigned int ledState;
extern volatile unsigned long _dac_tick_;
extern volatile movingStatus runningLED_status;

// RTOS-related Variables Declaration
extern osMessageQueueId_t motorQ;
extern osMessageQueueId_t uartRXQ;
extern osMessageQueueId_t uartTXQ;
extern osMessageQueueId_t musicQ;
extern osMessageQueueId_t ledQ;
extern osMessageQueueId_t controlQ;
extern osThreadId_t led_Id;
extern osThreadId_t mus_Id;
extern osThreadId_t mot_Id;
extern osThreadId_t misc_Id;
extern osThreadId_t uart_Id;
extern osThreadId_t tled_Id;

// Other Variables Declaration
extern uint8_t led_R4;
extern uint8_t led_G4;
extern uint8_t led_B4;
extern uint8_t led_Counter;
extern uint8_t green_led_segment[];
extern const Music badApple;

#endif
