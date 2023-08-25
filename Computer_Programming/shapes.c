// Εργασία 2, άσκηση 5.
#include <stdio.h>

#define PI 3.14 // Ορίζουμε την τιμή του π ώς σταθερά.

int main()
{
    double length,cube_area, cube_vol, sphere_area, sphere_vol;
    /*
        μήκος ακμής = length.
        εμβαδόν κύβου = cube_area.
        όγκος κύβου = cube_vol.
        εμβαδόν σφαίρας = sphere_area.
        όγκος σφαίρας = sphere_vol.
    */

    // Εισάγουμε το μήκος της ακμής.
    printf("Enter the length of edge of the cube in meters: ");
    scanf("%lf", &length);
    
    // Τύπος εμβαδού κύβου: Ε = 6 * (ακμή^2).
    cube_area = 6 * (length*length);
    // Τύπος εμβαδού κύβου: V = ακμή^3.
    cube_vol = length*length*length;
    // Τύπος εμβαδού σφαίρας: Ε = 4*π*ακτίνα^.
    sphere_area = 4*PI*length*length;
    // Τύπος όγκος σφαίρας: V = (4/3)*π*ακτίνα^3.
    sphere_vol = (4/3)*PI*length*length*length;
    
    // Εμφάνιση των αποτελεσμάτων.
    printf("\nSurface area and volume for the cube:\n");
    printf("Surface area: %lf m^2\n", cube_area);
    printf("Volume:       %lf m^3\n\n\n", cube_vol);
    printf("Surface area and volume for the sphere using the length of the edge as the length of the radius:\n");
    printf("Surface area: %lf m^2\n", sphere_area);
    printf("Volume:       %lf m^3\n", sphere_vol);    

    return 0;
}
