#include <stdio.h>

void SumProd(int N);
int compute_sum(int N);
int compute_factorial(int N);

int main()
{
    int K, i, num;

    printf("Enter the amount of numbers (K) to find the sum of 1 to K, and K!: ");
    scanf("%d", &K);
    
    
    printf("Please enter the numbers:\n");
    for (i = 0; i < K; i++)
    {
        scanf("%d", &num);
        SumProd(num);
    }
    
    return 0;
}

// Συνάρτηση ώστε να ξεκινήσει η διαδικασία υπολογισμού αθροίσματος και παραγοντικού.
void SumProd(int num)
{
    int sum, fact;
    
    sum = compute_sum(num);
    fact = compute_factorial(num);
    printf("%d: sum = %d, factorial = %d\n", num, sum, fact);
}

// Συνάρτηση υπολογισμού αθροίσματος.
int compute_sum(int N)
{
    int i, sum;
    
    if (N < 0) // Δεν υπολογίζεται για αριθμούς μικρότερους του 0.
        sum = -1;
    else if (N > 65535) // Το άθροισμα των αριθμών μετά το 65535 ξεπερνάει το όριο των ακεραίων.
        sum = -1;
    else
    {
        sum = 0;
        for (i = 1; i <= N; i++)
            sum += i;
    }
    
    return sum;
}

// Συνάρτηση υπολογισμού παραγοντικού.
int compute_factorial(int N)
{
    int i, fact;
    
    if (N < 0) // Δεν υπολογίζεται για αριθμούς μικρότερους του 0.
        fact = -1;
    else if (N == 0)
        fact = 1;
    else if (N > 12) // Μετά το 12 παραγοντικό έχουμε υπερχείλιση.
    {
        fact = -1;
    }
    else
    {
        fact = 1;
        for (i = 1; i <= N; i++)
            fact *= i;
    }
    return fact;
}
