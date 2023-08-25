#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// �������� �� � ��� ����� ��� ���������.
#define PI 3.14159265


// ��������� ��� ����������� ��� ������������.
void menu();
void sine();
double convert_to_rads(double degrees);
double compute_sine(double rads);
void cosine();
double compute_cosine(double rads);
void power();
double compute_power(int x, int y);
void combo();
int compute_combo(int n, int k);
int factorial(int x);

int main()
{
    menu();
    
    return 0;
}

// ��������� ��� ��� ����� ��� ������������.
void menu()
{
    int choice;
    
    do
    {
        system("cls");
        printf("Menu\n");
        printf("---------------------------------------------------------\n");
        printf("1. Compute the sine of an angle (degrees)\n");
        printf("2. Compute the cosine of an angle (degrees)\n");
        printf("3. Compute the power of x^y\n");
        printf("4. Compute the combinations for n elements in groups of k\n");
        printf("5. Exit\n\n");
        
        printf("Enter your choice: ");
        scanf("%d", &choice);
        
        // �� ���� ������� ������� ��� ��������� ��� ���� ����������.
        switch (choice)
        {
            case 1:
                sine();
                break;
            
            case 2:
                cosine();
                break;
            
            case 3:
                power();
                break;
            
            case 4:
                combo();
                break;
        }
        
        system("pause");
    } while (choice != 5);
}

// ��������� ��� ��������� ��� ������ �� �������, �� ���� ��� ����.
double convert_to_rads(double degrees)
{
    double rads;
    
    rads = degrees * PI/180;
}

// ��������� ��� �� ��������� � ���������� ����������� ��������.
void sine()
{
    double degrees, rads, output;
    
    do
    {
        printf("Enter the angle (between 0 - 360 degrees): ");
        scanf("%lf", &degrees);
    } while (degrees < 0 || degrees > 360); // ������� ������ 0 ��� 2�.
    
    rads = convert_to_rads(degrees);
    
    output = compute_sine(rads);
    printf("sin(%lf) = %lf\n", degrees, output);
}
// ������������ �� ������� ���� ��� ������� 4.
double compute_sine(double rads)
{
    int sign = -1, y = 3;
    double result, previous, current;
    
    result = rads;
    current = rads;
    do
    {
        previous = current;
        current = previous * rads*rads/(y*(y - 1));
        result += current * sign;
        sign *= -1;
        y += 2;
    } while (fabs(current - previous) >= 0.000001);
    
    return result;
}

// ��������� ��� �� ��������� � ���������� ����������� �����������.
void cosine()
{
    double degrees, rads, output;
    
    do
    {
        printf("Enter the angle (between 0 - 360 degrees): ");
        scanf("%lf", &degrees);
    } while (degrees < 0 || degrees > 360);
    
    convert_to_rads(degrees);
    
    output = compute_cosine(rads);
    printf("cos(%lf) = %lf\n", degrees, output);
}

// ������������ �� ���������� �� ��� ���� ������ �� �� ������� �� ���� ����������� ����.
double compute_cosine(double rads)
{
    int sign = -1, y = 2;
    double result, previous, current;
    
    result = 1;
    current = 1;
    do
    {
        previous = current;
        current = previous*rads*rads/(y*(y - 1));
        result += current*sign;
        sign *= -1;
        y += 2;
    } while (fabs(current - previous) >= 0.000001);
    
    return result;
}

// ��������� ��� �� ��������� � ���������� ��� ������������ �������.
void power()
{
    int x, y;
    double output;
    
    printf("Enter the base number (x): ");
    scanf("%d", &x);
    printf("Enter the exponent (y): ");
    scanf("%d", &y);
    
    output = compute_power(x, y);
    
    printf("%d^%d = %lf\n", x, y, output);
}

// ��������� ����������� �������.
double compute_power(int x, int y)
{
    double result;
    int i;
    
    result = 1;
    /*
        ������������ ����� ��� ������ �� ��� ������� ���� ��� ������,
        ��� ��� � ������� ����� ��������� ������������� ��� ������ ������ x^y -> 1/x^y.
    */
    for (i = 0; i < fabs(y); i++)
        result *= x;
        
    if (y < 0)
        result = 1/result;
    
    return result;
}

// ��������� ��� �� ��������� � ���������� ����������� ���������� � ��� �.
void combo()
{
    int n, k, result;
    
    printf("Enter N: ");
    scanf("%d", &n);
    printf("Enter K: ");
    scanf("%d", &k);
    
    result = compute_combo(n, k);
    
    printf("%d!/(%d!*(%d - %d))! = %d\n", n, k, n, k, result);
}

// ��������� ��� ���������� ����������.
int compute_combo(int n, int k)
{
    int result;
    result = factorial(n)/(factorial(k) * factorial(n - k));
    return result;
}

// ��������� ��� ���������� ������������
int factorial(int x)
{
    int result, i;
    
    result = 1;
    if (x > 1)
    {
        for (i = 2; i <= x; i++)
            result *= i;
    }
    return result;
}
