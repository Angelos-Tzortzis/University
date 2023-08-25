/*
    Εργαστήριο Λειτουργικά Συστήματα ΙΙ / Άσκηση 2 / Ερώτημα 3 / 2022-2023.
    Ονοματεπώνυμο: Άγγελος Τζώρτζης.
    Α.Μ.: ice18390094.
    Τρόπος μεταγλώττισης: gcc -o server project2_3server.c -lpthread.
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/types.h>
#include <unistd.h>

#define SOCK_PATH "/home/angelos/socket"

void *array_average(void *arg);

int main()
{
    int sock1;
    struct sockaddr_un client;

    char message[100];

    // Δημιουργία socket.
    if ((sock1 = socket(AF_UNIX, SOCK_STREAM, 0)) == -1)
    {
        perror("Socket error.\n");
        exit(1);
    }

    // Client path.
    client.sun_family = AF_UNIX;
    strcpy(client.sun_path, SOCK_PATH);
    unlink(client.sun_path);

    // bind socket.
    if (bind(sock1, (struct sockaddr *)&client, sizeof(struct sockaddr_un)))
    {
        perror("Bind error.\n");
        exit(1);
    }

    // To πρόγραμμα είναι έτοιμο να δεχτεί συνδέσεις.
    if (listen(sock1, 1) == -1)
    {
        perror("Listen error.\n");
        exit(1);
    }

    while(1)
    {

        // Read data from the client
        recv(sock1, message, 100, 0);
            printf("Client message: %s\n", message);

            // Send a message to the client
            send(sock1, message, strlen(message), 0);
            printf("Response sent to the client\n");
    }

    return 0;
}
