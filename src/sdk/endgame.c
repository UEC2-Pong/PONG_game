// INCLUDES
#include "endgame.h"
#include "keyboard.h"
#include "game.h"

#include "xgpio.h"
#include "xparameters.h"
#include "xil_types.h"
#include "sleep.h"

// VARIABLES
XGpio gpio;
extern uint32_t gpio_output;

//FUNCTION DEFINITIONS

void Player1Wins(void){
	enum KeyStatus eKeyStatus;

	while(eScreenMode == PLAYER1){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == ESC){
			eScreenMode = MENU;
		}
		else {}
		SendEndGame();
		usleep(2500);
	}
}

void Player2Wins(void){
	enum KeyStatus eKeyStatus;

	while(eScreenMode == PLAYER2){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == ESC){
			eScreenMode = MENU;
		}
		else {}
		SendEndGame();
		usleep(2500);
	}
}

void SendEndGame(void){
    gpio_output = eScreenMode<<29;
	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
}

