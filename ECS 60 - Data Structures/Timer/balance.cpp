/* 
balance.cpp
ECS 60 P1
Dominik Konecny
Alex Elkman
*/

#include <iostream>
#include <fstream>
#include <stdlib.h>
#include "LinkedList.h"
#include "StackAr.h"
#include "QueueAr.h"

using namespace std;

main(int argc, char const *argv[])
{
	StackAr<int> linenumstack(1024);
	StackAr<char> symbolstack(1024);
	List<char> checklist;
	ListItr<char> checklistit;
	checklistit = checklist.zeroth();
	Queue<int> numberqueue(1024);
	char fileinput[1024];
	char error;
	int errorline;
	int errorfound=0;
	int i=1;
	int b=0;
	ifstream myfile;
	myfile.open(argv[1]);
	
	while(myfile)
	{
		fileinput[0] = '\0';
		myfile.getline(fileinput,1024);
		for (int j= 0; fileinput[j] != '\0'; ++j)
		{
			if (fileinput[j]=='{' || fileinput[j]=='[' || fileinput[j]=='(' || fileinput[j]=='}' || fileinput[j]==']' || fileinput[j]==')')
			{

				symbolstack.push(fileinput[j]);
				linenumstack.push(i);
			} 
			else if (fileinput[j]=='/' && fileinput[j+1]=='*')
			{
				symbolstack.push('!');
				linenumstack.push(i);
				while(fileinput[j+2]!='*' && fileinput[j+3]!='/') {j++;}
				if(fileinput[j+2]=='*' && fileinput[j+3]=='/')
					j++;
			} 
			else if (fileinput[j]=='*' && fileinput[j+1]=='/')
			{
				symbolstack.push('@');
				linenumstack.push(i);
			}
		}
		i++;
	}
	
	while(!symbolstack.isEmpty() && errorfound==0)
	{
		checklistit = checklist.zeroth();
		if (symbolstack.top() == '@' || symbolstack.top() == ']' || symbolstack.top() == '}' || symbolstack.top() == ')')		//checks if initial brackets are closing then insert to checklist
		{
			checklist.insert(symbolstack.topAndPop(), checklistit);
			numberqueue.enqueue(linenumstack.topAndPop());
			b++;
		} 
		else if ((symbolstack.top() == '!' || symbolstack.top() == '[' || symbolstack.top() == '{' || symbolstack.top() == '(') && checklist.isEmpty())		//checks if initial brackets are opening then it will return error due to LIFO while checklist empty
		{
			checklistit = checklist.first();
			errorfound = 1;
			error = symbolstack.top();
			errorline = linenumstack.top();
		}
		
		while(!checklist.isEmpty() && errorfound==0)
		{
			checklistit = checklist.zeroth();
			if (symbolstack.isEmpty())
			{
				checklistit = checklist.first();		//goes to first item in case there are more than one errors (to return first error)
				errorfound = 1;
				error = checklistit.retrieve();
				errorline = numberqueue.dequeue();
			}
			else
			{
				if (symbolstack.top() == '@' || symbolstack.top() == ']' || symbolstack.top() == '}' || symbolstack.top() == ')')
				{
					checklist.insert(symbolstack.topAndPop(), checklistit);
					numberqueue.enqueue(linenumstack.topAndPop());
					b++;
				}
				if (symbolstack.top() == '!')
				{
					checklistit = checklist.zeroth();
					bool kappa=false;
						for(int k=0; k<=b; k++)
						{
							if (checklistit.retrieve() == '@')
							{
								checklistit=checklist.zeroth();
								checklist.remove('@');
								numberqueue.dequeue();
								symbolstack.pop();
								linenumstack.pop();	
								kappa=true;
								b--;
								break;
							}
							checklistit.advance();
						}
					if(kappa==false)
					{
						checklistit = checklist.first();
						errorfound = 1;
						error = checklistit.retrieve();
						errorline = numberqueue.dequeue();
					}
				}
				else if (symbolstack.top() == '{')
				{
					checklistit = checklist.zeroth();
					bool kappa=false;
						for(int k=0; k<=b; k++)
						{
							if (checklistit.retrieve() == '}')
							{
								checklistit=checklist.zeroth();
								checklist.remove('}');
								numberqueue.dequeue();
								symbolstack.pop();
								linenumstack.pop();	
								kappa=true;
								b--;
								break;
							}
							checklistit.advance();
						}
					if(kappa==false)
					{
						checklistit = checklist.first();
						errorfound = 1;
						error = checklistit.retrieve();
						errorline = numberqueue.dequeue();
					}
				}
				else if (symbolstack.top() == '[')
				{
					checklistit = checklist.zeroth();
					bool kappa=false;
						for(int k=0; k<=b; k++)
						{
							if (checklistit.retrieve() == ']')
							{
								checklistit=checklist.zeroth();
								checklist.remove(']');
								numberqueue.dequeue();
								symbolstack.pop();
								linenumstack.pop();	
								kappa=true;
								b--;
								break;
							}
							checklistit.advance();
						}
					if(kappa==false)
					{
						checklistit = checklist.first();
						errorfound = 1;
						error = checklistit.retrieve();
						errorline = numberqueue.dequeue();
					}
				}
				else if (symbolstack.top() == '(')
				{
					checklistit = checklist.zeroth();
					bool kappa=false;
						for(int k=0; k<=b; k++)
						{
							if (checklistit.retrieve() == ')')
							{
								checklistit=checklist.zeroth();
								checklist.remove(')');
								numberqueue.dequeue();
								symbolstack.pop();
								linenumstack.pop();	
								kappa=true;
								b--;
								break;
							}
							checklistit.advance();
						}
					if(kappa==false)
					{
						
						checklistit = checklist.first();
						errorfound = 1;
						error = checklistit.retrieve();
						errorline = numberqueue.dequeue();
					}
				}
				checklistit = checklist.first();
				if (!checklist.isEmpty() && symbolstack.isEmpty())
				{
				errorfound = 1;
				error = checklistit.retrieve();
				errorline = numberqueue.dequeue()+1;
				}
				else
				break;
			}
		}
	}
	if (errorfound==1)
	{
		char temp[3];
		if (error=='@')
		{
			temp[0] = '*';
			temp[1] = '/';
			temp[2] = '\0';
		} 
		else if (error=='!')
		{
			temp[0] = '/';
			temp[1] = '*';
			temp[2] = '\0';
		}
		else
		{
			temp[0] = error;
			temp[1] = '\0';
		}
		cout << "Unmatched " << temp << " on line #" << errorline << endl;
	}
	else
	{
		cout << "OK" << endl;
	}
}