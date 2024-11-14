#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include "setup/setup.h"


int main(void) {
  gpio_setup();
  gpio_set(GPIOA, GPIO5);
}
