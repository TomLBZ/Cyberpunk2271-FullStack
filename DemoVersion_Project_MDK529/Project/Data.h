// Data Types Declarations:
#ifndef DATA_FLAG
#define DATA_FLAG // Flag: Defined Data Types

#include "MKL25Z4.h"            // Device header

// Enumerations
typedef enum led_color_t {RED, GREEN, BLUE, NONE} led_color;
typedef enum music_mode_t {
	C = 262, 
	SC = 277, 
	D = 294, 
	SD = 311, 
	E = 330, 
	F = 349, 
	SF = 370, 
	G = 392, 
	SG = 415, 
	A = 440, 
	SA = 466, 
	B = 494
} music_mode;
typedef enum command_type_t {
	CMD_LED = 1, 
	CMD_MUS = 2, 
	CMD_MOT = 3, 
	CMD_EXT = 0
} command_type;
typedef enum motor_t {
	LF,
	LB,
	RF,
	RB
} motor_type;
typedef enum movingStatus_t {
	CONNECTED, 
	MOVING, 
	STOPPED, 
	IDLE
} movingStatus;

//Structures
typedef struct Note_t {
	int index; // eg. 1, 2, 3, etc.
	int offset; // only -2, -1, 0, 1, 2.
	int raise; // only -1, 0, 1.
	int duration_ms;
} Note;
Note composeNote(char * token, int noteLength);

typedef struct Music_t {
	int npm;
	music_mode mode;
	char * script;
} Music;

typedef struct Cmd_t {
	int instruction;
	command_type type;
} Command;
Command ParseCommand(uint16_t raw);
Command ParseSegmentedCommand(uint8_t raw1, uint8_t raw2);
Command CreateLEDCommand(uint8_t r_4bit, uint8_t g_4bit, uint8_t b_4bit);
uint16_t CommandToInt16(Command command);

#endif
