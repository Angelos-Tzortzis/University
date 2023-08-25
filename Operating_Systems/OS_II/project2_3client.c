/*
    Εργαστήριο Λειτουργικά Συστήματα ΙΙ / Άσκηση 2 / Ερώτημα 3 / 2022-2023.
    Ονοματεπώνυμο: Άγγελος Τζώρτζης.
    Α.Μ.: ice18390094.
    Τρόπος μεταγλώττισης: gcc -o server project2_3client.c -lpthread.
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/types.h>
#include <unistd.h>

// Ορίζουμε το path του socket.
#define SOCK_PATH "/home/angelos/socket"

int main()
{
    int sock;
    struct sockaddr_un server;
    char message[100];

    // Δημιουργία socket.
    if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) == -1)
    {
        perror("Socket error.\n");
        exit(1);
    }

    // Server path.
    server.sun_family = AF_UNIX;
    strcpy(server.sun_path, SOCK_PATH);

    // Σύνδεση με τον server.
    if (connect(sock, (struct sockaddr *)&server, sizeof(struct sockaddr_un)) == -1)
    {
        perror("Connection error.\n");
        exit(1);
    }

    printf("Connected to server.\n\n");

    while (1)
    {
        // Get message from user
        printf("Enter a message: ");
        fgets(message, 100, stdin);
        // Send the message to the server
        send(sock, message, strlen(message), 0);

        // Receive and print the server's response
        recv(sock, message, 100, 0);
        printf("Server response: %s\n", message);
    }

    return 0;
}
