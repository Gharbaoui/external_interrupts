#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include "setup.h"
void gpio_setup(void) {
  rcc_periph_clock_enable(RCC_GPIOA);
  gpio_mode_setup(GPIOA, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO5);
}

