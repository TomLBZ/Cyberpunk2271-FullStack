#ifndef INIT_FLAG
#define INIT_FLAG

#include "GPIO.h"
#include "PinDefinitions.h"
#include "cmsis_os2.h"
#include "Music.h"
#include "Chassis.h"

void InitGPIO(void);
void Init(void);
void InitInterrupt(void);

#endif
