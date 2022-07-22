//
//  main.c
//  homework6
//
//  Created by Антон Головатый on 19.07.2022.
//

#include <stdio.h>
#include <string.h>
#include <mm_malloc.h>
#include <stdlib.h>

//Изменить на актуальное расположение файла
#define filePath "/Users/antongolovatyj/Курсы по обучению 2021-2022/Обучение iOS/Дополнительные курсы/2. Алгоритмы и структуры данных. Базовый курс./Домашние задания/Algoritms_and_data_structures_GB_HW/Homework6/data.txt"
#define readMode "r"

void menu(void);
int getUserSelection(void);
void launchSelectedTask(int selection);
void hashTask(void);
void binaryTreeTask(void);
void databaseTask(void);

int main(int argc, const char * argv[])
{
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
        puts("Please select the option below:");
        puts("1 - Task 1");
        puts("2 - Task 2");
        puts("3 - Task 3");
        puts("0 - exit");
        scanf("%i", &userSelection);
        
        if (userSelection < 0 || userSelection > 3)
        {
            puts("Wrong selection. Please try again.");
            userSelection = -1;
        }
    }
    
    return userSelection;
}

void launchSelectedTask(int selection)
{
    switch (selection) {
        case 1:
            hashTask();
            break;
        
        case 2:
            binaryTreeTask();
            break;
            
        case 3:
            databaseTask();
            break;
            
        default:
            break;
    }
}

//Solution 1
char userString[500];

void getUserString(void);
int getHashFor(char* str);
void printHash(int hash);

void hashTask(void)
{
    int hash = 0;
    
    getUserString();
    hash = getHashFor(userString);
    printHash(hash);
}

void getUserString(void)
{
    puts("Please input your text here (no more 500 symbols):");
    scanf("%s", userString);
}

int getHashFor(char* str)
{
    int hash = 0;
    int length;
    length = strlen(str);
    
    for (int i = 0; i < length; i++)
    {
        hash += (int)str[i];
    }
    
    return hash;
}

void printHash(int hash)
{
    puts("The hash for this input is:");
    printf("%i\n\n", hash);
}

//Solution 2
typedef int T;
typedef struct Node
{
    T data;
    struct Node *left;
    struct Node *right;
    struct Node *parent;
} Node;

void getDataFromFile(Node **tree);
Node* createBinaryTreeNode(T value, Node *parent);
void insertElementInto(Node **tree, int value);
void printBinaryTree(Node *root);
void forwardTreeMovement(Node *root);
void symmetricTreeMovement(Node *root);
void backwardsTreeMovement(Node *root);
int searchItemInTree(Node **tree, T item);

void binaryTreeTask(void)
{
    Node *tree = NULL;
    int searchItem;
    
    getDataFromFile(&tree);
    
    printBinaryTree(tree);
    printf("\n");
    
    puts("Forward Tree Movement:");
    forwardTreeMovement(tree);
    printf("\n");
    
    puts("Symmetric Tree Movement:");
    symmetricTreeMovement(tree);
    printf("\n");
    
    puts("Backwards Tree Movement:");
    backwardsTreeMovement(tree);
    printf("\n");
    
    puts("Please input searched item:");
    scanf("%i", &searchItem);
    
    if (searchItemInTree(&tree, searchItem))
        printf("Item %i found in the tree.\n", searchItem);
    else
        printf("Item %i not found in the tree.\n", searchItem);
    
}

void getDataFromFile(Node **tree)
{
    int count;
    FILE *dataFile;
    dataFile = fopen(filePath, readMode);
    fscanf(dataFile, "%i", &count);
    
    for (int i = 0; i < count; i++)
    {
        int value;
        fscanf(dataFile, "%i", &value);
        insertElementInto(tree, value);
    }
}

Node* createBinaryTreeNode(T value, Node *parent)
{
    Node *tmp = (Node*)malloc(sizeof(Node));
    tmp->left = tmp->right = NULL;
    tmp->data = value;
    tmp->parent = parent;
    return tmp;
}

void insertElementInto(Node **tree, int value)
{
    if (*tree == NULL)
    {
        *tree = createBinaryTreeNode(value, NULL);
        return;
    }
    
    Node *tmp = NULL;
    tmp = *tree;
    
    while(tmp)
    {
        if (value >= tmp->data)
        {
            if (tmp->right == NULL)
            {
                tmp->right = createBinaryTreeNode(value, tmp);
                return;
            }
            
            tmp = tmp->right;
        }
        else if (value < tmp->data)
        {
            if (tmp->left == NULL)
            {
                tmp->left = createBinaryTreeNode(value, tmp);
                return;
            }
            
            tmp = tmp->left;
        }
    }
}

void printBinaryTree(Node *root)
{
    if (root == NULL)
        return;
    
    printf("%d", root->data);
    
    if (root->left || root->right)
    {
        printf("(");
        
        if (root->left)
            printBinaryTree(root->left);
        else
            printf("NULL");
        
        printf(",");
        
        if (root->right)
            printBinaryTree(root->right);
        else
            printf("NULL");
        
        printf(")");
    }
}

void forwardTreeMovement(Node *root)
{
    if (root == NULL)
        return;
    
    printf("%d ", root->data);
    forwardTreeMovement(root->left);
    forwardTreeMovement(root->right);
}

void symmetricTreeMovement(Node *root)
{
    if (root == NULL)
        return;
    
    symmetricTreeMovement(root->left);
    printf("%d ", root->data);
    symmetricTreeMovement(root->right);
}

void backwardsTreeMovement(Node *root)
{
    if (root == NULL)
        return;
    
    backwardsTreeMovement(root->left);
    backwardsTreeMovement(root->right);
    printf("%d ", root->data);
}

int searchItemInTree(Node **tree, T item)
{
    if (*tree == NULL)
        return 0;
    
    Node *tmp = NULL;
    tmp = *tree;
    
    while(tmp)
    {
        if (item == tmp->data)
            return 1;
        
        if (item > tmp->data)
            tmp = tmp->right;
        else if (item < tmp->data)
            tmp = tmp->left;
    }
    
    return 0;
}

//Solution 3
typedef struct EmployeeEntry
{
    char name[25];
    int age;
    int employeeID;
} EmployeeEntry;

typedef struct DataBaseNode
{
    EmployeeEntry entry;
    struct DataBaseNode *next;
    struct DataBaseNode *previous;
} DataBaseNode;

typedef struct TreeNode
{
    EmployeeEntry employee;
    struct TreeNode *left;
    struct TreeNode *right;
    struct TreeNode *parent;
} TreeNode;

TreeNode *tree = NULL;

void createDataBaseSample(DataBaseNode **db);
DataBaseNode* createDataBaseEntity(EmployeeEntry entry, DataBaseNode *previous);
void addEntity(EmployeeEntry entry, DataBaseNode **db);
void deleteEntity(int employeeID, DataBaseNode **db);
void deleteDataBaseEntity(DataBaseNode *entity);
void printDatabase(DataBaseNode *db);

void createBinaryTreeFor(DataBaseNode *db);
TreeNode* createTreeNode(EmployeeEntry value, TreeNode *parent);
void insertElement(TreeNode **tree, EmployeeEntry value);
void printTree(TreeNode *root);

void searchEntity(int employeeID);
void printEntity(EmployeeEntry entry);

void databaseTask(void)
{
    DataBaseNode *database = NULL;
    
    //Создание базы данных
    createDataBaseSample(&database);
    puts("| EmployeeID  | Employee Name | Employee Age |");
    printDatabase(database);
    printf("\n");
    
    //Удаление элемента из базы
    deleteEntity(504, &database);
    puts("| EmployeeID  | Employee Name | Employee Age |");
    printDatabase(database);
    printf("\n");
    
    //Создание бинарного дерева поиска
    createBinaryTreeFor(database);
    puts("Binary tree with employeeIDs:");
    printTree(tree);
    printf("\n\n");
    
    //Поиск элементов с использованием дерева
    searchEntity(534);
    printf("\n");
    searchEntity(504);
    printf("\n");
    searchEntity(498);
    printf("\n");
}

//Hardcoded database sample
void createDataBaseSample(DataBaseNode **db)
{
    EmployeeEntry newEntry;
    
    strcpy(newEntry.name, "Terry");
    newEntry.age = 30;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Ivan");
    newEntry.age = 25;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Peter");
    newEntry.age = 29;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Sergey");
    newEntry.age = 37;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Pavel");
    newEntry.age = 33;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Michael");
    newEntry.age = 31;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Nikolay");
    newEntry.age = 28;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Frank");
    newEntry.age = 29;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Alex");
    newEntry.age = 35;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
    
    strcpy(newEntry.name, "Leonid");
    newEntry.age = 32;
    newEntry.employeeID = getHashFor(newEntry.name);
    addEntity(newEntry, db);
}

void addEntity(EmployeeEntry entry, DataBaseNode **db)
{
    if (*db == NULL)
    {
        *db = createDataBaseEntity(entry, NULL);
        return;
    }
    
    DataBaseNode *tmp = NULL;
    tmp = *db;
    
    while (tmp)
    {
        if (tmp->next == NULL)
        {
            tmp->next = createDataBaseEntity(entry, tmp);
            return;
        }
        
        tmp = tmp->next;
    }
}

DataBaseNode* createDataBaseEntity(EmployeeEntry entry, DataBaseNode *previous)
{
    DataBaseNode *newNode = (DataBaseNode*)malloc(sizeof(DataBaseNode));
    newNode->next = NULL;
    newNode->entry = entry;
    newNode->previous = previous;
    return newNode;
}

void deleteEntity(int employeeID, DataBaseNode **db)
{
    if (*db == NULL)
    {
        puts("ERROR: Database is empty");
        return;
    }
    
    DataBaseNode *tmp = NULL;
    tmp = *db;
    
    while (tmp)
    {
        if (tmp->entry.employeeID == employeeID)
        {
            deleteDataBaseEntity(tmp);
            printf("Employee with ID %i successfully deleted\n", employeeID);
            return;
        }
        
        if (tmp->next == NULL)
        {
            printf("ERROR: No entry with %i\n", employeeID);
        }
        
        tmp = tmp->next;
    }
}

void deleteDataBaseEntity(DataBaseNode *entity)
{
    DataBaseNode *tmp = (DataBaseNode*)malloc(sizeof(DataBaseNode));
    tmp->next = entity->next;
    tmp->previous = entity->previous;
    
    entity->previous->next = tmp->next;
    entity->next->previous = tmp->previous;
    free(tmp);
    free(entity);
}

void printDatabase(DataBaseNode *db)
{
    if (db == NULL)
        return;
    
    EmployeeEntry entry = db->entry;
    printf("|     %3i     |%15s|      %2i      |\n", entry.employeeID, entry.name, entry.age);
    
    if (db->next)
        printDatabase(db->next);
}

void createBinaryTreeFor(DataBaseNode *db)
{
    DataBaseNode *tmp = NULL;
    tmp = db;
    
    while (tmp)
    {
        insertElement(&tree, tmp->entry);
        tmp = tmp->next;
    }
}

void insertElement(TreeNode **tree, EmployeeEntry value)
{
    if (*tree == NULL)
    {
        *tree = createTreeNode(value, NULL);
        return;
    }
    
    TreeNode *tmp = NULL;
    tmp = *tree;
    
    while(tmp)
    {
        if (value.employeeID >= tmp->employee.employeeID)
        {
            if (tmp->right == NULL)
            {
                tmp->right = createTreeNode(value, tmp);
                return;
            }
            
            tmp = tmp->right;
        }
        else if (value.employeeID < tmp->employee.employeeID)
        {
            if (tmp->left == NULL)
            {
                tmp->left = createTreeNode(value, tmp);
                return;
            }
            
            tmp = tmp->left;
        }
    }
}

TreeNode* createTreeNode(EmployeeEntry value, TreeNode *parent)
{
    TreeNode *tmp = (TreeNode*)malloc(sizeof(TreeNode));
    tmp->left = tmp->right = NULL;
    tmp->employee = value;
    tmp->parent = parent;
    return tmp;
}

void printTree(TreeNode *root)
{
    if (root == NULL)
        return;
    
    printf("%d", root->employee.employeeID);
    
    if (root->left || root->right)
    {
        printf("(");
        
        if (root->left)
            printTree(root->left);
        else
            printf("NULL");
        
        printf(",");
        
        if (root->right)
            printTree(root->right);
        else
            printf("NULL");
        
        printf(")");
    }
}

void searchEntity(int employeeID)
{
    if (tree == NULL)
    {
        puts("ERROR: Binary tree does not exist");
        return;
    }
    
    TreeNode *tmp = NULL;
    tmp = tree;
    
    while (tmp)
    {
        if (tmp->employee.employeeID == employeeID)
        {
            printEntity(tmp->employee);
            return;
        }
        
        if (tmp->employee.employeeID < employeeID)
            tmp = tmp->right;
        else if (tmp->employee.employeeID > employeeID)
            tmp = tmp->left;
    }
    
    printf("Entry with ID %i not found\n", employeeID);
}

void printEntity(EmployeeEntry entry)
{
    puts("| EmployeeID  | Employee Name | Employee Age |");
    printf("|     %3i     |%15s|      %2i      |\n", entry.employeeID, entry.name, entry.age);
}
