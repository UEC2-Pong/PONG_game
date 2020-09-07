//SYSTEM SPECIFICATION
/*In order to control the screen and the game itself two 32bit gpio ports are used.
 *	gpio 1: chooses active screen, displays highlight on icons, shows brackets on currently selected
 *	game speed and controls ball movement
 *	gpio 2: is in control of palette movement
 *
 *	Control bit distribution is as follows (from MSB to LSB):
 *	gpio1:
 *	31-30: 2 bits for screen selection
 *	29-28: 2 bits for icon highlight
 *	27-26: 2 bits for game speed selection
 *	25-22: 4 unused bits
 *	21-11: 11 bits for ball Y position
 *	10-0 : 11 bits for ball X position.
 *
 *	gpio2:
 *	31-22: 10 unused bits
 *	21-11: 11 bits for left palette position
 *	10-0 : 11 bits for right palette position
 *
 *	Unless in Game screen changes to palette and ball bits are not visible, but might determine starting
 *	positions for both players and the ball.
 *	GAME SPEED IS SELECTED VIA SOFTWARE. Game speed bits sent via gpio1 ONLY show brackets in Options screen.
 *	These should correspond with game speed selected in software.
 *
 *	Screen selection codes:
 *	0 - Menu
 *	1 - Game (both single and multiplayer, differences between the two are software based)
 *	2 - Credits
 *	3 - Options
 *
 *	Icon highlighter codes: TOP icon has code 0. Increment to reach each icon downward.
 *
 *	Game speed codes:
 *	0 - Fast
 *	1 - Medium
 *	2 - Slow
 *	3 - Possible to send, but unused
 *
 *	Screen resolution is 1024x768
 */
// includes
#include "xil_types.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xuartlite_l.h"
#include "xil_printf.h"
#include "sleep.h"

//------------------------------------------------------------------------------------------------------------------------------------
//DEFINES
#define FAST 	5
#define MEDIUM 	3
#define SLOW 	1
//------------------------------------------------------------------------------------------------------------------------------------
//GLOBAL VARIABLES

XGpio gpio;
uint32_t gpio_output, gpio2_output;
enum ScreenMode {MENU, GAME, CREDITS, OPTIONS} eScreenMode = MENU;		//MENU   set as initial screen

enum GameMode 	{SINGLEPLAYER, MULTIPLAYER};
enum KeyStatus  {RELEASED, W, S, ARROW_UP, ARROW_DOWN, ENTER, ESC};

//------------------------------------------------------------------------------------------------------------------------------------
//FUNCTION DECLARATIONS (TO BE SENT TO LIBRARIES)

void Init(void);
void Game(enum GameMode, uint8_t);
void SendGame(uint16_t, uint16_t, uint16_t, uint16_t);
void Credits(void);
void Options(uint8_t *);
void SendOptions(uint8_t, uint8_t);
void SendCredits(void);
void SendMenu(uint8_t);
enum KeyStatus CheckingForKeys(uint32_t);

//------------------------------------------------------------------------------------------------------------------------------------
// MAIN LOOP

int main(){

	uint8_t icon_highlighter = 0x00;
	uint8_t GameSpeed 	  = MEDIUM;
	enum KeyStatus eKeyStatus;
	Init();

	while(1){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == W) {
			icon_highlighter = (icon_highlighter+3)%4;
			xil_printf("pressed: 'w' ");
		}
		else if(eKeyStatus == S) {
			icon_highlighter = (icon_highlighter+1)%4;
			xil_printf("pressed: 's' ");
		}
		else if(eKeyStatus == ENTER){
			xil_printf("pressed: 'enter' ");
			if	   ( icon_highlighter == 0 ) {
				eScreenMode = GAME;
				Game(SINGLEPLAYER, GameSpeed);
			}
			else if( icon_highlighter == 1 ) {
				eScreenMode = GAME;
				Game(MULTIPLAYER, GameSpeed);
			}
			else if( icon_highlighter == 2 ) {
				eScreenMode = CREDITS;
				Credits();
			}
			else if( icon_highlighter == 3 ) {
				eScreenMode = OPTIONS;
				Options(&GameSpeed);
			}
			else xil_printf("ERROR ");
		}
		else if(eKeyStatus == ESC){
			xil_printf("pressed: 'esc' ");
		}
		else{
		}

		SendMenu(icon_highlighter);
		usleep(2500);
	}
}

//------------------------------------------------------------------------------------------------------------------------------------
//FUNCTION DEFINITIONS (TO BE SENT TO LIBRARIES)

enum KeyStatus CheckingForKeys(uint32_t baseaddr) {
	if(!XUartLite_IsReceiveEmpty(baseaddr)){
		uint8_t ReceivedKey;
		ReceivedKey = XUartLite_RecvByte(baseaddr);
		if 		(ReceivedKey == 'w') return W;
		else if (ReceivedKey == 's') return S;
		else if (ReceivedKey == 38)  return ARROW_UP;
		else if (ReceivedKey == 40)  return ARROW_DOWN;
		else if (ReceivedKey == 13)  return ENTER;
		else if (ReceivedKey == 27)  return ESC;
		else return RELEASED;
	}
	else{
		return RELEASED;
	}
}

void Init(void){
	XGpio_Initialize(&gpio, 0);
	gpio_output  = 0x00000000;
	gpio2_output = 0x000C0180;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
	XGpio_DiscreteWrite(&gpio, 2, gpio2_output);
}

void SendMenu(uint8_t icon_highlighter){
	gpio_output = eScreenMode<<30;
	gpio_output = gpio_output | (icon_highlighter<<28);

	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}


void Game(enum GameMode eGameMode, uint8_t GameSpeed){
	enum KeyStatus eKeyStatus;
	uint16_t left_palette  = 0x180;
	uint16_t right_palette = 0x180;
	uint16_t ball_xpos	   = 0x200;
	uint16_t ball_ypos	   = 0x180;

	while(eScreenMode == GAME){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == ESC){
			eScreenMode 	 = MENU;
			xil_printf("pressed: 'esc' ");
		}
		else if(eKeyStatus == W) {
			left_palette = left_palette - GameSpeed;
			right_palette = right_palette - GameSpeed;
			xil_printf("pressed: 'w' ");
		}
		else if(eKeyStatus == S) {
			left_palette = left_palette + GameSpeed;
			right_palette = right_palette + GameSpeed;
			xil_printf("pressed: 'w' ");
		}
		else {}
		SendGame(left_palette, right_palette, ball_xpos, ball_ypos);
	}
}

void SendGame(uint16_t left_palette, uint16_t right_palette, uint16_t ball_xpos, uint16_t ball_ypos){
	gpio_output = eScreenMode<<30;
	gpio_output = gpio_output | (ball_ypos<<11) | ball_xpos;

	gpio2_output = right_palette;
	gpio2_output = gpio2_output | (left_palette << 11);

	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
	XGpio_DiscreteWrite(&gpio, 2, gpio2_output);
}

void Credits(void){
	enum KeyStatus eKeyStatus;

	while( eScreenMode == CREDITS){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == ESC){
			eScreenMode  	 = MENU;
			xil_printf("pressed: 'esc' ");
		}
		else {}
	SendCredits();
	usleep(2500);
	}
}

void SendCredits(void){
	gpio_output = eScreenMode<<30;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}

void Options(uint8_t *GameSpeed){
	enum KeyStatus eKeyStatus;
	uint8_t aSpeedValue[3] = {FAST, MEDIUM, SLOW};
	uint8_t icon_highlighter = 0x01;
	static uint8_t GameSpeedCode = 1;

	while(eScreenMode == OPTIONS){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == W) {
			icon_highlighter = (icon_highlighter+2)%3;
			xil_printf("pressed: 'w' ");
		}
		else if(eKeyStatus == S) {
			icon_highlighter = (icon_highlighter+1)%3;
			xil_printf("pressed: 's' ");
		}
		else if(eKeyStatus == ENTER){
			GameSpeedCode = icon_highlighter;
			*GameSpeed 	  = aSpeedValue[icon_highlighter];
			xil_printf("pressed: 'enter' ");
		}
		if(eKeyStatus == ESC){
			eScreenMode 	 = MENU;
			icon_highlighter = 3;
			xil_printf("pressed: 'esc' ");
		}
		else {}
		SendOptions(GameSpeedCode, icon_highlighter);
		usleep(2500);
	}
}

void SendOptions(uint8_t GameSpeedCode, uint8_t icon_highlighter){
	gpio_output = eScreenMode<<30;
	gpio_output = gpio_output | (icon_highlighter<<28);
	gpio_output = gpio_output | (GameSpeedCode<<26);
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}

//------------------------------------------------------------------------------------------------------------------------------------
//ARCHIVES

