/*
    Άγγελος Τζώρτζης
    ice18390094
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

#define PORT 9000 // Επιλογή θύρας σύνδεσης.

// Function for error messages.
void error(char *message)
{
    perror(message);
    exit(0);
}

int main(int argc, char **argv)
{
    int port_number, socket_fd, choice, array_length, data, i, res1;
    float res2[2], r, *res3;
    int *array_x, *array_y;
    struct hostent *server;
    struct sockaddr_in server_address;

    // Check if we have the correct amount of arguments.
    if (argc != 3)
    {
        fprintf(stderr, "Usage: %s hostname port\n", argv[0]);
        exit(0);
    }

    // Setting up the socket client.
    port_number = atoi(argv[2]);

    socket_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (socket_fd < 0)
        error("Error opening socket!");

    server = gethostbyname(argv[1]);
    if (server == NULL)
    {
        fprintf(stderr, "Error, no such host!\n");
        exit(0);
    }

    bzero((char *)&server_address, sizeof(server_address));
    server_address.sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&server_address.sin_addr.s_addr, server->h_length);
    server_address.sin_port = htons(port_number);

    // Connecting to the socker server.
    printf("Trying to connect to server...\n");
    if (connect(socket_fd, (struct sockaddr *)&server_address, sizeof(server_address)) < 0)
        error("Error connecting!");

    printf("Connection successful.\n\n");

    while (1)
    {
        printf("------------------------------\n");
        printf("Menu\n");
        printf("1. Find the inner product of two arrays\n");
        printf("2. Find the averages of two arrays\n");
        printf("3. Find the result of r*(X+Y) (r: real number, X and Y: arrays of the same length)\n");
        printf("4. Exit\n\n");

        printf("Choose which operation to implement: ");
        scanf("%d", &choice);
        send(socket_fd, &choice, sizeof(choice), 0);

        switch (choice)
        {
        case 1:
            printf("Enter the size of the two arrays: ");
            scanf("%d", &array_length);
            send(socket_fd, &array_length, sizeof(array_length), 0);

            array_x = (int *)malloc(sizeof(int) * array_length);
            array_y = (int *)malloc(sizeof(int) * array_length);

            printf("\nEnter data for array x:\n");
            for (i = 0; i < array_length; i++)
            {
                printf("array_x[%d]: ", i);
                scanf("%d", &array_x[i]);
            }
            send(socket_fd, array_x, sizeof(int) * array_length, 0);

            printf("\nEnter data for array y:\n");
            for (i = 0; i < array_length; i++)
            {
                printf("array_y[%d]: ", i);
                scanf("%d", &array_y[i]);
            }
            send(socket_fd, array_y, sizeof(int) * array_length, 0);

            recv(socket_fd, &res1, sizeof(res1), 0);

            printf("\nInner product: %d\n\n", res1);

            free(array_x);
            free(array_y);

            break;

        case 2:
            printf("Enter the size of the two arrays: ");
            scanf("%d", &array_length);
            send(socket_fd, &array_length, sizeof(array_length), 0);
            array_x = (int *)malloc(sizeof(int) * array_length);
            array_y = (int *)malloc(sizeof(int) * array_length);

            printf("\nEnter data for array x:\n");
            for (i = 0; i < array_length; i++)
            {
                printf("array_x[%d]: ", i);
                scanf("%d", &array_x[i]);
            }
            send(socket_fd, array_x, sizeof(int) * array_length, 0);

            printf("\nEnter data for array y:\n");
            for (i = 0; i < array_length; i++)
            {
                printf("array_y[%d]: ", i);
                scanf("%d", &array_y[i]);
            }
            send(socket_fd, array_y, sizeof(int) * array_length, 0);

            recv(socket_fd, res2, sizeof(res2), 0);

            printf("\nAverage of array x: %f\n", res2[0]);
            printf("Average of array y: %f\n\n", res2[1]);

            free(array_x);
            free(array_y);

            break;

        case 3:
            printf("Enter the size of the two arrays: ");
            scanf("%d", &array_length);
            printf("Array length: %d.\n", array_length);
            send(socket_fd, &array_length, sizeof(array_length), 0);
            array_x = (int *)malloc(sizeof(int) * array_length);
            array_y = (int *)malloc(sizeof(int) * array_length);

            printf("Enter the number r(real number): ");
            scanf("%f", &r);
            printf("r: %lf.\n", r);
            send(socket_fd, &r, sizeof(r), 0);

            printf("\nEnter data for array x:\n");
            for (i = 0; i < array_length; i++)
            {
                printf("array_x[%d]: ", i);
                scanf("%d", &array_x[i]);
            }
            printf("Array_x: ");
            for(i=0;i< array_length; i++)
            {
                printf("%d, ", array_x[i]);
            }
            send(socket_fd, array_x, sizeof(int) * array_length, 0);

            printf("\nEnter data for array y:\n");
            for (i = 0; i < array_length; i++)
            {
                printf("array_y[%d]: ", i);
                scanf("%d", &array_y[i]);
            }
            printf("Array_y: ");
            for(i=0;i< array_length; i++)
            {
                printf("%d, ", array_y[i]);
            }
            send(socket_fd, array_y, sizeof(int) * array_length, 0);

            res3 = (float *)malloc(sizeof(float) * array_length);
            recv(socket_fd, res3, sizeof(float) * array_length, 0);

            printf("\nResult of r*(X+Y): ");
            printf("[");
            for (i = 0; i < array_length - 1; i++)
            {
                printf("%lf, ", res3[i]);
            }
            printf("%lf]\n\n", res3[array_length - 1]);

            free(array_x);
            free(array_y);

            free(res3);

            break;
        case 4:
            printf("Exiting...\n");
            exit(0);
            break;
        default:
            printf("Error please enter a valid option.\n");
            break;
        }
    }

    close(socket_fd);

    return 0;
}
