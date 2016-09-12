/*
 * append.c
 * ENCM 369 Winter 2016 Lab 5 Exercise D
 */

#include <stdio.h>

void append(char *dest, const char *src);
// Duplicates behaviour of Standard C strcat function, except that
// append lacks the return value that strcat provides.


int main(void)
{
  char str[24];
 
  // Start with empty string.
  str[0] = '\0';
  
  // Append empty string.
  append(str, "");

  // Append a single-char string.
  append(str, "W");

  // Append a multiple-char string.
  append(str, "inter ");

  // Append another single-char string.
  append(str, "2");

  // Append another multiple-char string.
  append(str, "016");

  // Append another empty string.
  append(str, "");

  // Append one more multiple-char string.
  append(str, " ENCM 369");

  // Print to see if the result is as expected.
  puts(str);

  return 0;
}

void append(char *dest, const char *src)
{
  int i, j, c;
  i = 0;
  while (dest[i] != '\0')
    i++;
  j = 0;
  do {
    c = src[j];
    dest[i] = c;
    i++;
    j++;
  } while (c != '\0');
}
