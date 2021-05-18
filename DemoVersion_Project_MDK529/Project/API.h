#ifndef API_FLAG
#define API_FLAG // Flag: Defined API

#include "MKL25Z4.h"            // Device header
#include "Data.h"

void playTone(int frequency, float power, int duration_ms, int forceStop); // playTone(f,p,t)
int getNoteCount(char * script);
int getNoteFrequency(music_mode mode, Note note);
void playNote(music_mode mode, Note note, float power);
void playMusic(Music music, float power);
void handleCommand(Command command);
void instructLED(uint16_t led_instruction);
void instructMusic(uint16_t music_instruction);
void instructMotors(uint16_t motor_instruction);
void instruct(uint16_t instruction);
int getBits (int input, int highbit, int lowbit);

#endif
