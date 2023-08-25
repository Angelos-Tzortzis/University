/*
    Εργαστήριο Λειτουργικά Συστήματα ΙΙ / Άσκηση 1 / Ερώτημα 2 / 2022-2023.
    Ονοματεπώνυμο: Άγγελος Τζώρτζης.
    Α.Μ.: ice18390094.
    Τρόπος μεταγλώττισης: gcc -o project1_extension project1_extension.c.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    int p1, p2, p3, p4, p5, p6, fd[2], n, status, process_number, pid, i;
    char *message = "hello from your child\n";
    char text[100];

    // Αρχικοποίηση του pipe για επικοινωνία μεταξύ διεργασιών.
    pipe(fd);

    // Εισάγουμε πόσες διεργασίες Θέλουμε να δημιουργήσει η p2.
    // Επιλέγουμε να επιλέξουμε τον αριθμό διεργασιών πρίν γίνουν τα fork ώστε
    printf("Enter the number of children for p2 to create: ");
    scanf("%d", &process_number);

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

        // Φτιάχνουμε τις διεργασίες, τυπώνουμε τις πληροφορίες τους και τις τερματίζουμε.
        for (i = 0; i < process_number; i++)
        {
            pid = fork();

            if (pid == 0)
            {
                printf("p2: child[%d]: pid = %d, ppid = %d\n", i + 1, getpid(), getppid());
                exit(0);
            }
        }

        // Αναμονή τερματισμού μίας απο τις διεργασίες παιδιά
        // printf("process with pid: %d terminated.\n", wait(&status));
        // Καθώς αναμένουμε τον τερματισμό μόνο μίας διεργασίας υπάρχει περίπτωση
        // να τερματίσoυν κάποια από τα N παιδιά χώρίς να γίνει δεκτό το αίτημα
        // τερματισμού τους από την p2 και να γίνουν zombie. Παρόμοια λογική
        // ισχύει και για την δημιουργία των orphans καθώς η p2 δεν αναμένει τον
        // τερματισμό τους οπότε μπορεί να τερματίσει η p2 πρίν προλάβουν να τερματίσουν
        // όλα τα παιδιά.
        // Eκτύπωση του pid της διεργασίας που τερμάτισε.
        printf("process with pid: %d terminated.\n", wait(&pid));

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
