#ifndef ONBOARDLED_FLAG
#define ONBOARDLED_FLAG

#include "GPIO.h"

extern const Pin ONBOARDLED_PIN_R;
extern const Pin ONBOARDLED_PIN_G;
extern const Pin ONBOARDLED_PIN_B;
extern const uint8_t ONBOARDLED_REFRESH_RESOLUTION_MS;
extern const uint8_t ONBOARDLED_BITS;
extern const uint8_t ONBOARDLED_COLOR_CHANGE_TIME_MS;

void OnboardLED_Update(PIN_VALUE R, PIN_VALUE G, PIN_VALUE B);

void OnboardLED_UpdateColorOnceAsync(uint8_t R, uint8_t G, uint8_t B);

void OnboardLED_ChangeColorOnceAsync(uint8_t R, uint8_t G, uint8_t B);

#endif
