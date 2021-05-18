#include "Init.h"

void InitGPIO(void)
{
	ClockToPorts(Ports);
	
	//SelectPinsFunctions(MusicPins);
	//SetPinsDirections(MusicPins, PIN_OUTPUT);
	
	SelectPinsFunctions(OnboardLED_Pins);
	SetPinsDirections(OnboardLED_Pins, PIN_OUTPUT);
	AnalogOutputEnable();
	
	SelectPinsFunctions(InputPins);
	SetPinsDirections(InputPins, PIN_INPUT);
	AnalogInputEnable(ADC_16BIT, ADC_AVG_DISABLED);
	
	SelectPinsFunctions(ExternalDAC_Pins);
	SetPinsDirections(ExternalDAC_Pins, PIN_OUTPUT);
	
	SelectPinsFunctions(MotorPins);
	SetPinsDirections(MotorPins, PIN_OUTPUT);
}

void Init(void)
{
	SystemCoreClockUpdate();
	InitGPIO();
	InitMusic(PIT_CHANNEL0);
	InitChassis();
	ChooseTrack(1);
	InitInterrupt();
	
	osKernelInitialize();
}

void InitInterrupt(void) {
	NVIC_SetPriority(PIT_IRQn, 1);	// set timer interrupt priority to 1
	NVIC_ClearPendingIRQ(PIT_IRQn);	// clears pending IRQ for PIT
	NVIC_EnableIRQ(PIT_IRQn);				// enables PIT interrupt in NVIC (timer)
	
	//NVIC_SetPriority(UART2_IRQn, 0); // set UART interrupt to very high priority
	//NVIC_ClearPendingIRQ(UART2_IRQn); // clears pending IRQ for UART2
	//NVIC_EnableIRQ(UART2_IRQn); // enables UART2 interrupts
}
