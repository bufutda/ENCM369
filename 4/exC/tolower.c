// tolower.c
// ENCM 369 Winter 2016 Lab 5 Exercise C

#include <stdio.h>

int lower_char(int c)
{
  // If c is ASCII for a uppercase letter, return the ASCII code
  // for the corresponding lower case letter.  Otherwise, return c.
  int result = c;
  if (65 <= result && result <= 90) 
    result += 32;
  return result;
}

void lower_string(char *to, const char *from)
{
  int lchar;
  while (1) {
    lchar = lower_char(*from);
    *to = lchar;
    if (lchar == '\0')
      break;
    from++;
    to++;
  }
}

char result[40];

int main(void)
{
  // Hint about the standard C puts function: It prints characters from
  // a string up to but not including '\0', then it prints '\n'.
  // One puts call will need two MARS syscalls: one to print a string
  // and another to print a '\n'.

  puts("Exercise 4C result is ...");
  lower_string(result, "ENCM 369 Winter 2015 AZ az [ ] @ !!!");
  puts(result);
  return 0;
}
