#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/cm3/nvic.h>
#include <libopencm3/stm32/exti.h>



int main(void) {
  // pin setup
  rcc_periph_clock_enable(RCC_GPIOB);
  gpio_mode_setup(GPIOB, GPIO_MODE_INPUT, GPIO_PUPD_NONE, GPIO8);

  rcc_periph_clock_enable(RCC_GPIOA);
  gpio_mode_setup(GPIOA, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO5 | GPIO6);
  
  rcc_periph_clock_enable(RCC_SYSCFG);

  // exti setup
  exti_enable_request(EXTI8);
  exti_select_source(EXTI8, GPIOB);

  exti_set_trigger(EXTI8, EXTI_TRIGGER_RISING);

  nvic_enable_irq(NVIC_EXTI9_5_IRQ);

  while(1) {
    gpio_toggle(GPIOA, GPIO6);
    for (uint32_t i = 0; i < 1000000; ++i);
  }
}


void exti9_5_isr(void) {
  if (exti_get_flag_status(EXTI8)) {
    gpio_toggle(GPIOA, GPIO5);
    exti_reset_request(EXTI8);
  }
}
