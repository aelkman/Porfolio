#ifndef LeafNodeH
#define LeafNodeH

#include "BTreeNode.h"

class LeafNode:public BTreeNode
{
  int *values;
public:
  LeafNode(int LSize, InternalNode *p, BTreeNode *left,
    BTreeNode *right);
  int getMinimum() const;
  LeafNode* insert(int value); // returns pointer to new Leaf if splits
  // else NULL
  void print(Queue <BTreeNode*> &queue);
private:
	//My Custom Methods vvv
	bool insertLeftSibling(int value);
	bool insertRightSibling(int value);
	LeafNode* leafSplit(int valuebigger, int valuesmaller);
}; //LeafNode class

#endif
