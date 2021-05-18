#include "Environment.h"
#include "Init.h"
#include "Infrastructure.h"

void Init(void) {
	SystemCoreClockUpdate();
	InitClock();
	InitGPIO(); // must be before init of switch
	InitBusTimer(); // uses interrupt, must be before init of interrupt
	InitUART2(); // uses interrupt, must be before init of interrupt
	InitInterrupt();
	InitLED(); // does not use interrupt
	InitPWM(); // does not use interrupt
	InitDAC(); // does not use interrupt
	InitRTOSVariables(); // init rtos-variables
}

void InitClock(void) {
	// Enable Clock to PORTA, B, C, D, E.
	SIM->SCGC5 |= ((SIM_SCGC5_PORTA_MASK) | (SIM_SCGC5_PORTB_MASK) | (SIM_SCGC5_PORTC_MASK) | (SIM_SCGC5_PORTD_MASK) | (SIM_SCGC5_PORTE_MASK));
}

void InitGPIO(void) {
	// PWM Pins
	PORTA->PCR[PTA5_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTA->PCR[PTA5_Pin] |= PORT_PCR_MUX(3);
	PORTA->PCR[PTA4_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTA->PCR[PTA4_Pin] |= PORT_PCR_MUX(3);
	
	PORTB->PCR[PTB0_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[PTB0_Pin] |= PORT_PCR_MUX(3);
	PORTB->PCR[PTB1_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[PTB1_Pin] |= PORT_PCR_MUX(3);
	PORTB->PCR[PTB2_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[PTB2_Pin] |= PORT_PCR_MUX(3);
	PORTB->PCR[PTB3_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[PTB3_Pin] |= PORT_PCR_MUX(3);
	
	PORTC->PCR[PTC9_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTC->PCR[PTC9_Pin] |= PORT_PCR_MUX(3);
	PORTC->PCR[PTC8_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTC->PCR[PTC8_Pin] |= PORT_PCR_MUX(3);

	// Music Pins
	PORTE->PCR[DAC_Pin] &= ~PORT_PCR_MUX_MASK;
	PORTE->PCR[DAC_Pin] |= PORT_PCR_MUX(0);

	// LED Pins
	PORTB->PCR[RED_LED] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[RED_LED] |= PORT_PCR_MUX(1);
	
	PORTB->PCR[GREEN_LED] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[GREEN_LED] |= PORT_PCR_MUX(1);
	
	PORTD->PCR[BLUE_LED] &= ~PORT_PCR_MUX_MASK;
	PORTD->PCR[BLUE_LED] |= PORT_PCR_MUX(1);
}

void InitInterrupt(void) {
	NVIC_SetPriority(PIT_IRQn, 1);	// set timer interrupt priority to 1
	NVIC_ClearPendingIRQ(PIT_IRQn);	// clears pending IRQ for PIT
	NVIC_EnableIRQ(PIT_IRQn);				// enables PIT interrupt in NVIC (timer)
	
	NVIC_SetPriority(UART2_IRQn, 0); // set UART interrupt to very high priority
	NVIC_ClearPendingIRQ(UART2_IRQn); // clears pending IRQ for UART2
	NVIC_EnableIRQ(UART2_IRQn); // enables UART2 interrupts
}

void InitUART2() {
	uint32_t divisor;
	SIM->SCGC4 |= SIM_SCGC4_UART2_MASK; // clock to UART2
	
	PORTE->PCR[UART_TX_PORTE22] &= ~PORT_PCR_MUX_MASK;
	PORTE->PCR[UART_TX_PORTE22] |= PORT_PCR_MUX(4); // connect uart to PTE22
	
	PORTE->PCR[UART_RX_PORTE23] &= ~PORT_PCR_MUX_MASK;
	PORTE->PCR[UART_RX_PORTE23] |= PORT_PCR_MUX(4); // connect uart to PTE23
	
	UART2->C2 &= ~((UART_C2_TE_MASK) | (UART_C2_RE_MASK)); // disable TE and RE before configuration
	
	divisor = (uint32_t)BUS_CLOCK_MAX / ((uint32_t)BAUD_RATE * 16);
	UART2->BDH = UART_BDH_SBR(divisor >> 8);
	UART2->BDL = UART_BDL_SBR(divisor);
	
	UART2->C1 = 0; // no parity, 8 bits
	UART2->S2 = 0;
	UART2->C3 = 0;
	
	UART2->C2 |= ((UART_C2_TE_MASK)|(UART_C2_RE_MASK)|(UART_C2_TIE_MASK)|(UART_C2_RIE_MASK));
}

void InitLED(void) {
	// Set Data Direction Registers for PortB and PortD LEDs
	//PORTC->PCR[green_led_segment[0]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[0]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[1]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[1]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[2]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[2]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[3]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[3]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[4]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[4]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[5]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[5]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[6]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[6]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[green_led_segment[7]] &= ~PORT_PCR_MUX_MASK;
  PORTC->PCR[green_led_segment[7]] |= PORT_PCR_MUX(1);
  //PORTC->PCR[PTC12_Pin] &= ~PORT_PCR_MUX_MASK;
  PORTA->PCR[PTA17_Pin] |= PORT_PCR_MUX(1);
	
	PTA->PDDR |= MASK(PTA17_Pin);
	PTB->PDDR |= (MASK(RED_LED) | MASK(GREEN_LED));
	PTC->PDDR |= (MASK(green_led_segment[0]) | MASK(green_led_segment[1]) | MASK(green_led_segment[2]) | MASK(green_led_segment[3]) | MASK(green_led_segment[4]) |
		MASK(green_led_segment[5]) | MASK(green_led_segment[6]) | MASK(green_led_segment[7]));
	PTD->PDDR |= MASK(BLUE_LED);
	Led_Control(RED);
	turnOffGreen();
	turnOffRed();
}

void InitPWM(void) {
	SIM->SCGC6 |= SIM_SCGC6_TPM0_MASK | SIM_SCGC6_TPM1_MASK | SIM_SCGC6_TPM2_MASK;
	
	SIM->SOPT2 &= ~SIM_SOPT2_TPMSRC_MASK;
	SIM->SOPT2 |= SIM_SOPT2_TPMSRC(1);
	
	// Motor
	TPM0->SC &= ~((TPM_SC_CMOD_MASK) | (TPM_SC_PS_MASK));
	TPM0->SC |= (TPM_SC_CMOD(1) | TPM_SC_PS(COUNTER_PS)); // Mod 128
	TPM0->SC &= ~(TPM_SC_CPWMS_MASK); // Edge Alligned
	
	TPM0_C1SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM0_C1SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	TPM0_C2SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM0_C2SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	TPM0_C4SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM0_C4SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	TPM0_C5SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM0_C5SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	
	TPM0->MOD = MOTOR_PWM_PERIOD;

	TPM0_C1V = 0;//A4
	TPM0_C2V = 0;//A5
	TPM0_C4V = 0;//C8
	TPM0_C5V = 0;//C9
	
	TPM1->SC &= ~((TPM_SC_CMOD_MASK) | (TPM_SC_PS_MASK));
	TPM1->SC |= (TPM_SC_CMOD(1) | TPM_SC_PS(COUNTER_PS)); // Mod 128
	TPM1->SC &= ~(TPM_SC_CPWMS_MASK); // Edge Alligned
	
	TPM1_C0SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM1_C0SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	TPM1_C1SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM1_C1SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	
	TPM1->MOD = MOTOR_PWM_PERIOD; // Edge-Alligned: period=MOD+1 cycles. Centre-Alligned: period=2MOD cycles
		
	TPM1_C0V = 0;//B0
	TPM1_C1V = 0;//B1
	
	TPM2->SC &= ~((TPM_SC_CMOD_MASK) | (TPM_SC_PS_MASK));
	TPM2->SC |= (TPM_SC_CMOD(1) | TPM_SC_PS(COUNTER_PS)); // Mod 128
	TPM2->SC &= ~(TPM_SC_CPWMS_MASK); // Edge Alligned
	
	TPM2_C0SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM2_C0SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));
	TPM2_C1SC &= ~((TPM_CnSC_ELSB_MASK) | (TPM_CnSC_ELSA_MASK) | (TPM_CnSC_MSB_MASK) | (TPM_CnSC_MSA_MASK));
	TPM2_C1SC |= (TPM_CnSC_ELSB(1) | TPM_CnSC_MSB(1));

	TPM2->MOD = MOTOR_PWM_PERIOD;
	
	TPM2_C0V = 0;//B2
	TPM2_C1V = 0;//B3
	
	// Music
}

void InitBusTimer(void) {
	SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
	PIT->MCR &= ~PIT_MCR_MDIS_MASK;		// enables the periodic interrupt clock
	PIT->CHANNEL[0].LDVAL |= PIT_STARTING_VALUE; // sets the period of the PIT
	PIT->CHANNEL[0].TCTRL |= PIT_TCTRL_TIE_MASK | PIT_TCTRL_TEN_MASK;	//enables timer for channel 0
}

void InitDAC(void) {
	SIM_SCGC6 |= SIM_SCGC6_DAC0_MASK; // clock
  DAC0_C0 |= DAC_C0_DACEN_MASK | DAC_C0_DACRFS_MASK | DAC_C0_LPEN_MASK | DAC_C0_DACTRGSEL_MASK;
}

void InitRTOSVariables(void) {
	uartTXQ = osMessageQueueNew(MSG_COUNT, sizeof(uint8_t), NULL);
	uartRXQ = osMessageQueueNew(MSG_COUNT, sizeof(uint8_t), NULL);
	ledQ = osMessageQueueNew(MSG_COUNT, sizeof(Command), NULL);
	musicQ = osMessageQueueNew(MSG_COUNT, sizeof(Command), NULL);
	motorQ = osMessageQueueNew(MSG_COUNT, sizeof(Command), NULL);
	controlQ = osMessageQueueNew(MSG_COUNT, sizeof(Command), NULL);
}
