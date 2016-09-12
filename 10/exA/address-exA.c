/* address-exA.c
 * ENCM 369 Winter 2016 Lab 10 Exercise A
 * 
 * Program to split addresses into tag, set bits, and byte offset
 * for a 1024-word direct-mapped cache with 1-word blocks.
 *
 * The user enters an address in hexadecimal on the command line,
 * or as input in response to a prompt.
 */

#include <stdio.h>
#include <stdlib.h>

#define BUFSIZE 128

int main(int argc, char **argv)
{
  char buffer[BUFSIZE];
  char *the_input;
  unsigned int address, set_bits, tag, byte_offset;
  int scan_count;
  if (argc == 1) { /* if program name is the only thing on the cmd line */
    printf("enter address in hexademical ...\n");
    if (fgets(buffer, BUFSIZE, stdin) == NULL) {
      fprintf(stderr, "bad input.\n");
      exit(1);
    }
    the_input = buffer;
  }
  else
    the_input = argv[1];
  scan_count = sscanf(the_input, "%x", &address);
  if (scan_count != 1) {
    fprintf(stderr, "string \"%s\" could not be converted to an address.\n", 
            the_input);
    exit(1);
  }
  printf("address was read as 0x%08x.\n", address);
  tag = address >> 12;
  printf("tag for this address is 0x%05x.\n", tag);
  set_bits = (address >> 2) & 0x3ff;
  printf("set bits for this address are 0x%03x, %u in base ten.\n", 
	 set_bits, set_bits);
  byte_offset = address & 3;
  printf("byte offset for this address is %u.\n", byte_offset);
  return 0;
}
