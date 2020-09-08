#include "xil_types.h"

enum GameMode 	{SINGLEPLAYER, MULTIPLAYER};
enum ScreenMode {MENU, GAME, CREDITS, OPTIONS} eScreenMode;

void Game(enum GameMode, uint8_t);
void SendGame(uint16_t, uint16_t, uint16_t, uint16_t);
void ItemsPositionInit();
