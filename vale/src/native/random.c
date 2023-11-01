#include <time.h>
#include <math.h>
#include <stdlib.h>

#include "karakter/randomize.h"
#include "karakter/randomBool.h"
#include "karakter/randomInt.h"

void karakter_randomize(void) {
   srand(time(0));
}

int8_t karakter_randomBool() {
  return (rand() & 1);
}

int32_t karakter_randomInt(int32_t lower, int32_t upper) {
  return ((rand() % (upper + 1 - lower)) + lower);
}
