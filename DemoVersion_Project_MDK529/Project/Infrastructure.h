#ifndef INFRASTRUCTURE_FLAG
#define INFRASTRUCTURE_FLAG // Flag: Defined Infrastructure

#include "MKL25Z4.h"            // Device header
#include "Data.h"

void Led_Control(led_color color_enum);
void Led_Control_RedOnly(int onoff);
void Led_Control_GreenOnly(int onoff);
void Led_Control_BlueOnly(int onoff);
void turnOffGreen(void);
void turnOnGreen(void);
void turnOffRed(void);
void turnOnSingleLedPin(int pinLocation);
void DriveMotor(motor_type type, int isForward, int power);
void ToneStart(int frequency, float power);
void ToneStop(void);
void UART2_ReenableTX(void);
void StupidDelay(volatile uint32_t);
void SetDACValue(uint16_t data);

#endif
