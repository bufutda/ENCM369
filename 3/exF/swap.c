// swap.c
// ENCM 369 Winter 2016 Lab 3 Exercise F


// INSTRUCTIONS:
//   A partially-completed assembly language translation of this
//   file can be found in swap.asm.  Complete the translation
//   by adding the necessary instructions to main and swap in
//   swap.asm.

void swap(int *left, int *right);
// REQUIRES:
//   left and right point to variables
// PROMISES:
//   *left == original value of *right.
//   *right == original value of *left.


int foo[] =  { 0x700, 0x600, 0x500, 0x400, 0x300, 0x200, 0x100 };

int main(void)
{
  // These three swaps will reverse the order of the elements
  // in the array foo.
  swap(&foo[0], &foo[6]);
  swap(&foo[1], &foo[5]);
  swap(&foo[2], &foo[4]);

  return 0;
}

void swap(int *left, int *right)
{
  // Hint: Think carefully about when use of the C * operator
  // means "load" and when it means "store".

  int old_star_right;

  old_star_right = *right;
  *right = *left;
  *left = old_star_right;
}
