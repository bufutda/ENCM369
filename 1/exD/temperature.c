/*
 * temperature.c
 * ENCM 369 Winter 2016 Lab 1 Exercise D
 */

#include <stdio.h>

void report(int celsius_temp);

int main(void)
{
  report(-10);
  report(0);
  report(5);
  report(14);
  report(20);
  report(26);
  report(30);
  return 0;
}

void report(int celsius_temp)
{
  if (celsius_temp <= 0) {
    printf("The temperature is a chilly %d degrees.\n", celsius_temp);
    printf("Don't slip on the ice.\n");
  }
  else if (celsius_temp <= 14) {
    printf("The temperature is a cool %d degrees.\n", celsius_temp);
    printf("Wear a jacket.\n");
  }
  else if (celsius_temp <= 26) {
    printf("The temperature is a pleasant %d degrees.\n", celsius_temp);
    printf("Have a nice day.\n");
  }
  else {
    printf("The temperature is a warm %d degrees.\n", celsius_temp);
    printf("Have a glass of water.\n");
  }
}
