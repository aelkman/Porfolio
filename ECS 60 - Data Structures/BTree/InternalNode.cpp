#include <iostream>
#include "InternalNode.h"

using namespace std;

InternalNode::InternalNode(int ISize, int LSize,
  InternalNode *p, BTreeNode *left, BTreeNode *right) :
  BTreeNode(LSize, p, left, right), internalSize(ISize)
{
  keys = new int[internalSize]; // keys[i] is the minimum of children[i]
  children = new BTreeNode* [ISize];
} // InternalNode::InternalNode()


int InternalNode::getMinimum()const
{
  if(count > 0)   // should always be the case
    return children[0]->getMinimum();
  else
    return 0;
} // InternalNode::getMinimum()


InternalNode* InternalNode::insert(int value)
{

	int insertLocation;
	BTreeNode* newNode;
  if (count == 1)
  {
    newNode = children[0]->insert(value);
    if(leftSibling != NULL)
          {
            InternalNode* tempsib = dynamic_cast<InternalNode*>(leftSibling);
            updateKey(tempsib, 0);
          }
    if(rightSibling != NULL)
        {
          InternalNode* tempsib = dynamic_cast<InternalNode*>(rightSibling);
          updateKey(tempsib, 1);
        } 
  }
  else
  {
  	for(int i=1; i<count; i++)
  	{
  		if(value<keys[i])
  		{
  			newNode = children[i-1]->insert(value);
  			insertLocation = i;
  			keys[i-1] = children[i-1]->getMinimum();
  			if(i-1==0)
  			{
  				if(leftSibling != NULL)
  				{
  					InternalNode* tempsib = dynamic_cast<InternalNode*>(leftSibling);
  					updateKey(tempsib, 0);
  				}
  			}
  			else
  			{
  			keys[i-2] = children[i-2]->getMinimum();
  			}
  			keys[i] = children[i]->getMinimum();
  			i=count;
  		}
  		else if(i==count-1)
  		{
  			newNode = children[i]->insert(value);
  			keys[i] = children[i]->getMinimum();
  			keys[i-1] = children[i-1]->getMinimum();
  			if(count==internalSize && rightSibling != NULL)
  			{
  				InternalNode* tempsib = dynamic_cast<InternalNode*>(rightSibling);
  				updateKey(tempsib, 1);
  			}			
  			insertLocation = i+1;
  		}
  	}
  }

	if(newNode != NULL)
    {
		newNode->setParent(this);
		if (count<internalSize)
		{
			count++;
			for (int i=insertLocation; i<count; i++)
			{
				BTreeNode* temp;
				if(children[i]!=NULL)
				{
					temp = children[i];
					children[i] = newNode;
					newNode = temp;
					keys[i] = children[i]->getMinimum();
				}
				else
				{
					children[i] = newNode;
					keys[i] = children[i]->getMinimum();
				}
			}
			
		}
		else
		{
			bool inserted = insertLeftInternalSibling(newNode,insertLocation);
			if (inserted == false)
			{
				inserted = insertRightInternalSibling(newNode,insertLocation);
				if (inserted == false)
				{
				  count--;
				  return internalNodeSplit(newNode, insertLocation);
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
	}
	return NULL;
}	// InternalNode::insert()

void InternalNode::insert(BTreeNode *oldRoot, BTreeNode *node2)
{    // SPECIAL CASE ROOT SPLIT WILL ONLY EVER HAVE OLD NODE AND NEW NODE
  
    children[0] = oldRoot;
    children[1] = node2;
	count = 2;
    keys[0] = this->children[0]->getMinimum();
    keys[1] = this->children[1]->getMinimum();
    
} // InternalNode::insert()

void InternalNode::insertSibling(BTreeNode *newNode, bool isRight) // from a sibling
{
  count++;
  newNode->setParent(this);
  if (isRight)
  {
    for (int i=0; i<count; i++)
      {
        BTreeNode* temp;
        if(children[i]!=NULL)
        {
          temp = children[i];
          children[i] = newNode;
          newNode = temp;
          keys[i] = children[i]->getMinimum();
        } 
        else
        {
          children[i] = newNode;
          keys[i] = children[i]->getMinimum();
        }
      }
  }
  else
  {
    children[count-1] = newNode;
    keys[count-1] = children[count-1]->getMinimum();
  }
} // InternalNode::insert()

void InternalNode::print(Queue <BTreeNode*> &queue)
{
  int i;

  cout << "Internal: ";
  for (i = 0; i < count; i++)
    cout << keys[i] << ' ';
  cout << endl;

  for(i = 0; i < count; i++)
    queue.enqueue(children[i]);

} // InternalNode::print()

bool InternalNode::insertLeftInternalSibling(BTreeNode* newNode, int insertLocation) 
{
	if(leftSibling!=NULL)
	{
		if(leftSibling->getCount()<internalSize)
		{
			for (int i=insertLocation-1; i>=0; i--)
			{
				BTreeNode* temp;
				temp = children[i];
				children[i] = newNode;
				newNode = temp;
				keys[i] = children[i]->getMinimum();
			}
			dynamic_cast<InternalNode*>(leftSibling)->insertSibling(newNode,0);
      return true;
		}
		else
			return false;
	}
	else
		return false;
			
	return false;
}

bool InternalNode::insertRightInternalSibling(BTreeNode* newNode, int insertLocation) 
{
	if(rightSibling!=NULL)
	{
		if(rightSibling->getCount()<internalSize)
		{
			for (int i=insertLocation; i<count; i++)
			{
				BTreeNode* temp;
				temp = children[i];
				children[i] = newNode;
				newNode = temp;
				keys[i] = children[i]->getMinimum();
			}
			dynamic_cast<InternalNode*>(rightSibling)->insertSibling(newNode,1);
      return true;
		}
		else
			return false;
	}
	else
		return false;
		
	return false;
			
}
InternalNode* InternalNode::internalNodeSplit(BTreeNode* newNode, int insertLocation) 
{
	for (int i=insertLocation; i<count; i++)
		{
			BTreeNode* temp;
			temp = children[i];
			children[i] = newNode;
			newNode = temp;
			keys[i] = children[i]->getMinimum();
		}
	//count++;
	InternalNode* newInternalNode = new InternalNode(internalSize,leafSize,NULL,this,rightSibling);
	this->setRightSibling(newInternalNode);
  if (newInternalNode->rightSibling != NULL)
  {
    newInternalNode->rightSibling->setLeftSibling(newInternalNode);
  }

	
	//int k=count-internalSize/2;				//k is value of half way point in the internalNode size, needed for varying size
	for(int k = count-internalSize/2; k<count; k++)					//inserts the remaining values that must be shifted into the newInternalNode
	{
	newInternalNode->insert(children[k],newNode);
	newInternalNode->keys[k] = children[k]->getMinimum();
	}
	//count--;
	//newInternalNode->insert(children[k+1],newNode);
	return 0;
}



void InternalNode::updateKey(InternalNode* sibling, bool isRight)
{
	
	if(isRight==0)
	{
		sibling->keys[sibling->getCount()] = sibling->children[sibling->getCount()]->getMinimum();
	}
	else	
		sibling->keys[0] = sibling->children[0]->getMinimum();
}
		


