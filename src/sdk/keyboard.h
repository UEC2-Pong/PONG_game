#include "xil_types.h"

enum KeyStatus  {RELEASED, W, S, I, K, W_RELEASED, S_RELEASED, I_RELEASED, K_RELEASED, ENTER, ESC};
enum KeyStatus CheckingForKeys(uint32_t);
