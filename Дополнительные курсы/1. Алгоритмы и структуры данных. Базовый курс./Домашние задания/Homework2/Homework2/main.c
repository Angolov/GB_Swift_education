//
//  main.c
//  Homework2
//
//  Created by Антон Головатый on 29.06.2022.
//

#include <stdio.h>

void menu(void);
void solution1(void);
void solution2(void);

int main(int argc, const char * argv[])
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
    printf("Please select on of the options below:\n");
    printf("1 - task 1\n");
    printf("2 - task 2\n");
    printf("0 - exit\n");
}

/*
 1. Реализовать функцию перевода из десятичной системы в двоичную, используя рекурсию.
 */

void toBinary(int num);

void solution1()
{
    int num;
    printf("Please enter the number you wish to convert to binary: ");
    scanf("%d", &num);
    
    printf("Your decimal %d is converted to binary: b", num);
    toBinary(num);
    printf("\n\n");
}

void toBinary(int num)
{
    if (num >= 2) toBinary(num / 2);
    printf("%d", num % 2);
}

/*
 2. Реализовать функцию возведения числа a в степень b:
    a. без рекурсии;
    b. рекурсивно;
    c. *рекурсивно, используя свойство четности степени.
 */

int noRecurse(int num, int power);
int recurse(int num, int power);
int quickRecurse(int num, int power);

void solution2()
{
    int selection = -1;
    int num, power;
    int result;
    
    printf("Please input your number and power: ");
    scanf("%d %d", &num, &power);
    
    while (selection != 0)
    {
        printf("Please select one of the options below:\n");
        printf("1 - no recurse\n");
        printf("2 - with recurse\n");
        printf("3 - with recurse and quick algoritm\n");
        
        scanf("%i", &selection);
        switch(selection)
        {
            case 1:
                selection = 0;
                result = noRecurse(num, power);
                break;
            case 2:
                selection = 0;
                result = recurse(num, power);
                break;
            case 3:
                selection = 0;
                result = quickRecurse(num, power);
                break;
            default:
                result = -1;
                printf("Wrong selection! Try again.\n\n");
        }
        
        printf("Your number %d power %d equals: %d", num, power, result);
        printf("\n\n");
    }
}

int noRecurse(int num, int power)
{
    int result = 1;
    
    for (int i = 1; (i <= power); i++)
    {
        if (i == 0) result = 1;
        else result *= num;
    }
    return result;
}

int recurse(int num, int power)
{
    if (power == 0) return 1;
    return recurse(num, --power) * num;
}

int quickRecurse(int num, int power)
{
    if (power == 0) return 1;
    if ((power % 2) == 0)
    {
        int result = recurse(num, power / 2);
        return result * result;
    }
    else
    {
        return recurse(num, --power) * num;
    }
}
