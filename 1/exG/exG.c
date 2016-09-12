// exG.c
// ENCM 369 Winter 2016 Lab 1 Exercise G


#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_ERROR (0.5e-9)
#define POLY_DEGREE 4

double polyval(const double *a, int n, double x);
/* Return a[0] + a[1] * x + ... + a[n] * pow(x, n). */

int main(void)
{
    double f[] = { 1.45, 0.78, -3.03, -1.15, 1.00 };
    double dfdx[POLY_DEGREE];

    double guess;
    int update_max;
    int update_count;
    int n_scanned;
    int i;

    double current_x, current_f, current_dfdx;

    printf("This program demonstrates use of Newton's Method to find\n"
           "approximate roots of the polynomial\nf(x) = ");
    printf("%.2f", f[0]);
    i = 1;
    start_for_b:
        if (i > POLY_DEGREE)
            goto end_for_b;
        if (f[i] >= 0)
            goto if_a;
        goto el_a;
        if_a:
            printf(" + %.2f*pow(x,%d)", f[i], i);
            goto fi_a;
        el_a:
            printf(" - %.2f*pow(x,%d)", -f[i], i);
            goto fi_a;
        fi_a:
            i++;
            goto start_for_b;
    end_for_b:
        ;
    printf("\nPlease enter a guess at a root, and a maximum number of\n"
           "updates to do, separated by a space.\n");
    n_scanned = scanf("%lf%d", &guess, &update_max);
    if (n_scanned != 2)
        goto if_b;
    goto el_b;
    if_b:
        printf("Sorry, I couldn't understand the input.\n");
        exit(0);
    el_b:
        ;
    if (update_max < 1)
        goto if_c;
    goto el_c;
    if_c:
        printf("Sorry, I must be allowed do at least one update.\n");
        exit(0);
    el_c:
        ;
    printf("Running with initial guess %f.\n", guess);
    i = 0;
    start_for_c:
        if (i >= POLY_DEGREE)
            goto end_for_c;
        dfdx[i] = (i + 1) * f[i + 1];   // Calculus!
        i++;
        goto start_for_c;
    end_for_c:
        ;
    current_x = guess;
    update_count = 0;
    start_while_a:
        current_f = polyval(f, POLY_DEGREE, current_x);
        printf("%d update(s) done; x is %.15f; f(x) is %.15e\n",
               update_count, current_x, current_f);
        if (update_count == update_max)
            goto end_while_a;
        if (fabs(current_f) < MAX_ERROR)
            goto end_while_a;
        current_dfdx = polyval(dfdx, POLY_DEGREE - 1, current_x);
        current_x -= current_f / current_dfdx;
        update_count++;
        goto start_while_a;
    end_while_a:
        ;
    if (fabs(current_f) <= MAX_ERROR)
        goto if_d;
    goto el_d;
    if_d:
        printf("Stopped with approximate solution of %.10f.\n",
               current_x);
        goto fi_d;
    el_d:
        printf("%d updates performed, solution still not good enough.\n",
               update_count);
        goto fi_d;
    fi_d:
        ;
    return 0;
}

double polyval(const double *a, int n, double x)
{
    double result = 0.0;
    int i = n;
    start_for_a:
        if (i < 1)
            goto end_for_a;
        result += a[i];
        result *= x;
        i--;
        goto start_for_a;
    end_for_a:
        ;
    result += a[0];
    return result;
}
