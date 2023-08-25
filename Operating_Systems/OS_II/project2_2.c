/*
    Εργαστήριο Λειτουργικά Συστήματα ΙΙ / Άσκηση 2 / Ερώτημα 2 / 2022-2023.
    Ονοματεπώνυμο: Άγγελος Τζώρτζης.
    Α.Μ.: ice18390094.
    Τρόπος μεταγλώττισης: gcc -o project2_2 project2_2.c -lpthread.
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

void print_one();
void print_two();
void print_three();

// Δημιουργία σημαφόρων.
sem_t sem1;
sem_t sem2;
sem_t sem3;

int main()
{
    pthread_t thread1, thread2, thread3;

    // Αρχικοποίηση σημαφόρων.
    sem_init(&sem1, 0, 1);
    sem_init(&sem2, 0, 0);
    sem_init(&sem3, 0, 0);

    // Δημιουργία των threads.
    pthread_create(&thread1, NULL, (void *)&print_one, NULL);
    pthread_create(&thread2, NULL, (void *)&print_two, NULL);
    pthread_create(&thread3, NULL, (void *)&print_three, NULL);

    // Αναμονή των threads.
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_join(thread3, NULL);

    printf("\n");

    return 0;
}

void print_one()
{
    while (1)
    {
        sem_wait(&sem1); // Aναμονή τιμή σημαφόρου > 0 και μετά μείωση της τιμής της.
        printf("<one> ");
        sem_post(&sem2); // Αύξηση τιμής σημαφόρου.
    }
}

void print_two()
{
    while (1)
    {
        sem_wait(&sem2);
        printf("<two> ");
        sem_post(&sem3);
    }
}

void print_three()
{
    while (1)
    {
        sem_wait(&sem3);
        printf("<three> ");
        sem_post(&sem1);
    }
}
