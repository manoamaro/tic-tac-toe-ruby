
/*
  tictac.cpp
  compile: g++ -o tictac tictac.cpp
  execute: ./tictac

  player can be 0 or 1, representing the two players.

  bestMove ranges from 0 to 8, representing the square to be marked
*/

#include <stdio.h>

#define LOSS 		-1
#define DRAW		0
#define WIN		1

int square[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }; //the tic-tac-toe board
bool isEmpty( int i );
bool mark ( int i, int p );
void unmark ( int i );
bool marked3( int p );
bool fullBoard();


int ticBestMoveAlphaBeta ( int player, int &bestMove, int alpha, int beta )
{
  int bestScore, score;
  
  if ( marked3 ( player )) //row, col or diagonal marked
    return WIN;			//static evaluation
  else if ( marked3 ( 1 - player ))
    return LOSS;
  else if ( fullBoard() )
    return DRAW;		//static evaluation
  else {
    bestScore = alpha;
    int not_used;
    for ( int i = 0; i < 9; i++ ) {	//try each square
      printf("%d, %d", bestScore,beta);
      if (bestScore > beta)
        break;
      if ( isEmpty ( i ) ) {
	      mark ( i, player );		//execute move
	      /*
	        set to negative of opponent's best move, we only need the returned score, 
	        the returned move is irrelevant.
	      */
	      score = -ticBestMoveAlphaBeta (1-player, not_used, -beta, -alpha );
	      if ( score > bestScore ) {
	        bestMove = i;      		//update best move
	        bestScore = score;		//and score
	      }
	      unmark ( i );			//undo the move ( restore board )
      }
    } 
  }
  return bestScore;
}



bool isEmpty( int i )
{
  if ( square[i] )
    return false;
  else
    return true;
}

bool mark ( int i, int p )
{
  square[i] = 1 + p * 4;

  return true;
}

void unmark ( int i )
{
  square[i] = 0;
}

bool fullBoard()
{
  for ( int i = 0; i < 9; ++i ) 
    if ( !square[i] ) return false;
 
  return true;
}

bool marked3( int p )
{
  int sum = 0, expectedSum, i, j, k;
  if ( p == 0 )		//player 0
    expectedSum = 3;
  else			//player 1
    expectedSum = 15;
  
  //check row sums
  for ( i = 0; i < 3; ++i ) {
    k = i * 3;
    sum = 0;
    for ( j = 0; j < 3; ++j ) {
      sum += square[k];
      k++;
    }
    if ( sum == expectedSum ) return true;
  }

  //check col sums
  for ( i = 0; i < 3; ++i ) {
    k = i;
    sum = 0;
    for ( j = 0; j < 3; ++j) {
      sum += square[k];
      k += 3;
    }
    if ( sum == expectedSum ) return true;
  }

  //check diagonal 
  if ( square[0] + square[4] + square[8] == expectedSum ) return true;
  if ( square[2] + square[4] + square[6] == expectedSum ) return true;
  
  return false;
}

void print_board()
{
  printf("\n");
  int k = 0;
  for ( int i = 0; i < 3; ++i ) {
    for ( int j = 0; j < 3; ++j ) {
	if ( square[k] == 1 ) printf( "O\t" );
	else if ( square[k] == 5 ) printf( "X\t" );
	else printf("\t");
	k++;
    }
    printf("\n");
  }
}

/*
  An example of using ticBestMove.  The computer is the first player and
  is player 0. Human is player 1.
*/
int main()
{
  int move;

  while ( 1 ) {
    ticBestMoveAlphaBeta ( 0, move, WIN, LOSS );
    printf("Computer's move: %d\n", move );
    mark ( move, 0 );
    print_board();
    if ( marked3 ( 0 ) ) {
      printf("\nComputer has won!\n");
      return 1;
    }
    if ( fullBoard() ){
      printf("\nIts a tie\n");
      print_board();
      return 1;
    }
    do {
      printf("Enter your move ( 0 - 8 ): " );
      scanf ( "%d", &move );
      if ( move < 0 || move > 8 ) continue;
      if ( isEmpty( move ) ) {
        mark ( move, 1 );
    	print_board();
        if ( marked3 ( 1 ) ) {
          printf("\nYou have won!\n");
          return 1;
        }
        break;
      }
    } while ( 1 );
    if ( fullBoard() ){
      printf("\nIts a tie\n");
      print_board();
      return 1;
    }
  }
}
