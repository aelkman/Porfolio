//Alex Elkman
//999656002

#include<iostream>
#include<string>
#include<stdexcept>
#include "Fraction.h"
using namespace std;

Fraction::Fraction(){
	num = 0;
	denom = 1;
}

Fraction::Fraction(int a, int b) {
	
	if (b < 0){
		b = b*(-1);
		a = a*(-1);
	}
	int c = Euclid(a, b);
	
	num = a/c;
	denom = b/c;
}

int Fraction::Euclid(int a, int b){
	int c;
	while (b != 0) {
		c = a%b;
		a = b;
		b = c;
	}
	return a;
}

const Fraction operator+(const Fraction& x, const Fraction& y)
{
	return Fraction(x.num*y.denom + y.num*x.denom, x.denom*y.denom);
}

const Fraction operator-(const Fraction& x, const Fraction& y)
{
	return Fraction(x.num*y.denom - y.num*x.denom, x.denom*y.denom);
}

Fraction& Fraction::operator=(const Fraction& x)
{
	num = x.num;
	denom = x.denom;
	int c = Euclid(num, denom);
	num = num / c;
	denom = denom/c;
	if (denom < 0){
		denom = denom*(-1);
		num = num*(-1);
	}
	return *this;
}

istream& operator>>(istream &input, Fraction&v)
{
	char ch;
	input >> v.num >> ch >> v.denom;
	if (v.denom == 0)
		throw std::invalid_argument("division by zero");
	if (v.denom < 0)
	{
		v.denom *= (-1);
		v.num *= (-1);
	}
		return input;
}

ostream& operator << (ostream& os, const Fraction& v)
{
	if (v.denom == 1)
	{
		os << v.num;
		return os;
	}
	os << v.num <<"/"<<v.denom;
	return os;
}



;