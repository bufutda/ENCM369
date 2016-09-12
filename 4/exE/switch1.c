/* switch1.c
 * ENCM 369 Winter 2016 Lab 4 Exercise E */

#include <stdio.h>

const char * letter_count(int k);

int main(void)
{
  int i;
  const char *s;
  for (i = -1; i < 13; i++) {
    s = letter_count(i);
    printf("The English spelling of %d has %s", i, s);
  }
  return 0;
}

const char * letter_count(int k)
{
  const char *result;

  switch (k) {
  case 0: case 4: case 5: case 9:
    result = "four letters.\n";
    break;
  case 1: case 2: case 6: case 10:
    result = "three letters.\n";
    break;
  case 3: case 7: case 8:
    result = "five letters.\n";
    break;
  default:
    result = "an unknown number of letters.\n";
  }
  return result;
}
