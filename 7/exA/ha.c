/*
   ha.c: 32-bit hexadecimal adder program

   Make an executable called ha.

   Example use:  The command ...

      ./ha 7fffffff 2

   ... produces this output ...

       Sum of 0x7fffffff and 0x00000002 is 0x80000001.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>

/* Print a uint32_t value in 8-digit hex with 0x and leading zeros. */
#define PRX "0x%08" PRIx32

int main(int argc, char **argv)
{
  uint32_t input[2], result;
  if (argc != 3) {
    fprintf(stderr,
            "This program needs two command-line arguments!\n");
    exit(1);
  }
  if (sscanf(argv[1], "%" SCNx32 , input) == 1
      && sscanf(argv[2], "%" SCNx32, input + 1) == 1) {
    result = input[0] + input[1];
    printf("Sum of " PRX " and " PRX " is " PRX ".\n",
           input[0], input[1], result);
  }
  else {
     fprintf(stderr,
             "Couldn't handle inputs \"%s\" and/or \"%s\".\n", 
             argv[1], argv[2]);
     exit(1);
  }
  return 0;
}
