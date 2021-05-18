#include "Environment.h"
#include "Interrupts.h"
#include "Infrastructure.h"
	
void PIT_IRQHandler(void) {
	// Clear pending interrupts
	NVIC_ClearPendingIRQ(PIT_IRQn);
	if (PIT_TFLG_REG(PIT, 0)) {
		PIT_TFLG_REG(PIT, 0) = PIT_TFLG_TIF_MASK;
		_dac_tick_++;
	}
}

void UART2_IRQHandler(void) {
	NVIC_ClearPendingIRQ(UART2_IRQn); // prevent re-triggering
	if (UART2->S1 & UART_S1_TDRE_MASK) { // transmit ready
		uint8_t t_data;
		osMessageQueueGet(uartTXQ, &t_data, NULL, 0);
		if (t_data) { // has data to send in queue
			UART2->D = t_data; // send data
		} else {
			UART2->C2 &= ~UART_C2_TIE_MASK; // queue empty, disable tx interrupt
		}
	}
	if (UART2->S1 & UART_S1_RDRF_MASK) { // receive ready
		uint8_t r_data = UART2->D;
		osMessageQueuePut(uartRXQ, &r_data, NULL, 0);
	}
	if (UART2->S1 & (UART_S1_OR_MASK | UART_S1_NF_MASK | UART_S1_FE_MASK | UART_S1_PF_MASK)) {
		// special sequence to clear error flags
		// currently NOT handling these errors at all
		uint8_t temp = UART2->S1;
		temp = UART2->D;
	}
	osThreadFlagsSet(uart_Id, UART_THREAD_FLAG);
}
