/*
    Όνοματεπώνυμο: Άγγελος Τζώρτζης
    Α.Μ.: 18390094
    Είσαγωγή στον Παράλληλο Υπολογισμό
*/

// Η άσκηση έχει γίνει για για όταν Ν είναι ακέραιο πολλαπλάσιο του p.

#include <stdio.h>
#include "mpi.h"
#include <stdlib.h>

// Ορίζουμε το μήκος του πίνακα μας.
#define N 4

int main(int argc, char **argv)
{
    // Ορίζουμε τα δεδομένα.
    int rank;
    int p;
    int i, j;
    int root;
    int sum;
    int check;
    int final_check;
    int diagonal;
    int max_temp;
    int min_temp;
    int max;
    int min;
    int location[2];
    int max_d[N];
    int A[N][N];
    int temp_arr[N][N];
    int B[N][N];
    int min_loc[N];
    int coordinates_temp[N];
    int coordinates[N][N];

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &p);

    // Εισάγουμε τα δεδομένα στο πίνακα μας.
    if (rank == 0)
    {
        printf("Enter the elements of the array:\n");
        for (i = 0; i < N; i++)
        {
            for (j = 0; j < N; j++)
            {
                printf("Enter the value of arr[%d][%d]: ", i, j);
                scanf("%d", &A[i][j]);
            }
            printf("\n");
        }
    }

    MPI_Barrier(MPI_COMM_WORLD);

    // 1.
    // Μοιράζουμε τα στοιχεί του πίνακα μας ίσα στις διεργασίες του υπολογιστή μας.
    // Στέλνουμε Ν*Ν/p στοιχεία επειδή θέλουμε να διαμοιράσουμε τα στοιχεία του πίνακα ίσα στις διεργασίες.
    root = 0;
    MPI_Scatter(A, N * N / p, MPI_INT, temp_arr, N * N / p, MPI_INT, root, MPI_COMM_WORLD);

    check = 0;
    for (i = 0; i < N / p; i++)
    {
        // Διατρέχουμε τον κάθε υποπίνακα σε κάθε διεργασία.
        sum = 0;
        for (j = 0; j < N; j++)
        {
            // Τα στοιχεία της διαγωνίου βρίσκονται στις θέσεις του πίνακα όπου ισχύει
            // j-1 == N/p*rank. Αυτό ισχύει για όταν το n είναι ακέραιο πολλαπλάσιο του p.
            if (j - i == N / p * rank)
            {
                // Εάν βρίσκομαστε στην διαγώνιο, δεν αυξάνουμε το αθροισμα καθώς θέλουμε το άθροισμα μόνο για τα υπόλοιπα στοιχεία,
                // βάζουμε την τιμή στην προσωρινή μεταβλητή για την διαγώνιο και στον πίνακα που εκχωρούμε τα στοιχεία της διαγωνίου σε κάθε επεξεργασία,
                // καθώς θα μας χρειαστέι αργότερα.
                sum = sum;
                diagonal = temp_arr[i][j];
                max_d[i] = temp_arr[i][j];
            }
            else
            {
                sum += temp_arr[i][j];
            }
        }

        // Εάν το στοιχείο της διαγωνίου είναι μεγαλύτερο απο το άθροισμα των υπόλοιπων αυξάνουμε την μεταβλητή check κατα ένα.
        if (diagonal > sum)
        {
            check++;
        }
    }

    // Προσθέτουμε τις τιμές της check από την κάθε διεργασία σε μία μεταβλητή στον αρχηγό.
    MPI_Reduce(&check, &final_check, 1, MPI_INT, MPI_SUM, root, MPI_COMM_WORLD);

    if (rank == 0)
    {
        // Εάν ο πίνακας είναι αυστηρά διαγώνια δεσπόζων τότε το άθροισμα των check από την κάθε διεργασία θα ισούται με το Ν και τυπώνουμε το ανίστοιχο αποτέλεσμα.
        if (final_check == N)
        {
            printf("Yes.\n\n");
        }
        else
        {
            printf("No.\n");
            exit(0);
        }
    }

    // 2.
    // Απο τον πίνακα max_d βρίσκουμε το μεγαλύτερο στοιχείο της κάθε διεργασίας.
    max_temp = max_d[0];
    for (i = 1; i < N / p; i++)
    {
        if (max_d[i] > max_temp)
        {
            max_temp = max_d[i];
        }
    }

    // Εδώ απο τα μέγιστα της κάθε διεργασίας βρίσκουμε το μεγαλύτερο και θέτουμε την τιμή του στην max.
    MPI_Reduce(&max_temp, &max, 1, MPI_INT, MPI_MAX, root, MPI_COMM_WORLD);

    if (rank == 0)
    {
        printf("The max element of the diagonal: %d\n\n", max);
    }

    // 3.
    // Στέλνουμε το μέγιστο σε όλες τις διεργασίες.
    MPI_Bcast(&max, 1, MPI_INT, root, MPI_COMM_WORLD);
    for (i = 0; i < N / p; i++)
    {
        for (j = 0; j < N; j++)
        {
            // Στα στοιχεία της διαγωνίου θέτουμε την τιμή max.
            if (j - i == N / p * rank)
            {
                temp_arr[i][j] = max;
            }
            else
            { // Σε περίπτωση που έχουμε αρνητικο αριθμό στον πίνακα αντιστρέφουμε το πρόσημο αφού θέλουμε απόλυτη τιμή,
              // και μετά κάνουμε την πράξη ώστε να βρούμε την τιμή για τον νέο πίνακα.
                if (temp_arr[i][j] < 0)
                {
                    temp_arr[i][j] = -temp_arr[i][j];
                }
                temp_arr[i][j] = max - temp_arr[i][j];
            }
        }
    }

    // Μαζεούμε όλους τους υποπίνακες στον αρχηγό στην θέση του νέου μας πίνακα Β.
    MPI_Gather(temp_arr, N * N / p, MPI_INT, B, N * N / p, MPI_INT, root, MPI_COMM_WORLD);

    // Εκτυπώνουμε τον νέο πίνακα.
    if (rank == 0)
    {
        for (i = 0; i < N; i++)
        {
            for (j = 0; j < N; j++)
            {
                printf("%3d ", B[i][j]);
            }
            printf("\n");
        }
        printf("\n");
    }

    // Μοιράζουμε τον νέο πίνακα σε όλες τις διεργασίες.
    MPI_Scatter(B, N * N / p, MPI_INT, temp_arr, N * N / p, MPI_INT, root, MPI_COMM_WORLD);
    // Βρίσκουμε το ελάχιστο απο κάθε διεργασία.
    min_temp = temp_arr[0][0];
    for (i = 0; i < N / p; i++)
    {
        for (j = 0; j < N; j++)
        {
            if (temp_arr[i][j] < min_temp)
            {
                // Αποθηκεύουμε το ελάχιστο σε μία μεταβλητή.
                min_temp = temp_arr[i][j];
                // Αποθηκεύοθμε τις συντεταγμένες του κάθε ελάχιστου σε έναν πίνακα 2 θέσεων.
                coordinates_temp[0] = rank * N / p + i; // Παρόμοιο με την έυρεση στοιχείο της διαγωνίου. Μας χρειάζεται για  να βρούμε την γραμμή του ελαχίστου.
                                                        //Καθώς οι υποπίνακες δέν έχουνε όλες τις γραμμές.
                coordinates_temp[1] = j;
            }
        }
    }
    // Αποθηκεύουμε το ελάχιστο της διεργασίας και τον αριθμό της διεργασίας σε έναν πίνακα 2 θέσεων.
    min_loc[0] = min_temp;
    min_loc[1] = rank;

    // Επιστρέφουμε στον αρχηγό το ελάχιστο και σε ποιά διεργασία το βρήκαμε.
    MPI_Reduce(min_loc, location, 1, MPI_2INT, MPI_MINLOC, root, MPI_COMM_WORLD);
    // Επιστρέφουμε στον αρχηγό όλες τις συντεταγμένες για τα ελάχιστα και τις αποθηκεύουμε σε έναν πίνακα.
    MPI_Gather(coordinates_temp, 2, MPI_INT, coordinates, 2, MPI_INT, root, MPI_COMM_WORLD);

    // location[0] = ελάχιστο
    // location[1] = τάξη διεργασίας.
    if (rank == 0)
    {
        int num = location[1];
        // Τυπώνουμε το ελάχιστο και την θέση που το βρήκαμε
        printf("Min: %d at location: ", location[0]);
        for (i = 0; i < 2; i++)
        {
            // Το location[1] μας βοηθάει να βρούμε το ελάχιστο καθώς οι συντεταγμένες είναι αποθηκευμένες με βάση σε ποιό rank το βρήκαμε.
            printf("[%d]", coordinates[num][i]);
        }
        printf("\n");
    }

    MPI_Finalize();
    return 0;
}
