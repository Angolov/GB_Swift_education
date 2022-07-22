//
//  main.c
//  Homework3
//
//  Created by Антон Головатый on 15.07.2022.
//

#include <stdio.h>
#define MaxN 100
#define filePath "/Users/antongolovatyj/Курсы по обучению 2021-2022/Обучение iOS/Дополнительные курсы/2. Алгоритмы и структуры данных. Базовый курс./Домашние задания/Algoritms_and_data_structures_GB_HW/Homework3/arrayFile.txt"

void swap(int *a, int *b)
{
    int t = *a;
    *a = *b;
    *b = t;
}

void print(int N, int *a)
{
    for (int i = 0; i < N; i++)
        printf("%6i", a[i]);
    printf("\n");
}

void readArrayFromFile(int *N, int *a)
{
    FILE *in;
    in = fopen(filePath, "r");
    fscanf(in, "%i", N);
    for (int i = 0; i < *N; i++)
    {
        fscanf(in, "%i", &a[i]);
    }
    fclose(in);
}

int bubbleSortNotOptimised(int N, int *a)
{
    int counter = 0;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N - 1; j++)
        {
            counter++;
            if (a[j] > a[j+1])
            {
                counter++;
                swap(&a[j], &a[j+1]);
            }
        }
    }
    return counter;
}

void bubbleSortVersionOne(void)
{
    int a[MaxN];
    int N, counter;
    
    readArrayFromFile(&N, a);
    
    puts("Array before sort");
    print(N, a);
    counter = bubbleSortNotOptimised(N, a);
    puts("Array after sort");
    print(N, a);
    printf("Number of operations: %i\n\n", counter);
}

//Solution 1
int bubbleSortOptimised(int N, int *a)
{
    int counter = 0;
    int rightMark = N - 1;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < rightMark; j++)
        {
            counter++;
            if (a[j] > a[j+1])
            {
                counter++;
                swap(&a[j], &a[j+1]);
            }
        }
        rightMark--;
    }
    return counter;
}

void bubbleSortVersionTwo(void)
{
    int a[MaxN];
    int N, counter;
    
    readArrayFromFile(&N, a);
    
    puts("Array before sort");
    print(N, a);
    counter = bubbleSortOptimised(N, a);
    puts("Array after sort");
    print(N, a);
    printf("Number of operations: %i\n\n", counter);
}

//Solution 2
int goRight(int leftMark, int rightMark, int *a)
{
    int counter = 0;
    for (int j = leftMark; j < rightMark; j++)
    {
        counter++;
        if (a[j] > a[j+1])
        {
            counter++;
            swap(&a[j], &a[j+1]);
        }
    }
    return counter;
}

int goLeft(int leftMark, int rightMark, int *a)
{
    int counter = 0;
    for (int j = rightMark; j >= leftMark; j--)
    {
        counter++;
        if (a[j] > a[j+1])
        {
            counter++;
            swap(&a[j], &a[j+1]);
        }
    }
    return counter;
}

int shakerSort(int N, int *a)
{
    int counter = 0;
    
    int leftMark = 0;
    int rightMark = N - 1;
    
    while (leftMark <= rightMark)
    {
        counter += goLeft(leftMark, rightMark, a);
        leftMark++;
        
        counter += goRight(leftMark, rightMark, a);
        rightMark--;
    }
    
    return counter;
}

void shakerSortVersion(void)
{
    int a[MaxN];
    int N, counter;
    
    readArrayFromFile(&N, a);
    
    puts("Array before sort");
    print(N, a);
    counter = shakerSort(N, a);
    puts("Array after sort");
    print(N, a);
    printf("Number of operations: %i\n\n", counter);
}

//Solution 3
int getUserInput(void)
{
    int element;
    puts("Please input searched number");
    scanf("%i", &element);
    return element;
}

int checkBordersForElement(int element, int N, int *a)
{
    if (element == a[N - 1])
        return N - 1;
    
    if (element == a[0])
        return 0;
    
    return -1;
}

int binarySearchInArray(int element, int N, int *a)
{
    int elementsCount = N;
    int middleIndex = N / 2;
    int startIndex = 0;
    int endIndex = N - 1;
    int result = -1;
    
    result = checkBordersForElement(element, N, a);
    if (result >= 0)
        return result;
    
    while (elementsCount >= 2)
    {
        if (element == a[middleIndex])
            return middleIndex;
        
        if (element > a[middleIndex])
            startIndex += elementsCount / 2;
        
        if (element < a[middleIndex])
            endIndex -= elementsCount / 2;
        
        elementsCount = endIndex - startIndex + 1;
        middleIndex = startIndex + elementsCount / 2;
    }
    
    return result;
}

void printResult(int result)
{
    if (result < 0)
    {
        puts("Element not found\n\n");
    }
    else
    {
        printf("Element found at index: %i\n\n", result);
    }
}

void searchElement(void)
{
    int a[MaxN];
    int N, element, result;
    
    readArrayFromFile(&N, a);
    element = getUserInput();
    shakerSort(N, a);
    result = binarySearchInArray(element, N, a);
    print(N, a);
    printResult(result);
}

int main(int argc, const char *argv[]) {
    
    bubbleSortVersionOne();
    bubbleSortVersionTwo();
    shakerSortVersion();
    searchElement();
    
    return 0;
}
