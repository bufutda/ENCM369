// array-sum-recurs.c
// ENCM 369 Winter 2016 Lab 4 Exercise F

#include <stdio.h>

int array_sum(const int *a, int low, int high);
// Compute sum of a[low], a[low + 1], ..., a[high - 1]

int main(void)
{
  int x[9];
  int sum;
  int i;
  
  // Give values of 0x100 ... 0x108 to array elements x[0] .... x[8].
  for (i = 0; i < 9; i++)
    x[i] = 0x100 + i;

  sum = array_sum(x, 0, 9);

  // %08x will print 8 hex digits padded with leading 0's as necessary.
  printf("Sum of array elements is 0x%08x\n", sum);
  return 0;
}

int array_sum(const int *a, int low, int high)
{
  int mid, result;
  if (low + 1 == high)
    result = a[low];
  else {
    mid = (low + high) / 2;
    result = array_sum(a, low, mid);
    result += array_sum(a, mid, high);
  }
  return result;
}
