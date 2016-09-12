/*
 * main.c
 * ENCM 369 Winter 2016 Lab 5 Exercises E and F
 */

/*
 * A NOTE ABOUT THE clock FUNCTION:
 *
 * clock is supplied as part of the standard C library.  Its
 * prototype is found in <time.h>:
 *
 *   clock_t clock(void);
 *
 * The return value is the *approximate* CPU time used by a program
 * since it started running.  The units vary from one C library
 * implementation to another, but the constant CLOCKS_PER_SEC is
 * defined so that the value returned by clock can be converted to
 * seconds.  clock_t can be an integer type, and CLOCKS_PER_SEC can
 * also be of an integer type, so a cast to type double should be done
 * before a clock_t value is divided by CLOCKS_PER_SEC.
 *
 * CLOCKS_PER_SEC does *not* tell you how precise the measurement of
 * CPU time is.  For example, on Linux CLOCKS_PER_SEC is 1000000,
 * but the CPU time measurement is accurate to no better than
 * +/- 0.01 seconds.
 */
 
#include <stdio.h>
#include <time.h>
#include "functions.h"

#define ARRAY_SIZE 4000
#define NUMBER_OF_CALLS 700000

int x[ARRAY_SIZE];

int main(void)
{
  int i, sum, count;
  long int sum_of_sums = 0;
  clock_t before, after;

  // Put some values into the array for addition. 
  for (i = 0; i < ARRAY_SIZE; i++)
    x[i] = 10 * (i + 1);

  printf("CPU time for %d calls", NUMBER_OF_CALLS);
  printf(" to index_version with array of %d elements ...\n", ARRAY_SIZE);
  before = clock();
  for (count = NUMBER_OF_CALLS; count > 0; count--) {
    sum = index_version(x, ARRAY_SIZE);
    sum_of_sums += sum;
  }
  after = clock();
  printf("... %.10f seconds\n\n", (double) (after - before) / CLOCKS_PER_SEC);

  printf("CPU time for %d calls", NUMBER_OF_CALLS);
  printf(" to pointer_version with array of %d elements ...\n", ARRAY_SIZE);
  before = clock();
  for (count = NUMBER_OF_CALLS; count > 0; count--) {
    sum = pointer_version(x, ARRAY_SIZE);
    sum_of_sums += sum;
  }
  after = clock();
  printf("... %.10f seconds\n\n", (double) (after - before) / CLOCKS_PER_SEC);

  // Printing the sum of sums prevents an optimizing compiler from
  // eliminating all the work done in calls to index_version and
  // pointer_version.
  printf("The sum of sums was %ld.\n", sum_of_sums);

  return 0;
}
