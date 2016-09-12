/* demo.c
 * ENCM 369 Winter 2016 Lab 4 Exercise D
 *
 * Simple example of allocation and use of an array of chars within the stack
 * frame of a procedure.
 */

#include <stdio.h>

int main(void)
{
  char foo[6];
  foo[0] = 'H';
  foo[1] = 'e';
  foo[2] = 'y';
  foo[3] = '!';
  foo[4] = '\n';
  foo[5] = '\0';
  printf("%s", foo);
  return 0;
}
