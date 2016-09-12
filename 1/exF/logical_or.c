/*
 * logical_or.c
 * ENCM 369 Winter 2016 Lab 1 Exercise F
 */

/* INSTRUCTIONS:
 *   Recode the function func1 in Goto-C.
 *   Make sure your modified program produces *exactly* the same
 *   output as the original.
 */

#include <stdio.h>

void func1(int arg1);

int func2(int arg2);

int func3(int arg3);

int main(void)
{
  func1(10);
  func1(20);
  func1(30);
  return 0;
}

void func1(int arg1)
{
  if (func2(arg1) || func3(arg1))
    printf("At least one of func2(%d) or func3(%d) is true.\n", arg1, arg1);
  else
    printf("Neither func2(%d) nor func3(%d) is true.\n", arg1, arg1);
}

int func2(int arg2)
{
  printf("func2 called with arg2 = %d.\n", arg2);
  return arg2 < 15;
}

int func3(int arg3)
{
  printf("func3 called with arg2 = %d.\n", arg3);
  return arg3 < 25;
}
