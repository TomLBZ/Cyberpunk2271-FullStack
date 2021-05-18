#ifndef MUSIC_FLAG
#define MUSIC_FLAG

#include "GPIO.h"
#include "PIT.h"
#include "ConstantDefinitions.h"

extern const Pin MUSIC_PIN;
extern const Pin ExternalDAC_Pins[];
extern const uint32_t MUSIC_SAMPLE_FREQUENCY;
extern const uint8_t MUSIC_INTERPOLATION_RATIO;
extern volatile uint8_t MUSIC_CHOICE;

void InitMusic(PIT_CHANNEL channel);
void ChooseTrack(uint8_t choice);
void MusicNextSignal(void);

static const uint8_t MUSIC_TRACK1[_MUSIC_TRACK1_SECTIONS][_MUSIC_SECTION_LENGTH1];
static const uint8_t MUSIC_TRACK2[_MUSIC_TRACK2_SECTIONS][_MUSIC_SECTION_LENGTH2];
static const uint8_t MUSIC_TRACK3[_MUSIC_TRACK3_SECTIONS][_MUSIC_SECTION_LENGTH3];
#endif
