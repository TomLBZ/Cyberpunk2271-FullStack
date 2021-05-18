#include "Environment.h"
#include "Infrastructure.h"

void Led_Control(led_color color) {
	switch(color) {
		case RED:
			PTB->PSOR = MASK(GREEN_LED); // set green to 1
			PTD->PSOR = MASK(BLUE_LED); // set blue to 1
			PTB->PCOR = MASK(RED_LED); // clear red to 0, because led pins are active-low
			break;
		case GREEN:
			PTB->PSOR = MASK(RED_LED);
			PTD->PSOR = MASK(BLUE_LED);
			PTB->PCOR = MASK(GREEN_LED);
			break;
		case BLUE:
			PTB->PSOR = MASK(RED_LED);
			PTB->PSOR = MASK(GREEN_LED);
			PTD->PCOR = MASK(BLUE_LED);
			break;
		case NONE: // NONE
			PTB->PSOR = MASK(RED_LED); // set red to 1
			PTB->PSOR = MASK(GREEN_LED); // set green to 1
			PTD->PSOR = MASK(BLUE_LED); // set blue to 1
			break;
	}
}

void Led_Control_RedOnly(int onoff) {
	if (onoff) PTB->PCOR = MASK(RED_LED); // clear red to 0, because led pins are active-low
	else 			 PTB->PSOR = MASK(RED_LED); // set red to 1
}

void Led_Control_GreenOnly(int onoff) {
	if (onoff) PTB->PCOR = MASK(GREEN_LED); // clear red to 0, because led pins are active-low
	else 			 PTB->PSOR = MASK(GREEN_LED); // set red to 1
}
void Led_Control_BlueOnly(int onoff) {
	if (onoff) PTD->PCOR = MASK(BLUE_LED); // clear red to 0, because led pins are active-low
	else 			 PTD->PSOR = MASK(BLUE_LED); // set red to 1
}

void turnOffGreen(void) {
  PTC->PCOR |= (MASK(green_led_segment[0]) | MASK(green_led_segment[1]) | MASK(green_led_segment[2]) | MASK(green_led_segment[3]) | MASK(green_led_segment[4]) |
  MASK(green_led_segment[5]) | MASK(green_led_segment[6]) | MASK(green_led_segment[7]));
}

void turnOnGreen(void) {
  PTC->PDOR |= (MASK(green_led_segment[0]) | MASK(green_led_segment[1]) | MASK(green_led_segment[2]) | MASK(green_led_segment[3]) | MASK(green_led_segment[4]) |
  MASK(green_led_segment[5]) | MASK(green_led_segment[6]) | MASK(green_led_segment[7]));
}

void turnOffRed(void) {
  PTA->PCOR |= MASK(PTA17_Pin);
}

void turnOnSingleLedPin(int pinLocation) {
  PTC->PDOR |= MASK(pinLocation);
}

void DriveMotor(motor_type type, int isForward, int power) {
	int p = MOTOR_PWM_PERIOD;
	uint32_t width = (uint32_t)(p * power / MAX_POWER);
	switch (type) {
		case LF:
			if (isForward) {TPM2_C1V = width; TPM2_C0V = 0;}
			else {TPM2_C0V = width; TPM2_C1V = 0;}
			break;
		case LB:
			if (isForward) {TPM1_C0V = width; TPM1_C1V = 0;}
			else {TPM1_C1V = width; TPM1_C0V = 0;}
			break;
		case RF:
			if (isForward) {TPM0_C4V = width; TPM0_C5V = 0;}
			else {TPM0_C5V = width; TPM0_C4V = 0;}
			break;
		case RB:
			if (isForward) {TPM0_C2V = width; TPM0_C1V = 0;}
			else {TPM0_C1V = width; TPM0_C2V = 0;}
			break;
	}
}

void ToneStart(int f, float power) {
	int radian = _dac_tick_ / 6; // 1 rad per ms, current time / radian (to be devided by 1024 later)
	int angle = (radian * f) >> 10;
	int abs_angle = angle > 0 ? angle : -angle;
	float smallAng = (float)abs_angle / 100;
	float ang = smallAng - (int)smallAng; 
	float actualPower = power * 2047 * ang + 2047; // 2047
	SetDACValue((uint16_t)actualPower);
}

void ToneStop(void) {
	SetDACValue((uint16_t)(DAC_LEVELS >> 1));
}

void UART2_ReenableTX(void) {
			UART2->C2 |= UART_C2_TIE_MASK;
}

void StupidDelay(volatile uint32_t nof) {
	while (nof!=0) {
		__ASM("NOP");
		nof--;
	}
}

void SetDACValue(uint16_t data) {
    DAC0_DATL(0) = data & 0x00ff;
    DAC0_DATH(0) = data >> 8;
    DAC0_C0 |= DAC_C0_DACSWTRG_MASK;
}
