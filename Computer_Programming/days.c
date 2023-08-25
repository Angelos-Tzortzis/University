// ������� 3, ������ 4.
#include <stdio.h>

// ��������� ����� ����� ��� if.
int main()
{
    // ��������� year ��� month ��� �������� ��� ���������� ��� ����� ��� ��� ���� ����������,
    // ��� days ��� �� ������������ ��� ����� ��� �����������.
    int year, month, days;
    
    printf("Enter a month (1-12): ");
    scanf("%d", &month);
    printf("Enter a year (A.D.): "); // A.D. = M.X.
    scanf("%d", &year);
    
    // �������������� ��� ������ switch �� ���� case �� ����������� �� ���� ����
    // ��� �������� ��� ����� �������� �� ����� ���� �����������.
    // ����������� �� ��������� ������ �������� ��� ���� ��� ���� ��� �����������.
    // ��� ����� ��� ��������� ����� ��� ��� ������������ �� �e�������� ����� ������
    // �������� ��� ������ ��� ��������� �� �������� �������.
    switch(month)
    {
        case 1:
            printf("\nJanuary %d has 31 days.\n", year);
            break;
        case 2:
            // ����� ��������� ������� ���� �� ������� ��� ����� �� 29 ��� �� ���� ����������
            // �� �� 4 ���� ��� �� 100 � �� ���������� �� �� 400, ������ ��� ������� ��� ����� 28.
            days = (((year%4 == 0) && (year%100 != 0)) || year%400 == 0) ? 29 : 28;
            printf("\nFebruary %d has %d days.\n",year,  days);
            break;
        case 3:
            printf("\nMarch %d has 31 days.\n", year);
            break;
        case 4:
            printf("\nApril %d has 30 days.\n", year);
            break;
        case 5:
            printf("\nMay %d has 31 days.\n", year);
            break;
        case 6:
            printf("\nJune %d has 30 days.\n", year);
            break;
        case 7:
            printf("\nJuly %d has 31 days.\n", year);
            break;
        case 8:
            printf("\nAugust %d has 31 days.\n", year);
            break;
        case 9:
            printf("\nSeptember %d has 30 days.\n", year);
            break;
        case 10:
            printf("\nOctober %d has 31 days.\n", year);
            break;
        case 11:
            printf("\nNovember %d has 30 days.\n", year);
            break;
        case 12:
            printf("\nDecember %d has 31 days.\n", year);
            break;
        default:
            // ��� � ������� ��� �������������� ������ ��� ����������� �� ������ ����.
            printf("Did not enter a number that corresponds to a month (1-12).");
            break;
    }
    
    return 0;
}

