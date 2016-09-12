// lab03exE.c: ENCM 369 Winter 2016 Lab 3 Exercise E

// INSTRUCTIONS:
//   You are to write a MARS translation of this C program, compatible
//   with all of the calling conventions presented so far in ENCM 369.


int saturate(int x, int bound);

int special_sum(const int *x, int n, int b);

int aaa[] = { 11, 11, 3, -11};
int bbb[] = { 200, -300, 400, 500 };
int ccc[] = { -2, -3, 2, 1, 2, 3 };

int main(void)
{
    // Normally you could pick whatever s-registers you like for red,
    // green, and blue.  However in this exercise you should use $s0
    // for red, $s1 for green, and $s2 for blue -- this will help
    // make sure you learn to manage s-registers correctly.
    
    int red, green, blue;
    blue = 1000;
    red = special_sum(aaa, 4, 10);
    green = special_sum(bbb, 4, 200);
    blue += special_sum(ccc, 6, 500) - red + green;

    // Here blue should have a value of 1390.

    return 0;
}

int saturate(int x, int bound)
{
  int result;
  result = x;
  if (x > bound)
    result = bound;
  else if (x < -bound)
    result = -bound;
  return result;
}

int special_sum(const int *x, int n, int b)
{
  // Normally you could pick whatever s-registers you like for a, n,
  // b, k, and sum.  However in this exercise you should use $s0
  // for bound, $s1 for x, $s2 for n, $s3 for result, and $s4 for i --
  // this will help make sure you manage s-registers correctly.

  int result;
  int i;
  result = 0;
  for (i = 0; i < n; i++)
    result += saturate(x[i], b);
  return result;
}
