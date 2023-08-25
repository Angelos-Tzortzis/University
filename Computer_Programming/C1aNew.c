#include <stdio.h>

int main(int argc, int **argv)
{
    int A, B;
    int C, D, E, F; 
    system ("chcp 1253");  //Διαγραφή αν τρέχει σε Linux
    printf ("Βασικές αριθμητικές πράξεις με Ακεραίους\n");
    printf ("========================================\n\n");
    printf ("Εισάγετε τον πρώτο αριθμό  : ");
    scanf ("%d",&A);
    printf ("Εισαγετε το δεύτερο αριθμό : ");
    scanf ("%d", &B);
    C = A + B;
    D = A - B;
    E = A * B;
    F = A / B;
    printf ("’θροισμα  : %d\n", C);
    printf ("Διαφορά   : %d\n", D);
    printf ("Γινόμενο  : %d\n", E);
    printf ("Πηλίκο    : %d\n", F);
    return 0;
}

