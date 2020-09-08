// INCLUDES
#include "xil_types.h"
#include "xgpio.h"

#include "game.h"
#include "keyboard.h"


// VARIABLES
uint16_t left_palette  = 0x180;
uint16_t right_palette = 0x180;
uint16_t ball_xpos	   = 0x200;
uint16_t ball_ypos	   = 0x180;

XGpio gpio;
extern uint32_t gpio_output, gpio2_output;

// FUNCTION DEFINITIONS

void Game(enum GameMode eGameMode, uint8_t GameSpeed){
	enum KeyStatus eKeyStatus;

	while(eScreenMode == GAME){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eGameMode == SINGLEPLAYER){
			if(eKeyStatus == ESC){
				eScreenMode = MENU;
				ItemsPositionInit();
				xil_printf("pressed: 'esc' ");
			}
			else if(eKeyStatus == W) {
				left_palette = left_palette - GameSpeed;
				xil_printf("pressed: 'w' ");
			}
			else if(eKeyStatus == S) {
				left_palette = left_palette + GameSpeed;
				xil_printf("pressed: 'w' ");
			}
		}
		else if(eGameMode == MULTIPLAYER){
			if(eKeyStatus == ESC){
				eScreenMode = MENU;
				ItemsPositionInit();
				xil_printf("pressed: 'esc' ");
			}
			else if(eKeyStatus == W) {
				left_palette = left_palette - GameSpeed;
				xil_printf("pressed: 'w' ");
			}
			else if(eKeyStatus == S) {
				left_palette = left_palette + GameSpeed;
				xil_printf("pressed: 'w' ");
			}
			else if(eKeyStatus == I){
				right_palette = right_palette - GameSpeed;
				xil_printf("pressed: 'i' ");
			}
			else if(eKeyStatus == K){
				right_palette = right_palette + GameSpeed;
				xil_printf("pressed: 'k' ");
			}
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

void ItemsPositionInit(void){
	left_palette  = 0x180;
	right_palette = 0x180;
	ball_xpos	  = 0x200;
	ball_ypos	  = 0x180;
}
