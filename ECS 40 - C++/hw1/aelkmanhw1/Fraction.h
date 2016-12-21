//ALex ELkman
//999656002

#ifndef FRACTION_H
#define FRACTION_H


#include<iostream>
#include<string>
using namespace std;

class Fraction{

	friend ostream& operator<<(ostream& os, const Fraction&);
	friend istream& operator>>(istream&input, Fraction&);

public:
	int num, denom;
	Fraction();
	Fraction(int a, int b);
	int Euclid(int a, int b);
	void print(void) const { std::cout << num << "/" << denom << std::endl; }


	Fraction& operator=(const Fraction&);
};

const Fraction operator+(const Fraction&, const Fraction&);
const Fraction operator-(const Fraction&, const Fraction&);

#endif