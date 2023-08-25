// Εργασία 2, άσκηση 4.
#include <stdio.h>
#include <math.h> // Βιβλιοθήκη με μαθηματικές συναρτήσεις.

int main()
{	
	int x, y;
	int sum, diff, prod, quot, rem, square;
	/*
		άθροισμα = sum.
		διαφορά = difference = diff.
		γινόμενο = product = prod.
		πηλίκο = quotient = quot.
		υπόλοιπο = remainder = rem.
		τετράγωνο = square.
	*/ 
	double r_quot, root;
	// πραγματικό πηλίκο = real quotient = r_quot.
	// τετραγωνική ρίζα = root.
	
	// Εισαγωγή των αριθμών.
	printf("Enter the 1st number: ");
	scanf("%d", &x);
	printf("Enter the 2nd number: ");
	scanf("%d", & y);
	
	// Κάνουμε τις πράξεις για κάθε αποτέλεσμα που θέλουμε να βγάλουμε.
	sum = x + y;
	diff = x - y;
	prod = x*y;
	quot = x/y;
	rem = x%y;
	
	// Εκτελούμε την πραγματική διαίρεση.
	// Μετατροπή του x σε πραγματικό αριθμό ώστε να μπορεί να γίνει η διαίρεση.
	r_quot = (double)x/y;
	
	// Υπολογίζουμε το τετράγωνο του πρώτου αριθμού.
	square = x*x;
	
	/*
        Yπολογίζουμε την τετραγωνική ρίζα του 2ου αριθμού με χρήση της
        συνάρτησης sqrt() που βρίσκεται στην βιβλιοθήκη math.h.
	*/
	root = sqrt(y);
	
	// Eκτύπωση των αποτελεσμάτων.
	printf("\nSum:\n%d + %d = %d\n\n", x, y, sum);
	printf("Difference:\n%d - %d = %d\n\n", x, y, diff);
	printf("Product:\n%d * %d = %d\n\n", x, y, prod);
	printf("Quotient:\n%d / %d = %d\n\n", x, y, quot);
	printf("Remainder:\n%d %% %d = %d\n\n", x, y, rem);
	printf("Real quotient:\n%d / %d = %lf\n\n", x, y, r_quot);
	printf("Square of %d:\n%d\n\n", x, square);
	printf("Square root of %d:\n%lf\n", y, root);
	
	return 0;
}

