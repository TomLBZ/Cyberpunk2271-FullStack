#include "OnboardLED.h"
#include "Macros.h"
#include "cmsis_os2.h"


void OnboardLED_Update(PIN_VALUE R, PIN_VALUE G, PIN_VALUE B)
{
	DigitalWritePin(ONBOARDLED_PIN_R, R);
	DigitalWritePin(ONBOARDLED_PIN_G, G);
	DigitalWritePin(ONBOARDLED_PIN_B, B);
}

void OnboardLED_UpdateColorOnceAsync(uint8_t R, uint8_t G, uint8_t B) {
	uint8_t cycles = MASK(ONBOARDLED_BITS) - 1;
	for (uint8_t i = 0; i < cycles; i++)
	{
		OnboardLED_Update(R > i ? LOW : HIGH, G > i ? LOW : HIGH, B > i ? LOW : HIGH);
		osDelay(ONBOARDLED_REFRESH_RESOLUTION_MS);
	}
}

void OnboardLED_ChangeColorOnceAsync(uint8_t R, uint8_t G, uint8_t B)
{
	uint8_t red = R - (uint8_t)((uint8_t)(R >> ONBOARDLED_BITS) << ONBOARDLED_BITS);
	uint8_t green = G - (uint8_t)((uint8_t)(G >> ONBOARDLED_BITS) << ONBOARDLED_BITS);
	uint8_t blue = B - (uint8_t)((uint8_t)(B >> ONBOARDLED_BITS) << ONBOARDLED_BITS);
	uint8_t cycles = MASK(ONBOARDLED_BITS) - 1;
	uint8_t timeleft = ONBOARDLED_COLOR_CHANGE_TIME_MS;
	while (timeleft >= cycles)
	{
		OnboardLED_UpdateColorOnceAsync(red, green, blue);
		timeleft -= cycles;
	}
}
