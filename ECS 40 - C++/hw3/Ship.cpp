//Alex Elkman
//999656002

#include "Ship.h"
#include <iostream>
#include <string>
#include <typeinfo>
#include <stdlib.h>  
#include <stdexcept>
#include <vector>

using namespace std;

AircraftCarrier::AircraftCarrier(int x1, int y1, int x2, int y2) {
	setPos(x1, y1, x2, y2);
	lev = 5;
}

const char *AircraftCarrier::name(void) const{
	return "AircraftCarrier";
}

int AircraftCarrier::size(void) const{
	return 5;
}

BattleShip::BattleShip(int x1, int y1, int x2, int y2){
	setPos(x1, y1, x2, y2);
	lev = 4;
}

const char *BattleShip::name(void) const{
	return "BattleShip";
}

int BattleShip::size(void) const{
	return 4;
}

Cruiser::Cruiser(int x1, int y1, int x2, int y2){
	setPos(x1, y1, x2, y2);
	lev = 3;
}

const char *Cruiser::name(void) const{
	return "Cruiser";
}
int Cruiser::size(void) const{
	return 3;
}

Destroyer::Destroyer(int x1, int y1, int x2, int y2){
	setPos(x1, y1, x2, y2);
	lev = 2;
}

const char *Destroyer::name(void) const{
	return "Destroyer";
}
int Destroyer::size(void) const{
	return 2;
}

int Ship::getX(int i) const {
	/*vector<int> a;
	a.resize(size());*/
	int *p;
	p = new int[size()];
	if (x1 < x2){
		int start = x1;
		for (int c = 0; c < size(); c++) {
			p[c] = start;
			start++;
		}
	}
	if (x2 < x1){
		int start = x1;
		for (int c = 0; c < size(); c++) {
			p[c] = start;
			start--;
		}
	}
	if (x1 == x2){
		p[i] = x1;
	}
	int ans = p[i];
	//cout << "x is: " << p[i]<< " ";
	//delete[] p;
	//p = NULL;
	return ans;
}

int Ship::getY(int i) const {
	/*vector<int> a;
	a.resize(size());*/
	int *p;
	p = new int[size()];
	if (y1 < y2){
		int start = y1;
		for (int c = 0; c < size(); c++) {
			p[c] = start;
			start++;
		}
	}
	if (y2 < y1){
		int start = y1;
		for (int c = 0; c < size(); c++) {
			p[c] = start;
			start--;
		}
	}
	if (y1 == y2){
		p[i] = y1;
	}
	int ans = p[i];
	//cout << "y is: " << p[i] << " ";
	return ans;
}

void Ship::print(void) const {
	
	cout << name() << " from (" << x1 << "," << y1 << ") to (" << x2 << "," << y2 << ")" << endl;
	/*
	const Ship *s;
	s = dynamic_cast<const AircraftCarrier*>(this);
	if (s)
		cout << "AircraftCarrier from (" << x1 << "," << y1 << ") to (" << x2 << "," << y2 << ")" << endl;
	s = dynamic_cast<const BattleShip*>(this);
	if (s)
		cout << "BattleShip from (" << x1 << "," << y1 << ") to (" << x2 << "," << y2 << ")" << endl;
	s = dynamic_cast<const Cruiser*>(this);
	if (s)
		cout << "Cruiser from (" << x1 << "," << y1 << ") to (" << x2 << "," << y2 << ")" << endl;
	s = dynamic_cast<const Destroyer*>(this);
	if (s)
		cout << "Destroyer from (" << x1 << "," << y1 << ") to (" << x2 << "," << y2 << ")" << endl;*/
}

bool Ship::includes(int x, int y) {
	if (x1 <= x && x <= x2 && y1 <= y&& y <= y2)
		return true;
	if (x2 <= x && x <= x1 && y1 <= y&& y <= y2)
		return true;
	if (x1 <= x && x <= x2 && y2 <= y&& y <= y1)
		return true;
	if (x2 <= x && x <= x1 && y2 <= y&& y <= y1)
		return true;
	return false;
}

int Ship::level(void) const {
	return lev;
}

void Ship::decreaseLevel(void) {
	lev--;
	if (lev < 0)
		lev = 0;
}

Ship *Ship::makeShip(char ch, int x1, int y1, int x2, int y2)
{
	if (ch == 'A') return new AircraftCarrier(x1,y1,x2,y2);
	if (ch == 'B') return new BattleShip(x1, y1, x2, y2);
	if (ch == 'C') return new Cruiser(x1, y1, x2, y2);
	if (ch == 'D') return new Destroyer(x1, y1, x2, y2);
	else
		throw std::invalid_argument("invalid configuration");
}

void Ship::setPos(int a1, int b1, int a2, int b2) {
	if (checkConfig(a1, b1, a2, b2)) {
		x1 = a1;
		x2 = a2;
		y1 = b1;
		y2 = b2;
	}
	else
		throw std::invalid_argument("invalid configuration");
}

bool Ship::checkConfig(int x1, int y1, int x2, int y2) {
	if (abs(x1 - x2) == 0 && abs(y1 - y2) == (size()-1))
		return true;
	if (abs(y1 - y2) == 0 && abs(x1 - x2) == (size()-1))
		return true;
	return false;

}

;