#include <stdio.h>

int main()
{
    int lines, i, j;
    
    // ��������� �� ������� ��� ��������.
    printf("Enter the number of lines you want each pattern to be: ");
    scanf("%d", &lines);
    printf("\n");
        
    // 1� �����.
    for (i = 0; i < lines; i++)
    {
        // ����������� ���� ������ ��� ����������� ��������� �������� �� ��� ������ ��� �������
        // �.�. ������ 3, 3 ���������.
        for (j = 0; j <= i; j++)
            printf("*");
        
        printf("\n");
    }
    printf("\n");
    
    // 2� �����.
    // ��������� �� ���� ������ ���� �������� �� ���� ��������� ����������� (�� j ��������� �� i).
    // ��� ���� ��������� ��������� ���� ����� ������ ������ ��� ������� ���� ��� ������� ��� �������.
    for (i = 0; i < lines; i++)
    {
        
        for (j = 0; j < i; j++)
            printf(" ");
                
        for (j = 0; j <= lines - i - 1; j++)
            printf("*");
        
        printf("\n");
    }
    printf("\n");
    
    // 3� �����.
    for (i = 0; i < lines; i++)
    {
        for (j = 0; j < lines - i -1; j++)
            printf(" ");
        
        
        for (j = 0; j < 2*i + 1; j++)
        {
            if (j == (2*i + 1) / 2)
                printf(".");
            else
                printf("*");
        }
            
        printf("\n");
    }
    printf("\n");
    
    // 4� �����.
    // �� ������ ��� ���������� ��� �������� ���������� �� ������ ���� i � j ����� ���� 0 � lines ����� ���������� ���� �����.
    // T� ������ ��� ��������� ����� ���� ���� i = j.
    // T� ������ ��� 2�� ��������� ����� ���� ���� �� �������� ��� i, j ��� ������� ����� lines - 1.
    for (i = 0; i < lines; i++)
    {
        for (j = 0; j < lines; j++)
        {
            if (i == 0 || j == 0 || i == lines - 1 || j == lines - 1)
                printf("*");
            else if (i == j || i + j == lines-1)
                printf(".");
            else
                printf(" ");
        }
        
        printf("\n");
    }
    
    return 0;
}

