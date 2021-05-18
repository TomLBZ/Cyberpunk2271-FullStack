/*----------------------------------------------------------------------------
 * CMSIS-RTOS 'main' function template
 *---------------------------------------------------------------------------*/
 
#include "Main.h"

/*----------------------------------------------------------------------------
 * Application main thread
 *---------------------------------------------------------------------------*/

__NO_RETURN static void thread_analog_inputs(void *argument) 
{
  for (;;) 
  {
	  uint16_t analogValue = AnalogReadPin(ANALOG_INPUT_PIN);
	  osDelay(1000);
  }
}
 
__NO_RETURN static void thread_onboard_led(void *argument)
{
	// initialize breathing LED
	uint8_t LED_MAX_LENGTH = MASK(CONST_ONBOARD_LED_BITS) - 1;
	uint8_t REPETITION = CONST_ONBOARD_LED_COLOR_CHANGE_PERIOD_MS / LED_MAX_LENGTH;
	bool isRIncresing = true;
	bool isGIncresing = true;
	bool isBIncresing = true;
	if (REPETITION == 0) REPETITION = 1;
	ONBOARD_LED_R_4BIT = 0;						//darkest
	ONBOARD_LED_G_4BIT = LED_MAX_LENGTH >> 1;	//mid
	ONBOARD_LED_B_4BIT = LED_MAX_LENGTH;		//brightest
	for (;;)
	{
		for (uint8_t j = 0; j < REPETITION; j++)
		{
			for (uint8_t i = 0; i < LED_MAX_LENGTH; i++)
			{
				if (ONBOARD_LED_R_4BIT > i) DigitalWritePin(RED_LED_PIN, LOW);
				else DigitalWritePin(RED_LED_PIN, HIGH);
				if (ONBOARD_LED_G_4BIT > i) DigitalWritePin(GREEN_LED_PIN, LOW);
				else DigitalWritePin(GREEN_LED_PIN, HIGH);
				if (ONBOARD_LED_B_4BIT > i) DigitalWritePin(BLUE_LED_PIN, LOW);
				else DigitalWritePin(BLUE_LED_PIN, HIGH);
				osDelay(CONST_ONBOARD_LED_REFRESH_RESOLUTION_MS);   // refresh
			}
		}
		ONBOARD_LED_R_4BIT += isRIncresing ? 1 : -1;
		if (ONBOARD_LED_R_4BIT == LED_MAX_LENGTH) isRIncresing = false;
		else if (ONBOARD_LED_R_4BIT == 0) isRIncresing = true;
		ONBOARD_LED_G_4BIT += isGIncresing ? 1 : -1;
		if (ONBOARD_LED_G_4BIT == LED_MAX_LENGTH) isGIncresing = false;
		else if (ONBOARD_LED_G_4BIT == 0) isGIncresing = true;
		ONBOARD_LED_B_4BIT += isBIncresing ? 1 : -1;
		if (ONBOARD_LED_B_4BIT == LED_MAX_LENGTH) isBIncresing = false;
		else if (ONBOARD_LED_B_4BIT == 0) isBIncresing = true;
	}
}

int main (void) 
{
	// System Initialization
	SystemCoreClockUpdate();
	// ...
	
	ClockToPorts(Ports);
	SelectPinsFunctions(OutputPins);
	SetPinsDirections(OutputPins, PIN_OUTPUT);
	SetPinsDirections(InputPins, PIN_INPUT);
	AnalogInputEnable();
	osKernelInitialize();                 // Initialize CMSIS-RTOS
	osThreadNew(thread_analog_inputs, NULL, NULL);     // Create application main thread
	osThreadNew(thread_onboard_led, NULL, NULL);    // Create application main thread
	osKernelStart();                       // Start thread execution
	for (;;) {}
}
