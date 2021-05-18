#include "Main.h"

int main(void) 
{
	Init();
	osThreadNew(thread_analog_inputs, NULL, NULL);
	//osThreadNew(thread_onboard_led, NULL, NULL);
	//osThreadNew(thread_music, NULL, NULL);
	osThreadNew(thread_chassis, NULL, NULL);
	osKernelStart();
	for (;;) {}
}
