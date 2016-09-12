int procC(int x)
{
    // POINT ONE

    return 8 * x + 2 * x;
}

void procB(int *p, int *q)
{
    while (p != q) {
        *p = procC(*p);
        p++;
    }
}

int procA(int s, int *a, int n)
{
    int k;
    k = n - 1;
    procB(a, a + n);
    while (k >= 0) {
        s += a[k];
        k--;
    }
    return s;
}

int gg[] = { 2, 3, 4 };

int main(void)
{
    int mv;
    mv = 1000;
    mv += procA(200, gg, 3);
    return 0;
}
