/* switch2.c
 * ENCM 369 Winter 2016 Lab 4 Exercise E */

#include <stdio.h>

void comment_on(int n);

int main(void)
{
  int i;
  for (i = -1; i < 15; i++)
    comment_on(i);
  return 0;
}

void  comment_on(int n)
{
  switch (n) {
  case 1:
  case 6:
  case 10:
    printf("%d is triangular.\n", n);
    break;
  case 2:
    printf("2 is the only even prime number.\n");
    break;
  case 3:
    printf("3 is both prime and triangular.\n");
    break;
  case 5:
  case 7:
  case 11:
  case 13:
    printf("%d is odd and prime.\n", n);
    break;
  default:
    printf("%d is not special, according to this program.\n", n);
  }
}

