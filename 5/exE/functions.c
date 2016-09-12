/*
 * functions.c
 * ENCM 369 Winter 2016 Lab 5 Exercises E and F
 */

#include "functions.h"

int index_version(const int *a, int n)
{
  int i, sum = 0;
  for (i = 0; i < n; i++)
    sum += a[i];
  return sum;
}


int pointer_version(const int *a, int n)
{
  int sum = 0;
  const int *p;
  const int *past_last;
  past_last = a + n;
  for (p = a; p != past_last; p++)
    sum += *p;
  return sum;
}
