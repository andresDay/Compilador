#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

// A structure to represent a stack
struct StackNode {
    int data;
    struct StackNode* next;
};

struct StackNode *newNode(int);
int isEmpty(struct StackNode *);
void push(struct StackNode **, int);
int pop(struct StackNode **);
int peek(struct StackNode *);