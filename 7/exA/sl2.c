/*
   sl2.c: 32-bit hexadecimal "shift left 2" program

   Make an executable called sl2.

   Example use:  The command ...

       ./sl2 00004020

   ... produces this output ...

       0x00004020 shifted left two bits is 0x00010080.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>

/* Print a uint32_t value in 8-digit hex with 0x and leading zeros. */
#define PRX "0x%08" PRIx32

int main(int argc, char **argv)
{
  uint32_t input, result;
  if (argc != 2) {
    fprintf(stderr,
            "This program needs a command-line argument!\n");
    exit(1);
  }
  if (sscanf(argv[1], "%x" SCNx32, &input) == 1) {
    result = input << 2;
    printf(PRX " shifted left two bits is " PRX ".\n", 
           input, result);
  }
  else {
     fprintf(stderr,
             "Couldn't handle input \"%s\".\n", argv[1]);
     exit(1);
  }
  return 0;
}
