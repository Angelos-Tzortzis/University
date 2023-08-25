/*
    Εργαστήριο Λειτουργικά Συστήματα ΙΙ / Άσκηση 2 / Ερώτημα 1 / 2022-2023.
    Ονοματεπώνυμο: Άγγελος Τζώρτζης.
    Α.Μ.: ice18390094.
    Τρόπος μεταγλώττισης: gcc -o project2_1 project2_1.c -lpthread.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int d, f_index, last, total_max, N; // f_index = first index, d = N/p.
int **A;
pthread_t *threads;
pthread_barrier_t bar;
pthread_mutex_t mutex1;
pthread_mutex_t mutex2;

void find_max(); // Συνάρτηση εύρεσης μεγίστου στον πίνακα.

int main()
{
    int p, i, j;

    srand(time(NULL));

    printf("Enter the number of threads to create (0 to exit): ");
    scanf("%d", &p);

    // Εάν ο χρήστης θέλει 0 threads τερματίζει το πρόγραμμα.
    if (p == 0)
        exit(0);
    else if (p < 0)
    {
        printf("Invalid number of threads.\n");
        exit(1);
    }

    printf("Enter the size of the NxN array: ");
    scanf("%d", &N);

    // Δεσμέουμε χώρο για τον πίνακα για όσα threads θέλουμε να φτιάξουμε.
    threads = (pthread_t *)malloc(p * sizeof(pthread_t));
    // Δεσμέουμε χώρος για το μέγεθός του πίνακα που εισάγαμε.
    A = (int **)malloc(N * sizeof(int *));
    for (i = 0; i < N; i++)
        A[i] = (int *)malloc(N * sizeof(int));

    // Εισαγωγή τυχαίων αριθμών.
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
            A[i][j] = rand() % 100;
    }

    // Είσαγωγή αριθμών από τον χρήστη.
    // for (i = 0; i < N; i++)
    // {
    //     for (j = 0; j < N; j++)
    //     {
    //         printf("Enter the element A[%d][%d]: ", i, j);
    //         scanf("%d", &A[i][j]);
    //     }
    // }

    // Εκτύπωση πίνακα.
    printf("\nArray:\n");
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
            printf("%2d ", A[i][j]);
        printf("\n");
    }

    // Εύρεση πηλίκο του N με το p ώστε να ξέρουμε πώς θα χωρίσουμε τον πίνακα.
    d = N / p;
    // Αρχικοποίηση της θέσης που θα αρχίσει την έυρεση το 1ο thread.
    f_index = 0;

    // Δημιουργία των threads.
    pthread_mutex_init(&mutex1, NULL);
    pthread_mutex_init(&mutex2, NULL);
    pthread_barrier_init(&bar, NULL, p);
    for (int i = 0; i < p; i++)
        pthread_create(&threads[i], NULL, (void *)&find_max, NULL);

    // Αναμονή όλων των threads.
    for (int i = 0; i < p; i++)
        pthread_join(threads[i], NULL);

    // Εκτύπωση μεγίστου.
    printf("\nMax: %d\n", total_max);

    // Αποδέσμευση χώρου που χρησιμοποιήθηκε.
    free(threads);
    for (int i = 0; i < N; i++)
        free(A[i]);

    free(A);

    return 0;
}

void find_max()
{
    int new_index, local_max, i, j;

    // "Κλείδωμα" κρίσιμου τμήματος κώδικα ώστε να μήν μπορεί να επέμβει κάποιο άλλo thread.
    pthread_mutex_lock(&mutex);
    new_index = f_index;

    f_index = f_index + d;
    pthread_mutex_unlock(&mutex);
    // "Ξεκλείδωμα" κρίσιμου τμήματος κώδικα.

    local_max = A[new_index][0];

    for (i = 0; i < d; i++)
    {
        for (j = 0; j < N; j++)
        {
            if (A[new_index + i][j] > local_max)
                local_max = A[new_index + i][j];
        }
    }

    if (local_max > total_max)
    {
        pthread_mutex_lock(&mutex1);
        total_max = local_max;
        pthread_mutex_unlock(&mutex1);
    }
    pthread_barrier_wait(&bar);
}
