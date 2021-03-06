//SYSTEM SPECIFICATION
/*In order to control the screen and the game itself two 32bit gpio ports are used.
 *	gpio 1: chooses active screen, displays highlight on icons, shows brackets on currently selected
 *	game speed and controls ball movement
 *	gpio 2: is in control of palette movement
 *
 *	Control bit distribution is as follows (from MSB to LSB):
 *	gpio1:
 *	31-29: 3 bits for screen selection
 *	28-27: 2 bits for icon highlight
 *	26-25: 2 bits for game speed selection
 *	24-22: 3 unused bits
 *	21-11: 11 bits for ball Y position
 *	10-0 : 11 bits for ball X position.
 *
 *	gpio2:
 *	31-30: 2  unused bits
 *	29-26: 4  bits for left score
 *	25-22: 4  bits for right score
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
 *	4 - Player 1 wins
 *	5 - Player 2 wins
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
#include "sleep.h"

#include "keyboard.h"
#include "game.h"
#include "credits.h"
#include "options.h"
#include "endgame.h"

//------------------------------------------------------------------------------------------------------------------------------------
//DEFINES


//------------------------------------------------------------------------------------------------------------------------------------
//GLOBAL VARIABLES

XGpio gpio;
uint32_t gpio_output, gpio2_output;
uint8_t icon_highlighter = 0x000;

//------------------------------------------------------------------------------------------------------------------------------------
//FUNCTION DECLARATIONS (TO BE SENT TO LIBRARIES)

void Init(void);
void SendMenu(uint8_t);

//------------------------------------------------------------------------------------------------------------------------------------
// MAIN LOOP

int main(){

	uint8_t GameSpeed 	  = MEDIUM;
	enum KeyStatus eKeyStatus;
	Init();
	eScreenMode = MENU;

	while(1){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == W) {
			icon_highlighter = (icon_highlighter+3)%4;
		}
		else if(eKeyStatus == S) {
			icon_highlighter = (icon_highlighter+1)%4;
		}
		else if(eKeyStatus == ENTER){
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
			else {}
		}
		else if(eKeyStatus == ESC){
		}
		else{
		}

		SendMenu(icon_highlighter);
		usleep(2500);
	}
}

//------------------------------------------------------------------------------------------------------------------------------------
//FUNCTION DEFINITIONS (TO BE SENT TO LIBRARIES)

void Init(void){
	icon_highlighter = 0x000;
	XGpio_Initialize(&gpio, 0);
	gpio_output  = 0x00000000;
	gpio2_output = 0x000C0180;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
	XGpio_DiscreteWrite(&gpio, 2, gpio2_output);
}

void SendMenu(uint8_t icon_highlighter){
	gpio_output = eScreenMode<<29;
	gpio_output = gpio_output | (icon_highlighter<<27);

	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}

//------------------------------------------------------------------------------------------------------------------------------------
//ARCHIVES

