#include <nucleoboard.h>


void SetupPinmux()
{
  Gpio_t* gpio;
  
  /* Set the User Button to be an input, there is an external pull up */
  gpio = GPIO_BLOCK_USER_BUTTON;
  gpio->MODER &= ~(3 << GPIO_PIN_USER_BUTTON);
  gpio->MODER |= (GPIO_MODER_INPUT << GPIO_PIN_USER_BUTTON);
  
  gpio->PUPDR &=  ~(3 << GPIO_PIN_USER_BUTTON);
  gpio->PUPDR |= (GPIO_PUPDR_NONE << GPIO_PIN_USER_BUTTON);
  
  
  /* Set the LED to be an output, Push Pull */
  gpio = GPIO_BLOCK_LD2;
  gpio->MODER &= ~(3 << GPIO_PIN_LD2);
  gpio->MODER |= (GPIO_MODER_OUTPUT << GPIO_PIN_LD2);
  
  gpio->OTYPER &=  ~(3 << GPIO_PIN_LD2);
  gpio->OTYPER |= (GPIO_OTYPER_PP << GPIO_PIN_LD2);
  
  
  
}