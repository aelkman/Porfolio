#ifndef InternalNodeH
  #define InternalNodeH

#include "BTreeNode.h"

class InternalNode:public BTreeNode
{
  int internalSize;
  BTreeNode **children;
  int *keys;
public:
  InternalNode(int ISize, int LSize, InternalNode *p,
    BTreeNode *left, BTreeNode *right);
  int getMinimum()const;
  InternalNode* insert(int value); // returns pointer to new InternalNode
    // if it splits else NULL
  void insert(BTreeNode *oldRoot, BTreeNode *node2); // if root splits use this
  void insertSibling(BTreeNode *newNode, bool isRight); // from a sibling
  void print(Queue <BTreeNode*> &queue);
  bool insertLeftInternalSibling(BTreeNode* newNode, int insertLocation);
  bool insertRightInternalSibling(BTreeNode* newNode, int insertLocation);
  InternalNode* internalNodeSplit(BTreeNode* newNode, int insertLocation);
  void updateKey(InternalNode* sibling, bool isRight);
}; // InternalNode class

#endif
