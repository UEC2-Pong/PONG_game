#include "xil_types.h"

enum GameMode 	{SINGLEPLAYER, MULTIPLAYER};
enum ScreenMode {MENU, GAME, CREDITS, OPTIONS, PLAYER1, PLAYER2} eScreenMode;

void Game(enum GameMode, uint8_t);

