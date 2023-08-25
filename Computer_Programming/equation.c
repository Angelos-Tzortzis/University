// ������� 3, ������ 3.
#include <stdio.h>
#include <math.h> // ���������� ��� �������� ����������� �����������

// ����������� ����� �������������� �������� ��� ������ �x^2+�x+c = 0.
int main()
{
    double a, b, c, d, x1, x2;
    /*
        a = �.
        b = �.
        c = �.
        d = �����������.
        x1 = 1� ���� ��� ��������.
        x2 = 2� ���� ��� ��������.
    */
    
    // �������� ��� ����������� ��� ��������.
    printf("Solve the equation: a*x^2 + b*x + c = 0\n\n");
    printf("Enter the value for a: ");
    scanf("%lf", &a);
    printf("Enter the value for b: ");
    scanf("%lf", &b);
    printf("Enter the value for c: ");
    scanf("%lf", &c);
    printf("\n");
    
    // ��� � = 0 ���� ��� ������ ������������� ������� ��� ��������� ���� ��� ���������.
    if (a == 0)
    {   
        // ��� � = 0 ��� ������ ���� ����������� �������.
        if (b == 0)
        {
            // ��� � = 0 ���� ������ ���������.
            // ��� � != 0 ���� � ������� ����� �������.
            if (c == 0)
                printf("The equation %lf*x^2 + %lf*x + %lf = 0 has infinite solutions.\n", a, b, c);
            else
                printf("The equation %lf = 0 has no real solutions.\n", c);
        }
        else // � != 0 ��� ������ ����������� �������.
        {
            // x = -�/�.
            x1 = x2 = -c/b;
            printf("The equation x = -%lf/%lf has one solution: x = %lf\n", c, b, x1);
        }
    }
    else // � != 0 ��� ������ ������������� �������.
    {
        // ������������ ��� ����������� �� ���� ��� ���� � = �^2 -4��.
        d = b*b - 4*a*c;
        printf("d = %lf\n\n", d);
        
        if (d < 0) // ����� ���� ��� ������ ��� ����������� �������.
            printf("The equation %lf*x^2 + %lf*x + %lf = 0 has no real solutions.\n", a, b, c);
        else if(d == 0) // ��� ����� ����.
        {
            // ������������ ��� ��� ����� ���� x = -�/2�.
            x1 = x2 = -b/2*a;
            printf("The equation %lf*x^2 + %lf*x + %lf = 0 has one solution: x = -%lf/2*%lf = %lf\n", a, b,c, b, a, x1);
        }
        else // 2 �����.
        {
            // ����������� ��� 2 ����� x1 = (-� + ����(�))/2� ��� x2 = (-� - ����(�))/2�.
            x1 = (-b + sqrt(d))/2*a;
            x2 = (-b - sqrt(d))/2*a;
            printf("The equation %lf*x^2 + %lf*x + %lf = 0 has two solutions: x1 = %lf, x2 = %lf\n", a, b, c, x1, x2);
        }
    }
    
    return 0 ;
}

