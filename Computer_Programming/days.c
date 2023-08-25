// Εργασία 3, άσκηση 4.
#include <stdio.h>

// Υλοποίηση χωρίς χρήση της if.
int main()
{
    // Μεταβλητή year και month για εισαγωγή και αποθήκευση του έτους και του μήνα αντίστοιχα,
    // και days για να χειριζομαστε τις μέρες του Φεβρουαρίου.
    int year, month, days;
    
    printf("Enter a month (1-12): ");
    scanf("%d", &month);
    printf("Enter a year (A.D.): "); // A.D. = M.X.
    scanf("%d", &year);
    
    // Χρησιμοποιούμε την εντολή switch με κάθε case να αντιστοιχεί σε έναν μήνα
    // και ορίζουμε τις μέρες αναλόγως σε ποίον μήνα βρισκόμαστε.
    // Εκτυπώνουμε το κατάλληλο μήνυμα αναλόγως τον μήνα και έτος που βρισκόμαστε.
    // Τις μέρες των υπόλοιπων μηνών δέν τις αποθηκεύουμε σε μeταβλητές καθώς μένουν
    // σταθερές και μάλλον δεν πρόκειται να αλλάξουν σύνοτμα.
    switch(month)
    {
        case 1:
            printf("\nJanuary %d has 31 days.\n", year);
            break;
        case 2:
            // Χρήση τριαδικού τελεστή ώστε να θέσουμε τις μέρες ώς 29 εάν το έτος διαιρείται
            // με το 4 αλλα όχι το 100 ή αν διαιρείται με το 400, αλλιώς τις θέτουμε τις μέρες 28.
            days = (((year%4 == 0) && (year%100 != 0)) || year%400 == 0) ? 29 : 28;
            printf("\nFebruary %d has %d days.\n",year,  days);
            break;
        case 3:
            printf("\nMarch %d has 31 days.\n", year);
            break;
        case 4:
            printf("\nApril %d has 30 days.\n", year);
            break;
        case 5:
            printf("\nMay %d has 31 days.\n", year);
            break;
        case 6:
            printf("\nJune %d has 30 days.\n", year);
            break;
        case 7:
            printf("\nJuly %d has 31 days.\n", year);
            break;
        case 8:
            printf("\nAugust %d has 31 days.\n", year);
            break;
        case 9:
            printf("\nSeptember %d has 30 days.\n", year);
            break;
        case 10:
            printf("\nOctober %d has 31 days.\n", year);
            break;
        case 11:
            printf("\nNovember %d has 30 days.\n", year);
            break;
        case 12:
            printf("\nDecember %d has 31 days.\n", year);
            break;
        default:
            // Εάν ο χρήστης δεν πληκτρολογήσει αριθμό που αντιστοιχεί σε κάποιο μήνα.
            printf("Did not enter a number that corresponds to a month (1-12).");
            break;
    }
    
    return 0;
}

