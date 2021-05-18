#ifndef INIT_FLAG
#define INIT_FLAG // Flag: Defined Init

#include "MKL25Z4.h"            // Device header

void InitClock(void);
void InitGPIO(void);
void InitInterrupt(void);
void InitUART2(void);
void InitLED(void);
void InitPWM(void);
void InitBusTimer(void);
void InitDAC(void);
void InitRTOSVariables(void);
void Init(void);

#endif
