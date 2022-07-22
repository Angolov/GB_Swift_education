//
//  main.c
//  homework5
//
//  Created by Антон Головатый on 19.07.2022.
//

#include <stdio.h>
#include <mm_malloc.h>
#include <string.h>
#define stackMaxSize 100
#define T char
#define MaxSize 30

void menu(void);
int getUserSelection(void);
void launchSelectedTask(int taskNumber);

void decimalToBinaryTask(void);
void memoryAllocationCheckTask(void);
void bracketsCheckTask(void);
void copySingleLinkedListTask(void);
void infixToPostfixTask(void);

int main(int argc, const char* argv[]) {
    
    menu();
    return 0;
}

void menu(void)
{
    int userSelection;
    userSelection = getUserSelection();
    launchSelectedTask(userSelection);
}

int getUserSelection(void)
{
    int userSelection = -1;
    while (userSelection == -1)
    {
        puts("Please select the task:");
        puts("1 - Task 1");
        puts("2 - Task 2");
        puts("3 - Task 3");
        puts("4 - Task 4");
        puts("5 - Task 5");
        puts("0 - exit");
        scanf("%i", &userSelection);
        
        if (userSelection < 0 || userSelection > 5)
        {
            puts("Wrong selection. Try again.");
            userSelection = -1;
        }
        printf("\n");
    }
    
    return userSelection;
}

void launchSelectedTask(int taskNumber)
{
    switch (taskNumber)
    {
        case 1:
            decimalToBinaryTask();
            break;
        
        case 2:
            memoryAllocationCheckTask();
            break;
        
        case 3:
            bracketsCheckTask();
            break;
            
        case 4:
            copySingleLinkedListTask();
            break;
            
        case 5:
            infixToPostfixTask();
            break;
            
        default:
            break;
    }
}

//Solution 1
int stack[stackMaxSize];
int stackIndex = -1;

int getUserNumber(void);
void decimalToBinary(int number);
void printFromStack(void);
void simpleStackPush(int value);
int simpleStackPop(void);

void decimalToBinaryTask(void)
{
    int number;
    
    number = getUserNumber();
    decimalToBinary(number);
    printFromStack();
}

int getUserNumber(void)
{
    int usersNumber;
    puts("Please input the number:");
    scanf("%i", &usersNumber);
    return usersNumber;
}

void decimalToBinary(int number)
{
    int remainder;
    
    while (number > 1)
    {
        remainder = number % 2;
        simpleStackPush(remainder);
        
        number = number / 2;
    }
    simpleStackPush(number);
}

void printFromStack(void)
{
    int number;
    
    printf("Your number in binary is: ");
    
    while (stackIndex >= 0)
    {
        number = simpleStackPop();
        printf("%i", number);
    }
    printf("\n\n");
}

void simpleStackPush(int value)
{
    if (stackIndex == (stackMaxSize - 1))
    {
        puts("Stack Overflow");
        return;
    }

    stackIndex++;
    stack[stackIndex] = value;
}

int simpleStackPop(void)
{
    if (stackIndex < 0)
    {
        puts("Stack is empty");
        return -1;
    }

    return stack[stackIndex--];
}

//Solution 2
struct TNode
{
    T value;
    struct TNode *next;
};

typedef struct TNode Node;

struct Stack
{
    Node *head;
    int size;
    int maxSize;
};

struct Stack MyStack;

void push(T value)
{
    if (MyStack.size >= MyStack.maxSize)
    {
        puts("Stack Overflow");
        return;
    }
    
    Node *tmp = (Node*)malloc(sizeof(Node));
    
    //Проверка согласно условию второго задания
    if (tmp == NULL)
    {
        puts("Memmory was not allocated");
        return;
    }
    
    tmp->value = value;
    tmp->next = MyStack.head;
    MyStack.head = tmp;
    MyStack.size++;
}

T pop(void)
{
    if (MyStack.size == 0)
    {
        puts("Stack is empty");
        return -1;
    }
    
    Node* next = NULL;
    T value;
    value = MyStack.head->value;
    next = MyStack.head;
    MyStack.head = MyStack.head->next;
    free(next);
    MyStack.size--;
    
    return value;
}

T peek(void)
{
    if (MyStack.size == 0)
    {
        puts("Stack is empty");
        return -1;
    }
    
    T value;
    value = MyStack.head->value;
    return value;
}

void memoryAllocationCheckTask(void)
{
    MyStack.maxSize = 100;
    MyStack.head = NULL;
    
    push('a');
    push('b');
    push('c');
    push('d');
    push('e');
    push('f');
    
    while (MyStack.size != 0) {
        printf("|%c|\n", pop());
    }
}

//Solution 3
char userInput[MaxSize];
int userInputLength = 0;

void getUserInput(void);
int isBracketInputCorrect(void);
void printResult(int result);
void prepareStack(void);
int isOpenningBracket(char c);
int isClosingBracket(char c);
int isRightClosingBracket(char bracket);

void bracketsCheckTask(void)
{
    int result;
    
    getUserInput();
    result = isBracketInputCorrect();
    printResult(result);
}

void getUserInput(void)
{
    puts("Please input your example below (not more than 30 symbols):");
    scanf("%s", userInput);
}

int isBracketInputCorrect(void)
{
    userInputLength = strlen(userInput);
    
    prepareStack();
    
    for (int i = 0; i < userInputLength; i++)
    {
        if (isOpenningBracket(userInput[i]))
            push(userInput[i]);
        
        if (isClosingBracket(userInput[i]))
        {
            if (isRightClosingBracket(userInput[i]))
                pop();
            else
                return 0;
        }
    }
    
    if (MyStack.size == 0)
        return 1;
    
    return 0;
}

void prepareStack(void)
{
    MyStack.maxSize = MaxSize;
    MyStack.head = NULL;
}

int isOpenningBracket(char c)
{
    if (c == '(' || c == '{' || c == '[')
        return 1;
    return 0;
}

int isClosingBracket(char c)
{
    if (c == ')' || c == '}' || c == ']')
        return 1;
    return 0;
}

int isRightClosingBracket(char bracket)
{
    char stackBracket;
    stackBracket = peek();
    
    if (stackBracket == '(' && bracket == ')')
        return 1;
    if (stackBracket == '{' && bracket == '}')
        return 1;
    if (stackBracket == '[' && bracket == ']')
        return 1;
    
    return 0;
}

void printResult(int result)
{
    if (result == 1)
    {
        puts("Brackets are correct");
        return;
    }
    puts("Brackets are not correct");
}

//Solution 4
struct SingleLinkedList
{
    Node *head;
    int size;
};

struct SingleLinkedList sourceList, copyList;

void createSourceList(void);
void copySourceList(void);
void printLists(void);
void deleteSomeElementsFromSource(void);

void copySingleLinkedListTask(void)
{
    createSourceList();
    copySourceList();
    printLists();
    deleteSomeElementsFromSource();
    printLists();
}

void createSourceList(void)
{
    int listSize = 10;
    
    Node *tmp = (Node*)malloc(sizeof(Node));
    tmp->value = 'a';
    
    sourceList.head = tmp;
    sourceList.size = 1;
    
    for (int i = 1; i < listSize; i++)
    {
        Node *newElement = (Node*)malloc(sizeof(Node));
        newElement->value = 'a' + i;
        newElement->next = NULL;
        
        tmp->next = newElement;
        tmp = tmp->next;
        sourceList.size++;
    }
}

void copySourceList(void)
{
    int listSize = sourceList.size;
    Node *source = sourceList.head;
    Node *tmp = (Node*)malloc(sizeof(Node));
    
    tmp->value = source->value;
    copyList.head = tmp;
    copyList.size = 1;
    source = source->next;
    
    for (int i = 1; i < listSize; i++)
    {
        Node *listElement = (Node*)malloc(sizeof(Node));
        listElement->value = source->value;
        listElement->next = NULL;
        
        tmp->next = listElement;
        tmp = tmp->next;
        source = source->next;
        copyList.size++;
    }
}

void printLists(void)
{
    int listSize = sourceList.size;
    Node *tmp = sourceList.head;
    T value;
    
    puts("Source list:");
    while (listSize != 0) {
        value = tmp->value;
        tmp = tmp->next;
        listSize--;
        printf("%c", value);
    }
    printf("\n\n");
    
    listSize = copyList.size;
    tmp = copyList.head;
    
    puts("Copy list:");
    while (listSize != 0) {
        value = tmp->value;
        tmp = tmp->next;
        listSize--;
        printf("%c", value);
    }
    printf("\n\n");
}

void deleteSomeElementsFromSource(void)
{
    puts("Now we delete some elements from source list\n");
    
    while (sourceList.size > 5)
    {
        Node* next = NULL;
        next = sourceList.head;
        sourceList.head = sourceList.head->next;
        free(next);
        sourceList.size--;
    }
}

//Solution 5
//Часть методов используется из решения задания под номером 3
char operationsStack[20];
int operationsStackIndex = -1;

void infixToPostfix(void);
int isNumber(char c);
int isOperation(char c);
void printOperationsTillOpenBracket(void);
void printStackIfNecessary(void);
void pushToOperationsStack(char operation);
char popFromOperationsStack(void);

void infixToPostfixTask(void)
{
    getUserInput();
    infixToPostfix();
}

void infixToPostfix(void)
{
    int userExampleLength;
    userExampleLength = strlen(userInput);
    
    for (int i = 0; i < userExampleLength; i++)
    {
        char c = userInput[i];
        
        if (isNumber(c))
            printf("%c", c);
        
        if (isOperation(c))
        {
            printf(" ");
            pushToOperationsStack(c);
        }
        
        if (isOpenningBracket(c))
            pushToOperationsStack(c);
        
        if (isClosingBracket(c))
            printOperationsTillOpenBracket();
    }
    printf(" ");
    printStackIfNecessary();
    printf("\n");
}

int isNumber(char c)
{
    for (int i = 0; i < 10; i++)
    {
        if (c == ('0' + i))
            return 1;
    }
    return 0;
}

int isOperation(char c)
{
    if (c == '+' || c == '-' || c == '/' || c == '*')
        return 1;
    return 0;
}

void printOperationsTillOpenBracket(void)
{
    char operation;
    operation = popFromOperationsStack();
    
    while (!isOpenningBracket(operation))
    {
        printf(" %c", operation);
        operation = popFromOperationsStack();
    }
}

void printStackIfNecessary(void)
{
    char operation;
    
    while (operationsStackIndex >= 0)
    {
        operation = popFromOperationsStack();
        printf("%c ", operation);
    }
}

void pushToOperationsStack(char operation)
{
    if (operationsStackIndex >= 20)
    {
        puts("Operations stack overflow");
        return;
    }
    
    operationsStackIndex++;
    operationsStack[operationsStackIndex] = operation;
}

char popFromOperationsStack(void)
{
    if (operationsStackIndex < 0)
    {
        puts("Operations stack is empty");
        return 'z';
    }
    
    return operationsStack[operationsStackIndex--];
}
