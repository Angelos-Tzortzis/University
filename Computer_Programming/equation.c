// Εργασία 3, άσκηση 3.
#include <stdio.h>
#include <math.h> // Βιβλιοθήκη που περιέχει μαθηματικές συναρτήσεις

// Υπολογισμός ριζών δευτεροβάθμιας εξίσωσης της μορφής αx^2+βx+c = 0.
int main()
{
    double a, b, c, d, x1, x2;
    /*
        a = α.
        b = β.
        c = γ.
        d = διακρίνουσα.
        x1 = 1η ρίζα της εξίσωσης.
        x2 = 2η ρίζα της εξίσωσης.
    */
    
    // Εισαγωγή των συντελεστών της εξίσωσης.
    printf("Solve the equation: a*x^2 + b*x + c = 0\n\n");
    printf("Enter the value for a: ");
    scanf("%lf", &a);
    printf("Enter the value for b: ");
    scanf("%lf", &b);
    printf("Enter the value for c: ");
    scanf("%lf", &c);
    printf("\n");
    
    // Εάν α = 0 τότε δέν έχουμε δευτεροβάθμια εξίσωση και αναλύουμε αυτή την περίπτωση.
    if (a == 0)
    {   
        // Εάν β = 0 δεν έχουμε ούτε πρωτοβάθμια εξίσωση.
        if (b == 0)
        {
            // Εάν γ = 0 τότε έχουμε ταυτότητα.
            // Εάν γ != 0 τότε η εξίσωση είναι αδύνατη.
            if (c == 0)
                printf("The equation %lf*x^2 + %lf*x + %lf = 0 has infinite solutions.\n", a, b, c);
            else
                printf("The equation %lf = 0 has no real solutions.\n", c);
        }
        else // β != 0 άρα έχουμε πρωτοβάθμια εξίσωση.
        {
            // x = -γ/β.
            x1 = x2 = -c/b;
            printf("The equation x = -%lf/%lf has one solution: x = %lf\n", c, b, x1);
        }
    }
    else // α != 0 άρα έχουμε δευτεροβάθμια εξίσωση.
    {
        // Υπολογίζουμε την διακρίνουσα με βάση τον τύπο Δ = β^2 -4αγ.
        d = b*b - 4*a*c;
        printf("d = %lf\n\n", d);
        
        if (d < 0) // Καμία λύση στο σύνολο των πραγματικών αριθμών.
            printf("The equation %lf*x^2 + %lf*x + %lf = 0 has no real solutions.\n", a, b, c);
        else if(d == 0) // Μία διπλή ρίζα.
        {
            // Υπολογίζουμε την μία διπλή ρίζα x = -β/2α.
            x1 = x2 = -b/2*a;
            printf("The equation %lf*x^2 + %lf*x + %lf = 0 has one solution: x = -%lf/2*%lf = %lf\n", a, b,c, b, a, x1);
        }
        else // 2 ρίζες.
        {
            // Υπλογίζουμε τις 2 ρίζες x1 = (-β + ρίζα(Δ))/2α και x2 = (-β - ρίζα(Δ))/2α.
            x1 = (-b + sqrt(d))/2*a;
            x2 = (-b - sqrt(d))/2*a;
            printf("The equation %lf*x^2 + %lf*x + %lf = 0 has two solutions: x1 = %lf, x2 = %lf\n", a, b, c, x1, x2);
        }
    }
    
    return 0 ;
}

