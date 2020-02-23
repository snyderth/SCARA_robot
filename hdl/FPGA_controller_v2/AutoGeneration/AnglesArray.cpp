#include <iostream>
#include <math.h>
using namespace std;


void calculate_angle(int x, int y, double* th1, double* th2){
    double l1 = (5.55 / 11) * pow(2, 14);
    double l2 = (8.25 / 11) * pow(2, 14);
    cout << "l1, l2: " << l1 << ", " << l2 << endl;
    double costh2 = (pow(x, 2) + pow(y, 2) - pow(l1,2) - pow(l2, 2)) / (2 * l1 * l2);
    cout << "Cos theta2: " << costh2 << endl;
    double sinth2 = sqrt(1 - pow(costh2, 2));

    cout << "sin theta2: " << sinth2 << endl;

    double theta2 = atan2(sinth2, costh2);
    cout << "Theta2: " << theta2 << endl;
    double k1 = l1 + (l2 * costh2);
    double k2 = l2 * sinth2;

    double theta1 = atan2(y, x) - atan2(k2, k1);

    *th1 = theta1;
    *th2 = theta2;

}


int main(){

    int x = 3000, y = 3000;
    double th1, th2;

    calculate_angle(x, y, &th1, &th2);

    cout << "Theta1: "<< th1 << ", Theta2: " << th2 << endl;


    return 0;
}