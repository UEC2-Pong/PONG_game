// INCLUDES
//----------------------------------------------------------------------------------------------------------------
#include "xil_types.h"
#include "xgpio.h"
#include "game.h"
#include "keyboard.h"
#include "endgame.h"
#include "math.h"
#include "sleep.h"

// DEFINES
//----------------------------------------------------------------------------------------------------------------
#define MULTIPLICATOR 			 1024
#define BALL_SPEED_MULTIPLICATOR 1
#define PALETTE_LENGTH			 100
#define PALETTE_WIDTH			 10
#define MAX_A					 2
// VARIABLES
//----------------------------------------------------------------------------------------------------------------
int16_t left_palette   = 0x180;
int16_t right_palette  = 0x180;
int16_t ball_xpos	   = 0x200;
int16_t ball_ypos	   = 0x180;
uint8_t left_score	   = 0;
uint8_t right_score	   = 0;
enum MovementDirection {LEFT, RIGHT};
enum LeftMovement	   {L_STOP, L_UP, L_DOWN};
enum RightMovement	   {R_STOP, R_UP, R_DOWN};
XGpio gpio;
extern uint32_t gpio_output, gpio2_output;

// FUNCTION DECLARATIONS
//----------------------------------------------------------------------------------------------------------------
void PaletteMovement(uint8_t, enum KeyStatus, enum GameMode);
void BallMovement(uint8_t);
void SendGame(int16_t, int16_t, int16_t, int16_t, uint8_t, uint8_t);
void GameInit(void);

// FUNCTION DEFINITIONS
//----------------------------------------------------------------------------------------------------------------
void Game(enum GameMode eGameMode, uint8_t GameSpeed){
	enum KeyStatus eKeyStatus;
	GameInit();

	while(eScreenMode == GAME){
		eKeyStatus = CheckingForKeys(XPAR_AXI_UARTLITE_0_BASEADDR);
		if(eKeyStatus == ESC){
			eScreenMode 	 = MENU;
			xil_printf("pressed: 'esc' ");
		}
		else if(left_score == 10){
			eScreenMode = PLAYER1;
			Player1Wins();
		}
		else if(right_score == 10){
			eScreenMode = PLAYER2;
			Player2Wins();
		}

		else {}
		PaletteMovement(GameSpeed, eKeyStatus, eGameMode);
		BallMovement(GameSpeed);
		SendGame(left_palette, right_palette, ball_xpos, ball_ypos, right_score, left_score);
		usleep(5000);
	}
}

void PaletteMovement(uint8_t GameSpeed, enum KeyStatus eKeyStatus, enum GameMode eGameMode){
	static enum LeftMovement  LeftMove  = L_STOP;
	static enum RightMovement RightMove = R_STOP;

	if	   (eKeyStatus == W) LeftMove = L_UP;
	else if(eKeyStatus == S) LeftMove = L_DOWN;
	else if( (eKeyStatus == W_RELEASED) || (eKeyStatus == S_RELEASED) ) LeftMove = L_STOP;
	else {}

	if	   (eKeyStatus == I) RightMove = R_UP;
	else if(eKeyStatus == K) RightMove = R_DOWN;
	else if( (eKeyStatus == I_RELEASED) || (eKeyStatus == K_RELEASED) ) RightMove = R_STOP;
	else {}

	if	   ((LeftMove == L_UP) & (left_palette > PALETTE_LENGTH)) {
		left_palette = left_palette - GameSpeed;
	}
	else if((LeftMove == L_DOWN) & (left_palette < 768 - PALETTE_LENGTH)) {
		left_palette = left_palette + GameSpeed;
	}
	else {}

	if(eGameMode == SINGLEPLAYER){
		if	   ( right_palette < ball_ypos ) right_palette = right_palette + GameSpeed;
		else if( right_palette > ball_ypos ) right_palette = right_palette - GameSpeed;
		else{}
	}
	else if ( eGameMode == MULTIPLAYER ){
		if	   ((RightMove == R_UP) & (right_palette > PALETTE_LENGTH)) {
			right_palette = right_palette - GameSpeed;
		}
		else if((RightMove == R_DOWN) & (right_palette < 768 - PALETTE_LENGTH)) {
			right_palette = right_palette + GameSpeed;
		}
		else {}
	}

	if	   (left_palette < PALETTE_LENGTH) 		 left_palette = PALETTE_LENGTH;
	else if(left_palette > 768 - PALETTE_LENGTH) left_palette = 768 - PALETTE_LENGTH;
	else{}
	if	   (right_palette < PALETTE_LENGTH) 	  right_palette = PALETTE_LENGTH;
	else if(right_palette > 768 - PALETTE_LENGTH) right_palette = 768 - PALETTE_LENGTH;
	else{}
}

void BallMovement(uint8_t GameSpeed){
	static enum MovementDirection eMovementDirection = RIGHT;
	static int32_t ball_xlarge   = 0x80000;
	static int32_t ball_ylarge   = 0x60000;
	static double a_large	  	 = 0;
	double Divider;

	Divider = sqrt(a_large*a_large + MULTIPLICATOR*MULTIPLICATOR);
	ball_ylarge = ball_ylarge + a_large*MULTIPLICATOR*(GameSpeed/(Divider*BALL_SPEED_MULTIPLICATOR));
	if	   ( eMovementDirection == RIGHT) ball_xlarge = ball_xlarge + MULTIPLICATOR*MULTIPLICATOR*(GameSpeed/(Divider*BALL_SPEED_MULTIPLICATOR));
	else if( eMovementDirection == LEFT)  ball_xlarge = ball_xlarge - MULTIPLICATOR*MULTIPLICATOR*(GameSpeed/(Divider*BALL_SPEED_MULTIPLICATOR));
	else {}

	if	   ( ball_ylarge < 0 ){
		ball_ylarge = 0;
		a_large = -a_large;
	}
	else if( ball_ylarge > 768*MULTIPLICATOR){
		ball_ylarge = 768*MULTIPLICATOR;
		a_large = -a_large;
	}
	else if( (ball_xpos < 10) && (ball_ypos > left_palette - PALETTE_LENGTH) && (ball_ypos < left_palette + PALETTE_LENGTH) ){
		ball_xpos = 10;
		a_large = a_large - MULTIPLICATOR*(left_palette - ball_ypos)/(PALETTE_LENGTH*2);
		eMovementDirection = RIGHT;
	}
	else if( (ball_xpos > 1014) && (ball_ypos > right_palette - PALETTE_LENGTH) && (ball_ypos < right_palette + PALETTE_LENGTH) ){
		ball_xpos = 1014;
		a_large = a_large - MULTIPLICATOR*(right_palette - ball_ypos)/(PALETTE_LENGTH*2);
		eMovementDirection = LEFT;
	}
	else if(ball_xlarge < 0) {
		ball_xlarge = 64*MULTIPLICATOR;
		ball_ylarge = 384*MULTIPLICATOR;
		a_large=0;
		right_score++;
		eMovementDirection = RIGHT;
	}
	else if(ball_xlarge > 1024*MULTIPLICATOR){
		ball_xlarge = 960*MULTIPLICATOR;
		ball_ylarge = 384*MULTIPLICATOR;
		a_large=0;
		left_score++;
		eMovementDirection = LEFT;
	}
	else {}

	if	   (a_large >  MAX_A*MULTIPLICATOR) a_large= MAX_A*MULTIPLICATOR;
	else if(a_large < -MAX_A*MULTIPLICATOR) a_large=-MAX_A*MULTIPLICATOR;
	else{}

	ball_ypos = ball_ylarge>>10;
	ball_xpos = ball_xlarge>>10;
}

void SendGame(int16_t left_palette, int16_t right_palette, int16_t ball_xpos, int16_t ball_ypos, uint8_t right_score, uint8_t left_score){
	gpio_output = eScreenMode<<29;
	gpio_output = gpio_output | (ball_ypos<<11) | ball_xpos;

	gpio2_output = right_palette;
	gpio2_output = gpio2_output | (left_palette << 11) | (right_score << 22) | (left_score << 26);

	XGpio_DiscreteWrite(&gpio, 1, gpio_output);
	XGpio_DiscreteWrite(&gpio, 2, gpio2_output);
}

void GameInit(void){
	left_palette   = 0x180;
	right_palette  = 0x180;
	ball_xpos	   = 0x200;
	ball_ypos	   = 0x180;
	left_score     = 0;
	right_score    = 0;
}
