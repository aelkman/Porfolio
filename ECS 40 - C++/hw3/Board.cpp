//Alex Elkman 999656002

#include <iostream>
#include "Board.h"
#include "Ship.h"
#include <stdexcept>
#include <vector>
using namespace std;

Board::Board(){
	for (int j = 0; j < 10; j++)
	{
		for (int i = 0; i < 10; i++){
			score[j][i] = ' ';
		}
	}
}

void Board::addShip(char type, int x1, int y1, int x2, int y2){
	
	if (type == 'A')
	{
		Ship* a = new AircraftCarrier(x1, y1, x2, y2);
		shipList.push_back(a);
	}
	if (type == 'B'){
		Ship *a = new BattleShip(x1, y1, x2, y2);
		shipList.push_back(a);
	}
	if (type == 'C'){
		Ship *a = new Cruiser(x1, y1, x2, y2);
		shipList.push_back(a);
	}
	if (type == 'D'){
		Ship *a = new Destroyer(x1, y1, x2, y2);
		shipList.push_back(a);
	}
}

void Board::print(void){
	cout << "   a b c d e f g h i j\n";
	cout << "  +-------------------+\n";
	for (int j = 0; j < 10; j++)
	{
		cout <<" "<< j << "|";
		for (int i = 0; i < 10; i++){
			if (i < 9)
				cout << score[j][i] << " ";
			if (i == 9)
				cout << score[j][i];
		}
		cout << "|\n";
	}
	cout << "  +-------------------+\n";
}

void Board::hit(char c, int i){
	int letter = (int)c - 97;
	if ((letter < 0 || letter>9) || (i < 0 || i>9))
		throw std::invalid_argument("invalid input");
	Ship* a = shipAt(letter, i);
	if (a != NULL && a->level()==0 && a->includes(letter,i)){
			cout << a->name() << " sunk\n";
	}
}

int Board::level(void){
	int sum=0;
	for (int i = 0; i < 10; i++)
	{
		sum += shipList[i]->level();
	}
	return sum;
}

Ship* Board::shipAt(int x, int y){
	for (int k = 0; k < 10; k++){
		if (shipList[k] != NULL && shipList[k]->includes(x, y) && score[y][x] != '*')
		{
			shipList[k]->decreaseLevel();
			score[y][x] = '*';
			return shipList[k];	
		}
	}
	if(score[y][x]=='*')
		return NULL;
	score[y][x] = 'x';
	return NULL;
}



