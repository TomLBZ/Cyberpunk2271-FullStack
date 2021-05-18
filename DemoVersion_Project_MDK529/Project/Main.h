#ifndef MAIN_FLAG
#define MAIN_FLAG // Flag: Defined Main

#include "RTE_Components.h"
#include  CMSIS_device_header
#include "cmsis_os2.h"
#include "Global.h"
#include "Variables.h"

void uart_thread (void*);
void loop_worker_thread (void*);
void misc_thread (void*);
void led_thread (void*);
void music_thread (void*);
void motor_thread (void*);
void runningLED_thread (void*);

#endif
