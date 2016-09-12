// functions.c: ENCM 369 Winter 2016 Lab 3 Exercise C 

// INSTRUCTIONS:
//   You are to write a MARS translation of this C program.  Because
//   this is the first assembly language program you are writing where you
//   must deal with register conflicts and manage the stack, there are
//   a lot of hints given in C comments about how to do the translation.
//   In future lab exercises and on midterms, you will be expected
//   to do this kind of translation without being given very many hints!


// Hint: Function prototypes, such as the next two lines of C,
// are used by a C compiler to do type checking and sometimes type
// conversions in function calls.  They do NOT cause ANY assembly
// language code to be generated.

int mercury(int first, int second, int third, int fourth);

int venus(int cat, int dog);

int earth = 0x30000;

int main(void)
{
  // Hint: This is a nonleaf procedure, so it needs a stack frame.

  // Instruction: Normally you could pick whatever two s-registers you
  // like for car and truck, but in this exercise you must use $s0
  // for car and $s1 for truck.

  int car;
  int truck;
  car = 0x7000;
  truck = 0x3000;
  truck += mercury(2, 3, 4, 6);
  car += (earth + truck);

  // At this point car should have a value of 0x3a60d.
 
  return 0;
}

int mercury(int first, int second, int third, int fourth)
{
  // Hint: This is a nonleaf procedure, so it needs a stack frame,
  // and you will have to make copies of the incoming arguments so
  // that a-registers are free for outgoing arguments.

  // Instructions: Normally you would have a lot of freedom within the
  // calling conventions about what s-registers you use, and about where
  // you put copies of incoming arguments, but in this exercise you
  // must copy first to $s0, second to $s1, third to $s2, and fourth to $s3, 
  // and use $s4 for alpha, $s5 for beta, and $s6 for gamma.

  int alpha;
  int beta;
  int gamma;
  beta = venus(third, fourth);
  gamma = venus(second, third);
  alpha = venus(fourth, first);

  return alpha + beta + gamma;
}

int venus(int jupiter, int saturn)
{
  // Hint: this is a leaf procedure, and it shouldn't need to use any
  // s-registers, so you should not have use the stack at all.
  return jupiter + 128 * saturn;
}
