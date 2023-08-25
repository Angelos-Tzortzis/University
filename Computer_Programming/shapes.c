// ������� 2, ������ 5.
#include <stdio.h>

#define PI 3.14 // �������� ��� ���� ��� � �� �������.

int main()
{
    double length,cube_area, cube_vol, sphere_area, sphere_vol;
    /*
        ����� ����� = length.
        ������� ����� = cube_area.
        ����� ����� = cube_vol.
        ������� ������� = sphere_area.
        ����� ������� = sphere_vol.
    */

    // ��������� �� ����� ��� �����.
    printf("Enter the length of edge of the cube in meters: ");
    scanf("%lf", &length);
    
    // ����� ������� �����: � = 6 * (����^2).
    cube_area = 6 * (length*length);
    // ����� ������� �����: V = ����^3.
    cube_vol = length*length*length;
    // ����� ������� �������: � = 4*�*������^.
    sphere_area = 4*PI*length*length;
    // ����� ����� �������: V = (4/3)*�*������^3.
    sphere_vol = (4/3)*PI*length*length*length;
    
    // �������� ��� �������������.
    printf("\nSurface area and volume for the cube:\n");
    printf("Surface area: %lf m^2\n", cube_area);
    printf("Volume:       %lf m^3\n\n\n", cube_vol);
    printf("Surface area and volume for the sphere using the length of the edge as the length of the radius:\n");
    printf("Surface area: %lf m^2\n", sphere_area);
    printf("Volume:       %lf m^3\n", sphere_vol);    

    return 0;
}
