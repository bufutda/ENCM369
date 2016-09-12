/*
 * long_ints.c
 * ENCM 369 Winter 2016 Lab 6 Exercise C
 */

#include <stdio.h>

int main(void)
{
  /* The type choice and the addition in this simple main function are
     intended to be similar to things that might exist within software
     that manages amounts of money as integer numbers of cents.
     Suppose the programmer believes that long ints are always 64 bits
     wide, so can hold a number of cents much larger than any amount
     of money involved in any transaction ...
  */
  long int balance_pennies;
  long int more_pennies;

  /* A little note about printf: %li (or %ld) does for the long int
     type what %i (or %d) does for the int type. */

  balance_pennies = 1342177280;
  printf("Original balance is %li cents.\n", balance_pennies);

  more_pennies = 1073741824;
  printf("About to deposit %li cents.\n", more_pennies);
  
  balance_pennies += more_pennies;
  printf("Now the balance is %li cents.\n", balance_pennies);

  return 0;
}
