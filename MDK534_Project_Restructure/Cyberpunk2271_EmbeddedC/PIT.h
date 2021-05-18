#ifndef PIT_FLAG
#define PIT_FLAG

#include "stdint.h"
#include "MKL25Z4.h"

typedef enum PIT_CHANNEL_t
{
	PIT_CHANNEL0,
	PIT_CHANNEL1
} PIT_CHANNEL;

extern const uint32_t PIT_PERIOD;

void InitPIT(PIT_CHANNEL channel, void(*task_function)());
void PIT_IRQHandler(void);

#endif
