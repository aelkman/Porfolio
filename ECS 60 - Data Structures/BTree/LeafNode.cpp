#include <iostream>
#include "LeafNode.h"
#include "InternalNode.h"
#include "QueueAr.h"

using namespace std;


LeafNode::LeafNode(int LSize, InternalNode *p,
  BTreeNode *left, BTreeNode *right) : BTreeNode(LSize, p, left, right)
{
  values = new int[LSize];
}  // LeafNode()



int LeafNode::getMinimum()const
{
  if(count > 0)  // should always be the case
    return values[0];
  else
    return 0;

} // LeafNode::getMinimum()


LeafNode* LeafNode::insert(int value)
{
  for (int i = 0; i < leafSize; ++i)
  {
    if (i<count)
    {
      if (values[i] > value)
      {
        int temp = value;
        value = values[i];
        values[i] = temp;
      }
    } 
    else
    {
      values[i] = value;
      count++;
      value = 0;
      i = leafSize;
    }
  }
    if (value != 0)
    {
      bool inserted = insertLeftSibling(value);
      if (inserted == false)
      {
        inserted = insertRightSibling(value);
        if (inserted == false)
        {
		      count--;
          return leafSplit(value,values[leafSize-1]);
        }
        else
        {
          return NULL;
        }
      }
      else
      {
        return NULL;
      }
    }
    else
    {
      return NULL;
    }
  return NULL;
}  // LeafNode::insert()

void LeafNode::print(Queue <BTreeNode*> &queue)
{
  cout << "Leaf: ";
  for (int i = 0; i < count; i++)
    cout << values[i] << ' ';
  cout << endl;
} // LeafNode::print()

bool LeafNode::insertLeftSibling(int value)
{
  if (leftSibling == NULL)
  {
    return false; //if insertion fails
  }
  else if(leftSibling->getCount()<leafSize)
  {
	for(int i=count; i>0; i--)
	{
		if (values[i-1] < value)
			{
				int temp = value;
				value = values[i-1];
				values[i-1] = temp;
			}
	}
    leftSibling->insert(value);
    return true;
  }
  return false;
} // LeafNode::insertLeftSibling()
bool LeafNode::insertRightSibling(int value)
{
  if (rightSibling == NULL)
  {
	   return false;
  }
  else if(rightSibling->getCount()<leafSize)
  {
    rightSibling->insert(value);
    return true;
  }
  return false;
} // LeafNode::insertRightSibling()

LeafNode* LeafNode::leafSplit(int valuebigger, int valuesmaller)
{
  LeafNode* newNode = new LeafNode(leafSize, NULL, this, rightSibling);
  if(rightSibling != NULL)
  {
	rightSibling->setLeftSibling(newNode);
  }
  this->setRightSibling(newNode);
  newNode->insert(valuesmaller);
  newNode->insert(valuebigger);
  return newNode;
} // LeafNode::leafSplit()


