// exH.c
// ENCM 369 Winter 2016 Lab 1 Exercise H

#include <stdio.h>

void print_array(const char *str, const int *a, int n);
/* Prints the string given by str on stdout, then
 * prints a[0], a[1], ..., a[n - 1] on stdout on a single line. */

void sort_array(int *x, int n);
/* Sorts x[0], x[1], ..., x[n - 1] from smallest to largest. */

int main(void)
{
  int test_array[] = { 4000, 5000, 7000, 1000, 3000, 4000, 2000, 6000 };

  print_array("before sorting ...", test_array, 8);
  sort_array(test_array, 8);
  print_array("after sorting ...", test_array, 8);
  return 0;
}

void print_array(const char *str, const int *a, int n)
{
  int i = 0;
  puts(str);
  start_for_a:
    if (i >= n)
      goto end_for_a;
    printf("    %d", a[i]);
    i++;
    goto start_for_a;
  end_for_a:
    ;
  printf("\n");
}

void sort_array(int *x, int n)
{
  // This is an implementation of an algorithm called insertion sort.

  int outer = 1;
  int inner;
  int v;
  start_for_b:
    if (outer >= n)
      goto end_for_b;
    v = x[outer];
    inner = outer;
    start_while_a:
      if (inner <= 0)
        goto end_while_a;
      if (v >= x[inner-1])
        goto end_while_a;
      x[inner] = x[inner-1];
      inner--;
      goto start_while_a;
    end_while_a:
      ;
    x[inner] = v;
    outer++;
    goto start_for_b;
  end_for_b:
    ;
}
