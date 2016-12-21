/* 
bags.cpp
ECS 60 P1
Dominik Konecny
Alex Elkman
*/

#include <iostream>
#include <fstream>
#include <stdlib.h>
#include "StackAr.h"
#include "QueueAr.h"

using namespace std;

int main(int argc, char const *argv[])
{
	short int fileinput;
	ifstream filetosort;
	filetosort.open(argv[1]);
	Queue<int>**QueueArray = new Queue<int>*[100];
	(*QueueArray) = new Queue<int>(atoi(argv[2]));
	Queue<int> **OrigQueueArray = QueueArray;
	
	while(filetosort)
	{
		filetosort >> fileinput;
		if (!filetosort.eof())
		{
			cout << fileinput << " ";
			(**QueueArray).enqueue(fileinput);
		}
		if ((**QueueArray).isFull())
		{

			++(QueueArray);
			(*QueueArray) = new Queue<int>(atoi(argv[2]));
		}
	}
	cout << endl;
	while(QueueArray>=OrigQueueArray)
	{
		while((**QueueArray).isEmpty()==false)
		{
			cout << (**QueueArray).dequeue() << " ";
		}
		--(QueueArray);
	}
	cout << endl;

	return 0;
}

	/*(**QueueArray).enqueue(5);
	++(QueueArray);
	(*QueueArray) = new Queue<int>(atoi(argv[2]));
	--(QueueArray);
	cout << (*QueueArray)->getFront();*/
	/*Queue<int> *OrigQueueArray = *QueueArray;
	while(filetosort)
	{
		filetosort >> fileinput;
		if (!filetosort.eof())
		{
			cout << fileinput << " ";
			(QueueArray)->enqueue(fileinput);
		}
		if ((QueueArray)->isFull())
		{

			++(QueueArray);
			QueueArray = new Queue<int>(atoi(argv[2]));
			
			while(!bagcarts.isEmpty())
			{
				(QueueArray)->enqueue(bagcarts.topAndPop());
				if ((QueueArray)->isFull())
				{
					*QueueArray++;
				}
			}
		}
	}
	/*while(!bagcarts.isEmpty())
			{
				(QueueArray)->enqueue(bagcarts.topAndPop());
				if ((QueueArray)->isFull())
				{
					*QueueArray++;
				}
			}*/
			//cout << endl; 
