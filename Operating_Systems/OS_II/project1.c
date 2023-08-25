/*
    Εργαστήριο Λειτουργικά Συστήματα ΙΙ / Άσκηση 1 / Ερώτημα 2 / 2022-2023.
    Ονοματεπώνυμο: Άγγελος Τζώρτζης.
    Α.Μ.: ice18390094.
    Τρόπος μεταγλώττισης: gcc -o project1 project1.c.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    int p1, p2, p3, p4, p5, p6, fd[2], n, status;
    char *message = "hello from your child\n";
    char text[100];

    // Αρχικοποίηση του pipe για επικοινωνία μεταξύ διεργασιών.
    pipe(fd);

    // Εκτύπωση των πληροφοριών της διεργασίας p0.
    printf("p0: pid = %d, ppid = %d\n", getpid(), getppid());

    // Δημουργία διεργασίας p1.
    p1 = fork();
    if (p1 == 0)
    {
        printf("p1: pid = %d, ppid = %d\n", getpid(), getppid());

        // Δημιουργία διεργασίας p3.
        p3 = fork();
        if (p3 == 0)
        {
            printf("p3: pid = %d, ppid = %d\n", getpid(), getppid());
            // Κλείσιμο τις άκρης ανάγνωσης του pipe.
            close(fd[0]);
            // Εγγραφή μηνύματος στο pipe.
            write(fd[1], message, strlen(message) + 1);
            // Κλείσιμο της άκρης εγγραφής του pipe.
            close(fd[1]);
            exit(0);
        }

        // Δημιουργία διεργασίας p4.
        p4 = fork();
        if (p4 == 0)
        {
            printf("p4: pid = %d, ppid = %d\n", getpid(), getppid());
            exit(0);
        }

        // Aναμονή τερματισμού τις διεργασίας p3.
        waitpid(p3, NULL, 0);
        // Κλείσιμο της άκρης εγγραφής του pipe.
        close(fd[1]);
        // Ανάγνωση από το pipe.
        n = read(fd[0], text, sizeof(text));
        // Γράφουμε στο stdout το μήνυμα που διαβάσαμε από το pipe.
        write(1, text, n);
        // Κλείσιμο της άκρης ανάγνωσης του pipe.
        close(fd[0]);

        // Αναμονή τερματισμού τις διεργασίας p4 και παίρνουμε την κατάσταση εξόδου του.
        waitpid(p4, &status, 0);
        // Τυπώνουμε την κατάσταση εξόδου της p4.
        printf("p4 terminated with code %d.\n", status >> 8);

        exit(0);
    }

    // Δημιουργία τις διεργασίας p2.
    p2 = fork();
    if (p2 == 0)
    {
        printf("p2: pid = %d, ppid = %d\n", getpid(), getppid());

        // Δημιουργία τις διεργασίας p5.
        p5 = fork();
        if (p5 == 0)
        {
            printf("p5: pid = %d, ppid = %d\n", getpid(), getppid());
            exit(0);
        }

        // Δημιουργία τις διεραγσίας p6.
        p6 = fork();
        if (p6 == 0)
        {
            printf("p6: pid = %d, ppid = %d\n", getpid(), getppid());
            exit(0);
        }

        // Αναμονή τερματισμού μίας απο τις διεργασίες παιδιά
        // printf("process with pid: %d terminated.\n", wait(&status));
        // Καθώς αναμένουμε τον τερματισμό μόνο μίας διεργασίας υπάρχει περίπτωση
        // να τερματίσει η p5 ή  η p6 χώρίς να γίνει δεκτό το αίτημα τερματισμού
        // από την p2 και να γίνει μία από αυτές zombie. Η ίδια λογική ισχύει και
        // για την δημιουργία του orphan καθώς η p2 μπορεί να τερματίσει πριν
        // την ολοκλήρωση είτε της p5 είτε της p6. Και όποια δεν τερματίσει γίνεται orphan.
        // Eκτύπωση του pid της διεργασίας που τερμάτισε.
        printf("process with pid: %d terminated.\n", wait(&status));

        exit(0);
    }

    // Αναμονή τερματισμού διεργασίας p2.
    // waitpid(p1, NULL, 0);
    // Καθώς δέν αναμένουμε την p1 να τερματίσει υπάρχει περίπτωση
    // να τερματίσει και να μήν γίνει δεκτό το αίτημα τερματίσμου της
    // και να παραμείνει στην μνήμη σαν zombie. Η ίδια λογική ισχύει και
    // για την περίπτωση η p1 να είναι orphan καθώς η p0 μπορεί να τερματίσει πρίν
    // προλάβει να τερματίσει η p1 και να γίνει orphan έτσι.
    waitpid(p2, NULL, 0);
    // Εκτέλεση της εντολή ps.
    execl("/bin/ps", "ps", NULL);

    return 0;
}
