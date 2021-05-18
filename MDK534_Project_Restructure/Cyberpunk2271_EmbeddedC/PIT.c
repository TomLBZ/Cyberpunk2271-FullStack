#include "PIT.h"

static void (*channel0_task)();
static void (*channel1_task)();

void InitPIT(PIT_CHANNEL channel, void(*task_function)())	
{
	SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;	// enables PIT
	PIT->MCR &= ~PIT_MCR_MDIS_MASK;		// enables the periodic interrupt clock
	switch (channel)
	{
		case PIT_CHANNEL0:
			PIT_LDVAL0 = PIT_PERIOD;
			PIT_TCTRL0 |= PIT_TCTRL_TIE_MASK | PIT_TCTRL_TEN_MASK; // interrupt + timer enable
			channel0_task = task_function;
			break;
		case PIT_CHANNEL1:
			PIT_LDVAL1 = PIT_PERIOD;
			PIT_TCTRL1 |= PIT_TCTRL_TIE_MASK | PIT_TCTRL_TEN_MASK;
			channel1_task = task_function;
			break;
	}
}

void PIT_IRQHandler(void) {
	// Clear pending interrupts
	NVIC_ClearPendingIRQ(PIT_IRQn);
	if (PIT_TFLG0) 
	{
		PIT_TFLG0 = PIT_TFLG_TIF_MASK;
		channel0_task();
	}
	if (PIT_TFLG1) 
	{
		PIT_TFLG1 = PIT_TFLG_TIF_MASK;
		channel1_task();
	}
}
