#include "Threads.h"

__NO_RETURN void thread_analog_inputs(void *argument) 
{
	Pin analogReadTestPin = _ANALOG_INPUT_PIN;
  for (;;) 
  {
	  uint16_t analogValue = AnalogReadPin(analogReadTestPin);
	  osDelay(1000);
  }
}
 
__NO_RETURN void thread_onboard_led(void *argument)
{
	// initialize breathing LED
	uint8_t isRIncresing = 1;
	uint8_t isGIncresing = 1;
	uint8_t isBIncresing = 1;
	uint8_t maxColor = MASK(ONBOARDLED_BITS) - 1;
	uint8_t red = 0;								// dim
	uint8_t green = maxColor >> 1;	// half bright
	uint8_t blue = maxColor;				// full bright
	for (;;)
	{
		if (red == maxColor) isRIncresing = 0;
		else if (red == 0) isRIncresing = 1;
		if (green == maxColor) isGIncresing = 0;
		else if (green == 0) isGIncresing = 1;
		if (blue == maxColor) isBIncresing = 0;
		else if (blue == 0) isBIncresing = 1;
		OnboardLED_ChangeColorOnceAsync(red, green, blue);
		red += isRIncresing ? 1 : -1;
		green += isGIncresing ? 1 : -1;
		blue += isBIncresing ? 1 : -1;
	}
}

__NO_RETURN void thread_music(void *argument)
{
	uint8_t isHigh = 0;
	for (;;)
	{
		if (!isHigh) 
		{
			AnalogWritePin(MUSIC_PIN, (uint16_t)4095);
			isHigh = 1;
		}
		else 
		{
			AnalogWritePin(MUSIC_PIN, 0);
			isHigh = 0;
		}
		osDelay(1);
	}
}

__NO_RETURN void thread_chassis(void *argument)
{
	for (;;)
	{
		DriveChannel(255, Chassis_LFF, Chassis_LFR);
		osDelay(1000);
		DriveChannel(255, Chassis_LBF, Chassis_LBR);
		osDelay(1000);
		DriveChannel(255, Chassis_RFF, Chassis_RFR);
		osDelay(1000);
		DriveChannel(255, Chassis_RBF, Chassis_RBR);
		osDelay(1000);
		osDelay(1000);
		osDelay(1000);
		DriveChannel(-255, Chassis_LFF, Chassis_LFR);
		osDelay(1000);
		DriveChannel(-255, Chassis_LBF, Chassis_LBR);
		osDelay(1000);
		DriveChannel(-255, Chassis_RFF, Chassis_RFR);
		osDelay(1000);
		DriveChannel(-255, Chassis_RBF, Chassis_RBR);
		osDelay(1000);
		osDelay(1000);
		osDelay(1000);
		osDelay(1000);
		osDelay(1000);
		osDelay(1000);
		/*
		Drive(255,255); // forward
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(255,0); // right forward
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(255,-255); // right
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(0,-255); // right backward
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(-255, -255); // backward
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(-255, 0); // left backward
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(-255, 255); // left
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		Drive(0, 255); // left forward
		osDelay(1000);
		Drive(0,0); // stop
		osDelay(1000);
		*/
	}
}
