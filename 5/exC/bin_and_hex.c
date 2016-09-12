// bin_and_hex.c
// ENCM 369 Winter 2016 Lab 5 Exercise C


#include <stdio.h>

 
void write_in_hex(char *str, int word);
// REQUIRES: str points to the beginning of an array of at least 12 elements.
// PROMISES: The base sixteen representation of word, with underscores 
//   separating groups of four hex digits, is written as a string in the array.
// NOTE: The function assumes that int is a 32-bit type.

void write_in_binary(char *str, int word);
// REQUIRES: str points to the beginning of an array of at least 40 elements.
// PROMISES: The base two representation of word, with underscores 
//   separating groups of four bits, is written as a string in the array.
// NOTE: The function assumes that int is a 32-bit type.
 
void test(int test_value);
/* Function to test write_in_binary and write_in_hex. */

int main(void)
{
  test(0x76543210);
  test(0x89abcdef);
  test(0);
  test(-1);
  return 0;
}

void test(int test_value)
{
  char str[40];
  write_in_hex(str, test_value);
  printf("%s\n", str);
  write_in_binary(str, test_value);
  printf("%s\n\n", str);
}


void write_in_hex(char *str, int word)
{
  char *digit_list;

  str[0] = '0';
  str[1] = 'x';
  str[6] = '_';
  str[11] = '\0';

  digit_list = "0123456789abcdef";

  str[2] = digit_list[(word >> 28) & 0xf];
  str[3] = digit_list[(word >> 24) & 0xf];
  str[4] = digit_list[(word >> 20) & 0xf];
  str[5] = digit_list[(word >> 16) & 0xf];

  str[7] = digit_list[(word >> 12) & 0xf];
  str[8] = digit_list[(word >> 8) & 0xf];
  str[9] = digit_list[(word >> 4) & 0xf];
  str[10] = digit_list[word & 0xf];
}


void write_in_binary(char *str, int word)
{
  int underscore = '_', digit0 = '0', digit1 = '1';
  int bn;			// bit number within word
  char *p;			// address of next char to write

  // Terminate string with room for 32 digits and 7 underscores.
  str[39] = '\0';

  // Start with LSB.
  bn = 0;
  p = str + 39;

  while (1) {
    p--;
    if ((word & 1) == 0)
      *p = digit0;
    else
      *p = digit1;

    if (bn == 31)
      break;

    // Put underscore between bits 3 and 4, 7 and 8, etc.
    if ((bn & 3) == 3) {
      p--;
      *p = underscore;
    }
    bn++;
    word = word >> 1;
  }
}
