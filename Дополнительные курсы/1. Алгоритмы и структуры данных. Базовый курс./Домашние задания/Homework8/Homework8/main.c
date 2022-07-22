//
//  main.c
//  Homework8
//
//  Created by Антон Головатый on 21.07.2022.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MaxN 100000
int savedArray[MaxN];
int numbers[MaxN];

int operationsCounters[3];
int counter;
int taskTimers[3];
int timer;

void createRandomNumberSequence(void);
void saveRandomNumberSequence(void);
void restoreRandomNumberSequence(void);
void printRandomNumberSequence(void);
void countSortTask(void);
void quickSortTask(void);
void mergeSortTask(void);
void comparisonTask(void);

void saveData(int counter, int timer, int index);

int main(int argc, const char * argv[])
{
    createRandomNumberSequence();
    saveRandomNumberSequence();
    
    puts("Random array:");
    printRandomNumberSequence();
    
    countSortTask();
    restoreRandomNumberSequence();
    
    quickSortTask();
    restoreRandomNumberSequence();
    
    mergeSortTask();
    
    comparisonTask();
    
    return 0;
}

void createRandomNumberSequence(void)
{
    int divider = MaxN * 2;
    
    for (int i = 0; i < MaxN; i++)
        numbers[i] = rand() % divider;
}

void saveRandomNumberSequence(void)
{
    for (int i = 0; i < MaxN; i++)
        savedArray[i] = numbers[i];
}

void restoreRandomNumberSequence(void)
{
    for (int i = 0; i < MaxN; i++)
        numbers[i] = savedArray[i];
}

void printRandomNumberSequence(void)
{
    for (int i = 0; i < MaxN; i++)
        printf("%d ", numbers[i]);
    printf("\n\n");
}

void saveData(int counter, int timer, int index)
{
    operationsCounters[index] = counter;
    taskTimers[index] = timer;
}

//Solution 1
void countSort(int *numbers, int elementsCount);
int getMax(int *numbers, int elementsCount);

void countSortTask(void)
{
    counter = 0;
    timer = 0;
    
    puts("Count sort:");
    clock_t start = clock();
    countSort(numbers, MaxN);
    clock_t time = clock() - start;
    timer = ((int)time) * 1000 / CLOCKS_PER_SEC;
    printRandomNumberSequence();
    
    saveData(counter, timer, 0);
}

void countSort(int *numbers, int elementsCount)
{
    int max = getMax(numbers, elementsCount);
    int count[max + 1], output[max + 1];
    
    for (int i = 0; i <= max; i++)
    {
        count[i] = 0;
        counter++;
    }
    
    for (int i = 0; i < elementsCount; i++)
    {
        count[numbers[i]]++;
        counter++;
    }
    
    for (int i = 1; i <= max; i++)
    {
        count[i] += count[i - 1];
        counter++;
    }
    
    for (int i = elementsCount - 1; i >= 0; i--)
    {
        output[count[numbers[i]] - 1] = numbers[i];
        count[numbers[i]]--;
        counter++;
    }
    
    for (int i = 0; i < elementsCount; i++)
    {
        numbers[i] = output[i];
        counter++;
    }
}

int getMax(int *numbers, int elementsCount)
{
    int max = numbers[0];
    
    for (int i = 0; i < elementsCount; i++)
    {
        if (numbers[i] > max)
            max = numbers[i];
    }
    
    return max;
}

//Solution 2
void quickSort(int *numbers, int left, int right);

void quickSortTask(void)
{
    counter = 0;
    timer = 0;
    
    puts("Quick sort:");
    clock_t start = clock();
    quickSort(numbers, 0, MaxN - 1);
    clock_t time = clock() - start;
    timer = time * 1000 / CLOCKS_PER_SEC;
    printRandomNumberSequence();
    
    saveData(counter, timer, 1);
}

void quickSort(int *numbers, int left, int right)
{
    int pivot;
    int leftSaved = left;
    int rightSaved = right;
    pivot = numbers[left];
    
    while (left < right)
    {
        counter++;
        while ((numbers[right] >= pivot) && (left < right))
        {
            counter++;
            right--;
        }
        
        if (left != right)
        {
            numbers[left] = numbers[right];
            left++;
            counter++;
        }
        
        while ((numbers[left] <= pivot) && (left < right))
        {
            left++;
            counter++;
        }
        
        if (left != right)
        {
            numbers[right] = numbers[left];
            right--;
            counter++;
        }
    }
    counter++;
    
    numbers[left] = pivot;
    pivot = left;
    left = leftSaved;
    right = rightSaved;
    
    if (left < pivot)
        quickSort(numbers, left, pivot - 1);
    
    if (right > pivot)
        quickSort(numbers, pivot + 1, right);
}

//Solution 3
void mergeSort(int arr[], int l, int r);
void merge(int arr[], int l, int m, int r);

void mergeSortTask(void)
{
    counter = 0;
    timer = 0;
    
    puts("Merge sort:");
    clock_t start = clock();
    mergeSort(numbers, 0, MaxN - 1);
    clock_t time = clock() - start;
    timer = time * 1000 / CLOCKS_PER_SEC;
    printRandomNumberSequence();
    
    saveData(counter, timer, 2);
}

void mergeSort(int *numbers, int left, int right)
{
    if (left < right)
    {
        int middle = left + (right - left) / 2;
        mergeSort(numbers, left, middle);
        mergeSort(numbers, middle + 1, right);
        
        merge(numbers, left, middle, right);
    }
    counter++;
}

void merge(int *numbers, int left, int middle, int right)
{
    int i, j, k;
    int leftPartCount = middle - left + 1;
    int rightPartCount = right - middle;
    int leftPart[leftPartCount], rightPart[rightPartCount];
    
    for (i = 0; i < leftPartCount; i++)
        leftPart[i] = numbers[left + i];
    
    for (j = 0; j < rightPartCount; j++)
        rightPart[j] = numbers[middle + 1+ j];
    
    i = 0;
    j = 0;
    k = left;
    
    while (i < leftPartCount && j < rightPartCount)
    {
        if (leftPart[i] <= rightPart[j])
        {
            numbers[k] = leftPart[i];
            i++;
        }
        else
        {
            numbers[k] = rightPart[j];
            j++;
        }
        k++;
    }
    
    while (i < leftPartCount)
    {
        numbers[k] = leftPart[i];
        i++;
        k++;
    }
    
    while (j < rightPartCount)
    {
        numbers[k] = rightPart[j];
        j++;
        k++;
    }
}

//Solution 4
void comparisonTask(void)
{
    puts("Sorting method |  N elements  | N operations | Time (ms)");
    printf("Count sort     |    %7i   | %10i   | %5i\n", MaxN, operationsCounters[0], taskTimers[0]);
    printf("Quick sort     |    %7i   | %10i   | %5i\n", MaxN, operationsCounters[1], taskTimers[1]);
    printf("Merge sort     |    %7i   | %10i   | %5i\n", MaxN, operationsCounters[2], taskTimers[2]);
}
