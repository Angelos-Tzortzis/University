#include <stdio.h>

int main (int NoP, char **Params)
{
    system("chcp 1253");
    int a, b, c;
    int Max;
    printf ("������ �������� �������\n\n");
    printf ("�������� ��� ����� ������   : ");
    scanf ("%d", &a);
    printf ("�������� ��� ������� ������ : ");
    scanf ("%d", &b);
    printf ("�������� ��� ����� ������   : ");
    scanf ("%d", &c);
    if (a > b)
        if (a > c)
            printf("� ����������� ����� � %d ��� ������� 1��\n", a);
        else
            if (a == c)
                printf ("� ����������� ����� � %d ��� ������� 1�� ��� 3��\n", a);
            else
                printf ("� ����������� ����� � %d ��� ������� 3��\n", c);
    else
        if (a == b)
            if (a == c)
                printf ("� ����������� ����� � %d ��� ������� 1��, 2�� ��� 3��\n", a);
            else
                if (a > c)
                    printf ("� ����������� ����� � %d ��� ������� 1�� ��� 2��\n", a);
                else
                    printf ("� ����������� ����� � %d ��� ������� 3��\n", c);
        else
            if (b > c)
                printf ("� ����������� ����� � %d ��� ������� 2��\n", b);
            else
                if (b == c)
                    printf ("� ����������� ����� � %d ��� ������� 2�� ��� 3��\n", a);
                else
                    printf ("� ����������� ����� � %d ��� ������� 3��\n", c);
    return 32;
}
