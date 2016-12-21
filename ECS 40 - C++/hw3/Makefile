#alex elkman 999656002
CFLAGS = -Wall

all: battleship

battleship: battleship.o Ship.o Board.o
		g++ battleship.o Ship.o Board.o -o battleship

Ship.o: Ship.cpp Ship.h
		g++ -c Ship.cpp Ship.h
Board.o: Board.cpp Board.h
		g++ -c Board.cpp Board.h
battleship.o: battleship.cpp
		g++ -c battleship.cpp

clean:
	rm -rf *o battleship
