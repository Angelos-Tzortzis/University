// ������� 2, ������ 4.
#include <stdio.h>
#include <math.h> // ���������� �� ����������� �����������.

int main()
{	
	int x, y;
	int sum, diff, prod, quot, rem, square;
	/*
		�������� = sum.
		������� = difference = diff.
		�������� = product = prod.
		������ = quotient = quot.
		�������� = remainder = rem.
		��������� = square.
	*/ 
	double r_quot, root;
	// ���������� ������ = real quotient = r_quot.
	// ����������� ���� = root.
	
	// �������� ��� �������.
	printf("Enter the 1st number: ");
	scanf("%d", &x);
	printf("Enter the 2nd number: ");
	scanf("%d", & y);
	
	// ������� ��� ������� ��� ���� ���������� ��� ������� �� ��������.
	sum = x + y;
	diff = x - y;
	prod = x*y;
	quot = x/y;
	rem = x%y;
	
	// ��������� ��� ���������� ��������.
	// ��������� ��� x �� ���������� ������ ���� �� ������ �� ����� � ��������.
	r_quot = (double)x/y;
	
	// ������������ �� ��������� ��� ������ �������.
	square = x*x;
	
	/*
        Y����������� ��� ����������� ���� ��� 2�� ������� �� ����� ���
        ���������� sqrt() ��� ��������� ���� ���������� math.h.
	*/
	root = sqrt(y);
	
	// E������� ��� �������������.
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

