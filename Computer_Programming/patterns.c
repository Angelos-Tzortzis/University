#include <stdio.h>

int main()
{
    int lines, i, j;
    
    // Εισάγουμε το μέγεθος των σχημάτων.
    printf("Enter the number of lines you want each pattern to be: ");
    scanf("%d", &lines);
    printf("\n");
        
    // 1ο σχήμα.
    for (i = 0; i < lines; i++)
    {
        // Εκτυπώνουμε στην γραμμή που βρισκόμαστε αστεράκια αναλόγως με τον αριθμό της γραμμής
        // π.χ. γραμμή 3, 3 αστεράκια.
        for (j = 0; j <= i; j++)
            printf("*");
        
        printf("\n");
    }
    printf("\n");
    
    // 2ο σχήμα.
    // Τυπώνουμε σε κάθε γραμμή κενά αναλόγως σε ποιά επανάληψη βρισκόμαστε (το j ακολουθεί το i).
    // και μετά τυπώνουμε αστεράκια όσες φορές έχουμε ορίσει τις γραμμές πλήν της γραμμής που είμαστε.
    for (i = 0; i < lines; i++)
    {
        
        for (j = 0; j < i; j++)
            printf(" ");
                
        for (j = 0; j <= lines - i - 1; j++)
            printf("*");
        
        printf("\n");
    }
    printf("\n");
    
    // 3ο σχήμα.
    for (i = 0; i < lines; i++)
    {
        for (j = 0; j < lines - i -1; j++)
            printf(" ");
        
        
        for (j = 0; j < 2*i + 1; j++)
        {
            if (j == (2*i + 1) / 2)
                printf(".");
            else
                printf("*");
        }
            
        printf("\n");
    }
    printf("\n");
    
    // 4ο σχήμα.
    // Τα σημεία της περιμέτρου του σχήματος βρίσκονται σε θέσεις όπου i ή j έχουν τιμή 0 ή lines καθώς βρίσκονται στις άκρες.
    // Tα σημεία της διαγνωίου είναι αυτά όπου i = j.
    // Tα σημεία της 2ης διαγνωίου είναι αυτά όπου το άθροισμα των i, j του σημείου είναι lines - 1.
    for (i = 0; i < lines; i++)
    {
        for (j = 0; j < lines; j++)
        {
            if (i == 0 || j == 0 || i == lines - 1 || j == lines - 1)
                printf("*");
            else if (i == j || i + j == lines-1)
                printf(".");
            else
                printf(" ");
        }
        
        printf("\n");
    }
    
    return 0;
}

