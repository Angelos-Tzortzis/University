/*
    Όνοματεπώνυμο: Άγγελος Τζώρτζης
    Α.Μ.: 18390094
    Είσαγωγή στον Παράλληλο Υπολογισμό

*/

/*
    Όπου υπάρχει αστερίσκος με αριθμό δίπλα θα υπάρχει σχολιασμός κάτω απο
    τον κώδικα. Επίσης θα υπάρθχει ο αστερίσκος με τον αριθμός σε όποιον τμήμα
    κώδικα αντιστοιχεί το σχόλιο.
*/

// Εισάγουμε τις βιβλιοθήκες που θα χρειαστούμε.
#include <stdio.h>
#include "mpi.h"
#include <stdlib.h>

int main(int argc, char **argv)
{
    // Ορισμός των μεταβλητών μάς.
    int my_rank;
    int p, i, num, n, mod;
    int source, target;
    int tag1 = 50, tag2 = 60, tag3 = 70, tag4 = 80, tag5 = 90, tag6 = 100, tag7 = 110, tag8 = 120, tag9 = 130, tag10 = 140;
    int number_amount;
    int min, max;
    int temp_min, temp_max;
    int *data;
    int *data_loc;
    float *delta;
    float final_result, m, var, result, sum;
    MPI_Status status;
    int choice;

    // Αρχικοποίηση του περιβάλλοντος MPI.
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &p);

    // Φτιάχνουμε ατέρμονα βρόχο ώστε να λειτουργεί επαναληπτικά το πρόγραμμα.
    while (1)
    {
        // Μενού επιλογής.
        if (my_rank == 0) // Θέλουμε οι πληροφόρίες να εμφανίζονται μόνο στην κεντρική διεργασία.
        {
            printf("\nMenu:\n");
            printf("1: Execute the program.\n");
            printf("2: Exit the program.\n");
            printf("\nChoose: ");
            scanf("%d", &choice);

            // Στέλνουμε την επιλογή μας σε όλες τις υπόλοιπες διεργασίες.
            for (target = 1; target < p; target++)
                MPI_Send(&choice, 1, MPI_INT, target, tag10, MPI_COMM_WORLD);
        }
        else // Δέχόνται οι άλλες διεργασίες την είσοδος μας.
            MPI_Recv(&choice, 1, MPI_INT, 0, tag10, MPI_COMM_WORLD, &status);

        switch (choice)
        {
        case 1:
            if (my_rank == 0)
            {
                // Εισάγουμε σε πόσους αριθμούς θέλουμε να κάνουμε τις πράξεις.
                printf("\nEnter the amount of numbers for the program: ");
                scanf("%d", &number_amount);

                // Δεσμέυουμε χώρο για τον πίνακα data.
                data = (int *)malloc(number_amount * sizeof(int));
                if (!data)
                {
                    printf("Error. Cannot allocate memory.");
                    exit(0);
                }

                // Εισάγουμε τους αριθμούς μας και τους αποθηκεύουμε στον πίνακα data.
                printf("\nEnter the numbers you want to be used in the program:\n");
                for (i = 0; i < number_amount; i++)
                {
                    printf("%d\t: ", i + 1);
                    scanf("%d", data + i);
                }

                // Μοιράζουμέ την ποσότητα των αριθμών σε όλες τις διεργασίες.
                for (target = 1; target < p; target++)
                    MPI_Send(&number_amount, 1, MPI_INT, target, tag1, MPI_COMM_WORLD);

                // Κάνουμε την ακέραια διαίρεση και βρίσκουμε και το υπόλοιπο.
                num = number_amount / p;
                mod = number_amount % p;

                // 1*
                if (my_rank < mod)
                {
                    i = num + 1;
                }
                else
                {
                    i = num;
                }

                // *5
                for (target = 1; target < p; target++)
                {
                    // *1
                    if (target < mod)
                    {
                        MPI_Send((data + i), num + 1, MPI_INT, target, tag2, MPI_COMM_WORLD);
                        i = i + (num + 1);
                    }
                    else
                    {
                        MPI_Send((data + i), num, MPI_INT, target, tag2, MPI_COMM_WORLD);
                        i = i + num;
                    }
                }

                // Δεσμέυουμε χώρο για τον πίνακ data_loc.
                data_loc = (int *)malloc(number_amount * sizeof(int));
                if (!data_loc)
                {
                    printf("Error. Cannot allocate memory.");
                    exit(0);
                }

                // *1, *3
                if (my_rank < mod)
                {
                    for (i = 0; i < num + 1; i++)
                        *(data_loc + i) = *(data + i);
                }
                else
                {
                    for (i = 0; i < num; i++)
                        *(data_loc + i) = *(data + i);
                }
            }
            else
            {
                // *2
                data_loc = (int *)malloc(number_amount * sizeof(int));
                if (!data_loc)
                {
                    printf("Error. Cannot allocate memory.");
                    exit(0);
                }

                MPI_Recv(&number_amount, 1, MPI_INT, 0, tag1, MPI_COMM_WORLD, &status);
                // Ξαναορίζουμε το num και το mod επειδή βρισκόμαστε σε άλλους επεξεργαστές.
                num = number_amount / p;
                mod = number_amount % p;

                // *1
                if (my_rank < mod)
                {
                    MPI_Recv(data_loc, num + 1, MPI_INT, 0, tag2, MPI_COMM_WORLD, &status);
                }
                else
                {
                    MPI_Recv(data_loc, num, MPI_INT, 0, tag2, MPI_COMM_WORLD, &status);
                }
            }

            // (α)
            // Εκτελούμε τις πράξεις που χρειάζονται για να βρούμε το m.
            result = 0;
            // *1, *3
            if (my_rank < mod)
            {
                for (i = 0; i < num + 1; i++)
                    result = result + *(data_loc + i);
            }
            else
            {
                for (i = 0; i < num; i++)
                    result = result + *(data_loc + i);
            }

            // *4
            if (my_rank != 0)
                MPI_Send(&result, 1, MPI_FLOAT, 0, tag3, MPI_COMM_WORLD);
            else
            {
                sum = result;
                for (source = 1; source < p; source++)
                {
                    MPI_Recv(&result, 1, MPI_FLOAT, source, tag3, MPI_COMM_WORLD, &status);
                    sum = sum + result;
                }
                n = number_amount;
                m = (float)sum / n;
                printf("\nm\t: %f\n", m);
            }

            // (β)
            if (my_rank == 0)
            {
                for (target = 1; target < p; target++)
                {
                    // Στέλνουμε το m σε όλους τους επεξεργαστές καθώς το χρειάζονται για τις πράξεις τους.
                    MPI_Send(&m, 1, MPI_INT, target, tag4, MPI_COMM_WORLD);
                }
            }
            else
                MPI_Recv(&m, 1, MPI_INT, 0, tag4, MPI_COMM_WORLD, &status);

            result = 0;
            // *1, *3
            if (my_rank < mod)
            {
                for (i = 0; i < num + 1; i++)
                    result = result + (float)(*(data_loc + i) - m) * (*(data_loc + i) - m);
            }
            else
            {
                for (i = 0; i < num; i++)
                    result = result + (float)(*(data_loc + i) - m) * (*(data_loc + i) - m);
            }

            // *4
            if (my_rank != 0)
                MPI_Send(&result, 1, MPI_FLOAT, 0, tag3, MPI_COMM_WORLD);
            else
            {
                sum = result;
                for (source = 1; source < p; source++)
                {
                    MPI_Recv(&result, 1, MPI_FLOAT, source, tag3, MPI_COMM_WORLD, &status);
                    sum = sum + result;
                }
                n = number_amount;
                var = (float)sum / n;
                printf("\nvar\t: %f\n", var);
            }

            // (γ)
            // Βρίσκουμε το μέγιστο και το ελάχιστο της κάθε διεργασίας.
            // *6
            // *3
            temp_min = *(data_loc);
            temp_max = *(data_loc);

            // *1
            if (my_rank < mod)
            {
                for (i = 1; i < num + 1; i++)
                {
                    if (*(data_loc + i) > temp_max)
                        temp_max = *(data_loc + i);

                    if (*(data_loc + i) < temp_min)
                        temp_min = *(data_loc + i);
                }
            }
            else
            {
                for (i = 1; i < num; i++)
                {
                    if (*(data_loc + i) > temp_max)
                        temp_max = *(data_loc + i);

                    if (*(data_loc + i) < temp_min)
                        temp_min = *(data_loc + i);
                }
            }

            // *4
            if (my_rank != 0)
            {
                MPI_Send(&temp_min, 1, MPI_INT, 0, tag5, MPI_COMM_WORLD);
                MPI_Send(&temp_max, 1, MPI_INT, 0, tag6, MPI_COMM_WORLD);
            }
            else
            {
                min = temp_min;
                max = temp_max;
                for (source = 1; source < p; source++)
                {
                    MPI_Recv(&temp_min, 1, MPI_INT, source, tag5, MPI_COMM_WORLD, &status);
                    MPI_Recv(&temp_max, 1, MPI_INT, source, tag6, MPI_COMM_WORLD, &status);

                    if (temp_min < min)
                        min = temp_min;

                    if (temp_max > max)
                        max = temp_max;
                }
                // Εκτυπωνουμε το min, max καθώς η πληροφορία μας είναι χρήσιμη για την υλοποίηση του ερωτήματος.
                printf("\nMin\t: %d\n", min);
                printf("Max\t: %d\n", max);
            }

            // *5, Στέλνουμε το min και το max σε όλες τις διεργσίες καθώς χρειάζονται για τις πράξεις.
            if (my_rank == 0)
            {
                for (target = 1; target < p; target++)
                {
                    MPI_Send(&min, 1, MPI_INT, target, tag7, MPI_COMM_WORLD);
                    MPI_Send(&max, 1, MPI_INT, target, tag8, MPI_COMM_WORLD);
                }
            }
            else
            {
                MPI_Recv(&min, 1, MPI_INT, 0, tag7, MPI_COMM_WORLD, &status);
                MPI_Recv(&max, 1, MPI_INT, 0, tag8, MPI_COMM_WORLD, &status);
            }

            // Η εύρεση του διανύσματος Δ δέν έχει νοήμα αν min == max επειδή θα προκύψει διαίρεση με το μηδέν.
            if (min == max)
            {
                if (my_rank == 0)
                {
                    printf("\nCannot compute di = ((Xi - Xmin)/(Xmax - Xmin))*100.\n");
                    printf("Xmax - Xmin = 0 and division with 0 is not possible.\n");
                }
            }
            else // Αλλιώς γίνονται κανονικά οι πράξεις.
            {
                // Εφόσον μπορεί να υπολογιστεί το Δ τότε δεσμεύουμε χώρος.
                delta = (float *)malloc(number_amount * sizeof(int));
                if (!delta)
                {
                    printf("Error. Cannot allocate memory.");
                    exit(0);
                }
                // *1, *3
                if (my_rank < mod)
                {
                    for (i = 0; i < num + 1; i++)
                        *(delta + i) = ((float)(*(data_loc + i) - min) / (max - min)) * 100;
                }
                else
                {
                    for (i = 0; i < num; i++)
                        *(delta + i) = ((float)(*(data_loc + i) - min) / (max - min)) * 100;
                }

                // *4
                if (my_rank != 0)
                {
                    if (my_rank < mod)
                    {
                        MPI_Send(delta, num + 1, MPI_FLOAT, 0, tag9, MPI_COMM_WORLD);
                    }
                    else
                    {
                        MPI_Send(delta, num, MPI_FLOAT, 0, tag9, MPI_COMM_WORLD);
                    }
                }
                else
                {
                    // *1
                    if (my_rank < mod)
                    {
                        i = num + 1;
                    }
                    else
                    {
                        i = num;
                    }

                    // *4
                    for (source = 1; source < p; source++)
                    {
                        // *1
                        if (source < mod)
                        {
                            MPI_Recv(delta + i, num + 1, MPI_FLOAT, source, tag9, MPI_COMM_WORLD, &status);
                            i = i + (num + 1);
                        }
                        else
                        {
                            MPI_Recv(delta + i, num, MPI_FLOAT, source, tag9, MPI_COMM_WORLD, &status);
                            i = i + num;
                        }
                    }

                    // Εκτυπώνουμε τα στοιχεία του διανύσματος Δ.
                    printf("\n");
                    for (i = 0; i < number_amount; i++)
                    {
                        printf("d[%d]\t: %f\n", i, *(delta + i));
                    }
                }
            }
            break;
        // Περίπτωση για τερματισμό του προγράμματος.
        case 2:
            if (my_rank == 0)
            {
                printf("Ending the program.\n");
                exit(0);
            }
            break;
        // Περίπτωση για εισαγωγή μή έγκυρου αριθμού.
        default:
            if (my_rank == 0)
            {
                printf("Wrong input please try again.\n");
            }
            break;
        }
    }

    // Αποδεσμεύουμε τον χώρο που χρησιμοποιήσαμε για του πίνακες μας.
    free(data);
    free(data_loc);
    free(delta);

    // "Κλείνουμε" το περιβάλλον του MPI.
    MPI_Finalize();
    return 0;
}

/*
    MPI_Send και MPI_Recv είναι οι συναρτήσεις που χρησιμοποιούνται για να στείλουμε
    στοιχεία μεταξύ των διεργασιων.

    *1:
        Το υπόλοιπο της διαίρεσης μας βοηθάει για το διαμοιρασμό στην περίπτωση
        που που οι αριθμοί που εισάγουμε δέν διαιρούνται ακριβώς με το 0.
        Όσες διεργασίες που έχουν βαθμό μικρότερο απο το υπόλοιπο θα έχουν
        ένα παραπάνω στοιχείο να επεξεργαστούν.
        Π.χ.: Διεργασίες = 4
              Αριθμοί που εισάγαμε = 10

              num = 2
              mod = 2

              Οι διεργασίες που έχουν my_rank < 2 θα πάρουν num + 1 στοιχεία
              και ο διαμοιρασμός των στοιχείων θα γίνει ως εξής:

              po: 3 στοιχεία
              p1: 3 στοιχεία
              p2: 2 στοιχεία
              p3: 2 στοιχεία

              3 + 3 + 2 + 2 = 10
              Οπότε τα στοιχεία μοιράζοντα όσο πιο ισοδύναμα γίνεται.

        Το ίδιο ισχύει και για όταν δέχονται στοιχεία από άλλες διεργασίες
        και όταν θέλουν να ξέρουν πόσες φορές χρειάζεται να εκτελεστεί
        μία πράξη.

    *2:
        Πρέπει να δεσμέυσουμε χώρο ξανά για το data_loc επειδή το είχαμε
        δεσμεύσει μόνο για my_rank == 0.

    *3:
        Η κάθε διεργασία κάνει τις πράξεις που χρειάζονται με τους αριθμούς
        που έχει και μετα τους στέλνει στον αρχηγό (my_rank == 0).

    *4:
        Συγκεντρώνουμε όλα τα αποτελέσματα απο την κάθε διεργασία στην κέντρική
        ώστε να γίνουν οι πράξεις και να βρεθεί το τελικό αποτέλεσμα που θέλουμε.

    *5:
        Διαμοιρασμός στοιχείων στις διεργασίες απο τον αρχηγό.
    
    *6:
        Υπολογίζουμε το min και το max υπολογίζοντας το ελάχιστο και μέγιστο της κάθε διεργασίας
        και μετά στον αρχηγό βρίσκουμε την ελάχιστη και μέγιστη τιμή απο απο αυτούς του αριθμούς
        και έτσι προκύπτει το ολικό μέγιστο και ελάχιστο.
*/
