/* exD.c
 * ENCM 369 Winter 2016 Lab 2 Exercise D
 *
 * INSTRUCTIONS
 *   Your overall goal is to translate this program into MARS
 *   assembly language.  Proceed using the following steps:
 *
 *   1. Make sure you know what this C program does.  If you're not
 *      sure, add calls to printf.
 *
 *   2. Translate the program to Goto-C.  If you're not sure your
 *      translation is correct, add calls to printf. 
 *
 *   3. Write down a list of local variables and the registers
 *      you need for them.  (You will later type this in as
 *      a comment in your MARS source code.)   
 *
 *   4. Using the products of Steps 2 and 3, write a MARS translation
 *      of this program, in a file called exD.asm.  Use comments (a)
 *      to describe allocation of local variable to s-registers and
 *      (b) to explain what each MARS instruction does.
 *
 *      Your MARS code must closely match the C code.  In particular,
 *      the translation of the while loop should use pointer
 *      arithmetic, and the translation of the for loop should include
 *      generation of the address of alpha[i] by adding 4 times i to
 *      the address of alpha[0].
 *
 *   5. Test your translation using MARS.
 */

int alpha[8] = { 0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1 };
int beta[8] = { 0x70, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x0 };

int main(void)
{
  int *pa, *pb, *guard;
  int i, min, imin;

  // Copy elements from alpha to beta in reverse order,
  // writing over the initial values in beta.
  pa = alpha;
  guard = alpha + 8;
  pb = beta + 8;
  while (pa != guard) {
    pb--;
    *pb = *pa;
    pa++;
  }

  // Put index of smallest element of alpha into imin.
  imin = 0;
  min = alpha[0];
  for (i = 1; i < 8; i++) {
    if (alpha[i] < min) {
      min = alpha[i];
      imin = i;
    }
  }

  return 0;
}
