//
//  main.c
//  Homework1
//
//  Created by Антон Головатый on 29.06.2022.
//

#include <stdio.h>
#include <math.h>

void solution1();
void solution2();
void solution3();
void solution4();
void menu();

int main(int argc, char* argv[])
{
    int selection = -1;

    while (selection != 0)
    {
        menu();
        scanf("%i", &selection);
        switch(selection)
        {
        case 1:
            solution1();
            break;
        case 2:
            solution2();
            break;
        case 3:
            solution3();
            break;
        case 4:
            solution4();
            break;
        case 0:
            printf("Thank you!\n");
            break;
        default:
            printf("Wrong selection! Try again.\n\n");
        }
    }

    return 0;
}

void menu()
{
    printf("Please select on of the oprions below:\n");
    printf("1 - task 1\n");
    printf("2 - task 2\n");
    printf("3 - task 3\n");
    printf("4 - task 4\n");
    printf("0 - exit\n");
}

/*
    Ввести вес и рост человека. Рассчитать и вывести индекс массы тела по формуле I=m/(h*h);
    где m-масса тела в килограммах, h - рост в метрах.
*/

void solution1()
{
    double weight, height;
    double weightIndex;
    printf("Input weight in kilograms and height in meters: ");
    scanf("%lf %lf", &weight, &height);
    weightIndex = weight / (pow(height, 2));
    printf("Your weight index is %.6f\n", weightIndex);
}

/*
    Найти максимальное из четырех чисел. Массивы не использовать.
*/

void solution2()
{
    int a, b, c, d;
    printf("Input four numbers: ");
    scanf("%i %i %i %i", &a, &b, &c, &d);

    a = (a < b) ? b : a;
    c = (c < d) ? d : c;
    a = (a < c) ? c : a;
    
    printf("Maximum number is %i\n", a);
}

/*
    Написать программу обмена значениями двух целочисленных переменных:
        a. с использованием третьей переменной;
        b. *без использования третьей переменной.
*/

void usingThirdVariable(int a, int b);
void notUsingThirdVariable(int a, int b);

void solution3()
{
    int selection = -1;
    int a, b;
    printf("Input variables 'a' and 'b': ");
    scanf("%i %i", &a, &b);

    while (selection)
    {
        printf("Choose algoritm for switching variables:\n");
        printf("1 - with third variable\n");
        printf("2 = without third variable\n");
        printf("0 - exit\n");
        scanf("%i", &selection);
        switch (selection)
        {
        case 1:
            usingThirdVariable(a, b);
            selection = 0;
            break;

        case 2:
            notUsingThirdVariable(a, b);
            selection = 0;
            break;
        
        case 0:
            printf("Have a nice day!\n");
            break;

        default:
            printf("Wrong selection! Try again.\n");
            break;
        }
    }
}

void usingThirdVariable(int a, int b)
{
    int c = a;
    a = b;
    b = c;
    printf("a = %i, b = %i\n", a, b);
}

void notUsingThirdVariable(int a, int b)
{
    a = a + b;
    b = a - b;
    a = a - b;
    printf("a = %i, b = %i\n", a, b);
}

/*
    Написать программу нахождения корней заданного квадратного уравнения.
*/

void solution4()
{
    double a, b, c;
    double d;
    double x1, x2;

    printf("Input the coefficients 'A', 'B' and 'C': ");
    scanf("%lf %lf %lf", &a, &b, &c);

    if (a == 0) {
        x1 = c / b;
        printf("Coefficient 'A' = 0.\nOnly one root exists: %.2f\n", x1);
    }
    else
    {
        d = pow(b, 2) - 4 * a * c;
        if (d < 0)
        {
            printf("Determinant is negative\nNo roots available\n");
        }
        else if (d == 0)
        {
            x1 = - b / 2 * a;
            printf("Determinant equals zero\nThe only root is: x = %.2f\n", x1);
        }
        else
        {
            x1 = (- b + sqrt(d)) / 2 * a;
            x2 = (- b - sqrt(d)) / 2 * a;
            printf("The roots are: x1 = %.2f, x2 = %.2f\n", x1, x2);
        }
    }
}
