/* 
timetest.cpp
ECS 60 P1
Dominik Konecny
Alex Elkman
*/

#include <iostream>
#include <fstream>
#include <string.h>
#include "CPUTimer.h"
#include "LinkedList.h"
#include "CursorList.h"
#include "StackAr.h"
#include "dsexceptions.h"
#include "QueueAr.h"
#include "StackLi.h"
#include "vector.h"
#include "SkipList.h"

vector<CursorNode <int> > cursorSpace(250000);

using namespace std;

int getChoice();
void RunList(string filename);
void RunCursorList(string filename);
void RunStackAr(string filename);
void RunStackLi(string filename);
void RunQueueAr(string filename);
void RunSkipList(string filename);

main(int argc, char const *argv[])
{
	cout << "\% timetest.out" << endl << "Filename >> ";
	int choice;
	string filename;
	CPUTimer ct;
	cin >> filename;
	do
	{
		cout << "      ADT Menu" << endl << "0. Quit" << endl << "1. LinkedList" << endl << "2. CursorList" << endl << "3. StackAr" << endl << "4. StackLi" << endl << "5. QueueAr" << endl << "6. SkipList" << endl;
		cout << "Your choice >> ";
		choice = getChoice();
		ct.reset();
		switch (choice)
		{
			case 1: RunList(filename); break;
			case 2: RunCursorList(filename); break;
			case 4: RunStackLi(filename); break;
			case 3: RunStackAr(filename); break;
			case 5: RunQueueAr(filename); break;
			case 6: RunSkipList(filename); break;
		}
		cout << "CPU time: " << ct.cur_CPUTime() << endl;
	} while (choice > 0);

	return 0;
}

int getChoice()
{
	int choice;
	cin >> choice;
	return choice;
}

void RunList(string filename)
{
	List<int> mylist;
	ListItr<int> mylistit;
	ifstream inputfile;
	inputfile.open(filename.c_str());
	char operation;
	int value;
	getline(inputfile,filename);
	mylistit = mylist.zeroth();
	while(inputfile)
	{
		mylistit=mylist.zeroth();
		operation = ' ';
		inputfile >> operation >> value;
		if (operation!=' ')
		{	
		if (operation=='i')
		{
			mylist.insert(value,mylistit);
			//mylistit.advance();
		}
		else if (operation=='d')
		{
			mylist.remove(value);
		}
		}
	}
}

void RunCursorList(string filename)
{

	CursorList<int> mylist(cursorSpace);
	CursorListItr<int> mylistit(cursorSpace);
	ifstream inputfile;
	inputfile.open(filename.c_str());
	char operation;
	int value;
	getline(inputfile,filename);
	mylistit = mylist.zeroth();
	while(!inputfile.eof())
	{	
		mylistit = mylist.zeroth();
		operation = ' ';
		inputfile >> operation >> value;
		if (operation!=' ')
		{	
		if(operation=='i')
		{
			mylist.insert(value,mylistit);
			//mylistit.advance();
		}
		else if(operation=='d')
		{
				mylist.remove(value);
		}
		}
	}
}

void RunStackAr(string filename)
{
	StackAr<int> stack(250000);
	ifstream inputfile;
	inputfile.open(filename.c_str());
	char operation;
	int value;
	getline(inputfile,filename);
	stack.makeEmpty();
	while(!inputfile.eof())
	{
		operation = ' ';
		inputfile >> operation >> value;
		if (operation!=' ')
		{	
		if(operation=='i')
		{
			stack.push(value);
		}
		if(operation=='d')
		{
			stack.pop();
		}
		}
	}
}

void RunStackLi(string filename)
{
	StackLi<int> stack;
	ifstream inputfile;
	inputfile.open(filename.c_str());
	char operation;
	int value;
	getline(inputfile,filename);
	stack.makeEmpty();
	while(!inputfile.eof())
	{
		operation = ' ';
		inputfile >> operation >> value;
		if (operation!=' ')
		{	
		if(operation=='i')
		{
			stack.push(value);
		}
		if(operation=='d')
		{
			stack.pop();
		}
		}
	}
}

void RunQueueAr(string filename)
{
	Queue<int> queue(250000);
	ifstream inputfile;
	inputfile.open(filename.c_str());
	char operation;
	int value;
	getline(inputfile,filename);
	queue.makeEmpty();
	while(inputfile)
	{
		operation = ' ';
		inputfile >> operation >> value;
		if (operation!=' ')
		{	
		if(operation=='i')
		{
			queue.enqueue(value);
		}
		if(operation=='d')
		{
			queue.dequeue();
		}
		}
	}
}

void RunSkipList(string filename)
{
	SkipList<int> slist(0, 250000);
	ifstream inputfile;
	inputfile.open(filename.c_str());
	char operation;
	int value;
	getline(inputfile,filename);
	while(inputfile)
	{
		operation = ' ';
		inputfile >> operation >> value;
		if (operation!=' ')
		{	
		if(operation=='i')
		{
			slist.insert(value);
		}
		if(operation=='d')
		{
			slist.deleteNode(value);
		}
		}
	}
}
