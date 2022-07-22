//
//  main.c
//  Homework7
//
//  Created by Антон Головатый on 20.07.2022.
//

#include <stdio.h>
#include <stdlib.h>

//Изменить при использовании
#define filepath "/Users/antongolovatyj/Курсы по обучению 2021-2022/Обучение iOS/Дополнительные курсы/2. Алгоритмы и структуры данных. Базовый курс./Домашние задания/Algoritms_and_data_structures_GB_HW/Homework7/matrix.txt"
#define readMode "r"

#define MaxN 50

#define true 1
#define false 0
typedef int bool;

int vertices;
int sourceMatrix[MaxN][MaxN];
bool visited[MaxN];

void readMatrixTask(void);
void depthFirstSearchTask(void);
void breadthFirstSearchTask(void);

int main(int argc, const char * argv[])
{
    readMatrixTask();
    depthFirstSearchTask();
    breadthFirstSearchTask();
    
    return 0;
}

//Solution 1
void getMatrixFromFile(void);
void printMatrix(int matrix[MaxN][MaxN]);

void readMatrixTask(void)
{
    getMatrixFromFile();
    printMatrix(sourceMatrix);
}

void getMatrixFromFile(void)
{
    FILE *dataFile;
    
    dataFile = fopen(filepath, readMode);
    fscanf(dataFile, "%i", &vertices);
    
    for (int i = 0; i < vertices; i++)
        for (int j = 0; j < vertices; j++)
            fscanf(dataFile, "%i", &sourceMatrix[i][j]);
    
    fclose(dataFile);
}

void printMatrix(int matrix[MaxN][MaxN])
{
    printf("%s","      ");
    
    for (int i = 0; i < vertices; i++)
        printf("%c(%i) ", 65 + i, i);
    printf("\n");
    
    for (int i = 0; i < vertices; i++)
    {
        printf("%c(%i)", 65 + i, i);
        for (int j = 0; j < vertices; j++)
        {
            printf("%5i", sourceMatrix[i][j]);
        }
        printf("\n");
    }
}

//Solution 2
void emptyVisitedArray(void);
void depthFirstSearch(int vertexIndex);

void depthFirstSearchTask(void)
{
    puts("Depth First Search algoritm:");
    emptyVisitedArray();
    depthFirstSearch(0);
    printf("\n");
}

void emptyVisitedArray(void)
{
    for (int i = 0; i < vertices; i++)
        visited[i] = false;
}

void depthFirstSearch(int vertexIndex)
{
    visited[vertexIndex] = true;
    
    printf("Vertex %c(%i) visited\n", 65 + vertexIndex, vertexIndex);
    
    for (int neighbor = 0; neighbor < vertices; neighbor++)
    {
        if (sourceMatrix[vertexIndex][neighbor] && !visited[neighbor])
            depthFirstSearch(neighbor);
    }
}

//Solution 3
typedef int queue;

queue toBeVisited[MaxN];
int queueStart = 0;
int queueEnd = 0;

void push(int vertixIndex);
int pop(void);
bool queueIsEmpty(void);
bool queueHasElements(void);

void breadthFirstSearch(void);

void breadthFirstSearchTask(void)
{
    puts("Breadth First Search algoritm:");
    emptyVisitedArray();
    breadthFirstSearch();
    printf("\n");
}

void breadthFirstSearch(void)
{
    push(0);
    visited[0] = true;
    
    while (queueHasElements())
    {
        int currentVertex = pop();
        
        printf("Vertex %c(%i) visited\n", 65 + currentVertex, currentVertex);
        
        for (int neighbor = 0; neighbor < vertices; neighbor++)
        {
            if (!visited[neighbor])
            {
                push(neighbor);
                visited[neighbor] = true;
            }
        }
    }
}

void push(int vertixIndex)
{
    if (queueEnd >= MaxN)
    {
        puts("ERROR: Queue overflow");
        return;
    }
    
    toBeVisited[queueEnd] = vertixIndex;
    queueEnd++;
}

int pop(void)
{
    if (queueStart == queueEnd)
    {
        puts("ERROR: Queue is empty");
        return -1;
    }

    return toBeVisited[queueStart++];
}

bool queueIsEmpty(void)
{
    if (queueStart == queueEnd)
        return true;
    return false;
}

bool queueHasElements(void)
{
    if (queueStart != queueEnd)
        return true;
    return false;
}
