//
//  main.c
//  Homework4
//
//  Created by Антон Головатый on 18.07.2022.
//

#include <stdio.h>
#include<string.h>
#define filePath "/Users/antongolovatyj/Курсы по обучению 2021-2022/Обучение iOS/Дополнительные курсы/2. Алгоритмы и структуры данных. Базовый курс./Домашние задания/Algoritms_and_data_structures_GB_HW/Homework4/data.txt"
#define readMode "r"
#define rows 6
#define cols 6
#define M 8
#define N 8

void routesNumberTask(void);
void longestCommonSubstringTask(void);
void knightMovesTask(void);

void printDivider(void)
{
    puts("======================================");
    puts("======================================");
    puts("======================================\n");
}

int main(int argc, const char * argv[]) {
    
    routesNumberTask();
    printDivider();
    longestCommonSubstringTask();
    printDivider();
    knightMovesTask();
    
    return 0;
}

//Solution 1
int map[rows][cols];
int array[rows][cols];

void getDataFromFile(void);
void fillArrayWithData(void);
void printArray(int array[rows][cols]);

void routesNumberTask(void)
{
    getDataFromFile();
    puts("Input map:");
    printArray(map);
    fillArrayWithData();
    puts("Result matrix:");
    printArray(array);
}

void getDataFromFile(void)
{
    FILE *in;
    int m, n;
    in = fopen(filePath, readMode);
    fscanf(in, "%i", &m);
    fscanf(in, "%i", &n);
    
    for (int j = 0; j < cols; j++)
    {
        for (int i = 0; i < rows; i++)
        {
            fscanf(in, "%i", &map[i][j]);
        }
    }
}

void fillArrayWithData(void)
{
    for (int j = 0; j < cols; j++)
    {
        for (int i = 0; i < rows; i++)
        {
            if (map[i][j] == 0)
            {
                array[i][j] = 0;
                continue;
            }
            
            if (i == 0 || j == 0)
            {
                array[i][j] = 1;
                continue;
            }
            
            array[i][j] = array[i][j - 1] + array[i - 1][j];
        }
    }
}

void printArray(int array[rows][cols])
{
    for (int j = 0; j < cols; j++)
    {
        for (int i = 0; i < rows; i++)
        {
            printf("%4i", array[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

//Solution 2
int i, j, firstSeqLength, secondSeqLength, scores[20][20];
char firstSeq[20], secondSeq[20], chars[20][20];

void getUsersInput(void);
void createMatrix(void);
void printResult(void);
void fillBordersInArray(void);
void printMatrix(void);
void printSubsequence(int i, int j);

void longestCommonSubstringTask(void)
{
    getUsersInput();
    createMatrix();
    printResult();
}

void getUsersInput(void)
{
    printf("Enter 1st sequence:");
    scanf("%s", firstSeq);
    printf("Enter 2nd sequence:");
    scanf("%s", secondSeq);
    printf("\n");
}

void createMatrix(void)
{
    firstSeqLength = strlen(firstSeq);
    secondSeqLength = strlen(secondSeq);
    
    fillBordersInArray();
    
    //c, u и l обозначают направления (cross up left)
    for (i = 1; i <= firstSeqLength; i++)
        for (j = 1; j <= secondSeqLength; j++)
        {
            if (firstSeq[i - 1] == secondSeq[j - 1])
            {
                scores[i][j] = scores[i - 1][j - 1] + 1;
                chars[i][j] = 'c';
                continue;
            }
            
            if (scores[i - 1][j] >= scores[i][j - 1])
            {
                scores[i][j] = scores[i - 1][j];
                chars[i][j] = 'u';
            }
            else
            {
                scores[i][j] = scores[i][j - 1];
                chars[i][j] = 'l';
            }
        }
    
    printMatrix();
}

void fillBordersInArray(void)
{
    for (i = 0; i <= firstSeqLength; i++)
        scores[i][0] = 0;
    for (i = 0; i <= secondSeqLength; i++)
        scores[0][i] = 0;
}

void printMatrix(void)
{
    puts("The lcs matrix:");
    printf("   ");
    
    for (i = 0; i < secondSeqLength; i++)
        printf("%4c", secondSeq[i]);
    printf("\n");
    
    for (i = 0; i <= firstSeqLength; i++)
    {
        if (i > 0)
            printf("%c", firstSeq[i - 1]);
        for (j = 0; j <= secondSeqLength; j++)
        {
            if (i == 0)
                printf("%4i", scores[i][j]);
            else
                printf("%3i%c", scores[i][j], chars[i][j]);
        }
        printf("\n");
    }
}

void printResult(void)
{
    printf("\nThe Longest Common Subsequence is ");
    printSubsequence(firstSeqLength, secondSeqLength);
    printf("\n");
}

void printSubsequence(int i, int j)
{
    if (i == 0 || j == 0)
        return;
    
    if (chars[i][j] == 'c')
    {
        printSubsequence(i - 1, j - 1);
        printf("%c", firstSeq[i - 1]);
    }
    else if (chars[i][j] == 'u')
        printSubsequence(i - 1, j);
    else
        printSubsequence(i, j - 1);
}

//Solution 3
int board[M][N];

struct Position
{
    int row;
    int col;
};

void prepareBoard(void);
int findSolution(int moveNumber);
void printBoard(void);
int isNoMovesLeft(int moveNumber);
struct Position getCurrentPosition(int moveNumber);
int isMovePossible(struct Position startPosition, struct Position endPosition);
int isBoardPositionEmpty(struct Position position);
int isKnightMoveScheme(struct Position startPosition, struct Position endPosition);
int tryToMove(struct Position movePosition, int moveNumber);

void knightMovesTask(void)
{
    prepareBoard();
    
    //Стартовая точка
    //Можно выбрать любую в рамках доски (координаты от (0,0) до (7,7))
    board[0][0] = 1;
    
    findSolution(2);
    printBoard();
}

void prepareBoard(void)
{
    for (int i = 0; i < M; i++)
        for (int j = 0; j < N; j++)
        {
            board[i][j] = 0;
        }
}

int findSolution(int moveNumber)
{
    if (isNoMovesLeft(moveNumber))
        return 1;
    
    struct Position currentPosition, movePosition;
    int row, col;
    
    currentPosition = getCurrentPosition(moveNumber - 1);
    
    for (row = 0; row < M; row++)
        for (col = 0; col < N; col++)
        {
            movePosition.row = row;
            movePosition.col = col;
            
            if (isMovePossible(currentPosition, movePosition))
                if (tryToMove(movePosition, moveNumber))
                    return 1;
        }
    
    return 0;
}

int isNoMovesLeft(int moveNumber)
{
    if (moveNumber > (M * N))
        return 1;
    return 0;
}

struct Position getCurrentPosition(int moveNumber)
{
    struct Position result;
    result.row = -1;
    result.col = -1;
    
    for (int row = 0; row < M; row++)
        for (int col = 0; col < N; col++)
        {
            if (board[row][col] == moveNumber)
            {
                result.row = row;
                result.col = col;
                return result;
            }
        }
    
    return result;
}

int isMovePossible(struct Position startPosition, struct Position endPosition)
{
    if (isBoardPositionEmpty(endPosition) && isKnightMoveScheme(startPosition, endPosition))
        return 1;
    return 0;
}

int isBoardPositionEmpty(struct Position position)
{
    if (board[position.row][position.col] == 0)
        return 1;
    return 0;
}

//Проверка 8 возможных вариантов хода конем
int isKnightMoveScheme(struct Position startPosition, struct Position endPosition)
{
    if ((startPosition.row - 2) == endPosition.row && (startPosition.col - 1) == endPosition.col)
        return 1;
    else if ((startPosition.row - 2) == endPosition.row && (startPosition.col + 1) == endPosition.col)
        return 1;
    else if ((startPosition.row - 1) == endPosition.row && (startPosition.col - 2) == endPosition.col)
        return 1;
    else if ((startPosition.row - 1) == endPosition.row && (startPosition.col + 2) == endPosition.col)
        return 1;
    else if ((startPosition.row + 1) == endPosition.row && (startPosition.col - 2) == endPosition.col)
        return 1;
    else if ((startPosition.row + 1) == endPosition.row && (startPosition.col + 2) == endPosition.col)
        return 1;
    else if ((startPosition.row + 2) == endPosition.row && (startPosition.col - 1) == endPosition.col)
        return 1;
    else if ((startPosition.row + 2) == endPosition.row && (startPosition.col + 1) == endPosition.col)
        return 1;
    
    return 0;
}

int tryToMove(struct Position movePosition, int moveNumber)
{
    board[movePosition.row][movePosition.col] = moveNumber;
    if (findSolution(moveNumber + 1))
        return 1;
    board[movePosition.row][movePosition.col] = 0;
    return 0;
}

void printBoard(void)
{
    for (int i = 0; i < M; i++)
    {
        for (int j = 0; j < N; j++)
        {
            printf("%4i", board[i][j]);
        }
        printf("\n\n");
    }
    printf("\n");
}
