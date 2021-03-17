block(a;b;c;d;e;f;g;h;i;j;k;l;m;n;o).

%X = X1 :- on(X,Y,0), on(X1,Y,0).
%X = X1 :- on(X,Y,T), on(X1,Y,T),T=1..m-1.

% initial state%
%:-not on(1,2,0; 2,table,0; 3,4,0; 4,table,0; 5,6,0; 6,table,0).

% goal
%:-not on(3,2,m; 2,1,m; 1,table,m; 6,5,m; 5,4,m; 4,table,m).


:- not on(m,table,0).
:- not on(b,a,0).
:- not on(l,m,0). 
:- not on(a,l,0).
:- not on(c,b,0).
:- not on(o,table,0). 
:- not on(n,o,0). 
:- not on(d,n,0).
:- not on(e,d,0).
:- not on( j,e,0).
:- not on(k,j,0). 
:- not on(f,table,0).
:- not on( g,f,0). 
:- not on(h,g,0).
:- not on(i,h,0).

:- not on(e,j,m).
:- not on(a,e,m).
:- not on(n,a,m).
:- not on(i,d,m).
:- not on(h,i,m).
:- not on(m,h,m).
:- not on(o,m,m).
:- not on(k,g,m).
:- not on(c,k,m).
:- not on(b,c,m).
:- not on(l,b,m).


% every block is a location
location(B) :- block(B).

% the table is a location
location(table).

%question one
%no more than X number of blocks on the table at any time
%:- not {on(B, table, T)} limited, T = 0..m-1. 

% state description 
% two blocks can't be on the same block at the same time 
:- 2{on(BB,B,T)}, block(B), T = 0..m.

% effect and preconditions of action
% effect of moving a block
on(B,L,T+1) :- move(B,L,T).

% concurrent actions are limited by num of grippers 
:- not {move(BB,LL,T)} grippers, T = 0..m-1.

% a block can be moved only when it is clear 
:- move(B,L,T), on(B1,B,T).

% a block can't be moved onto a block that is being moved also 
:- move(B,B1,T), move(B1,L,T).

% fluents are initially exogenous
1{on(B,LL,0):location(LL)}1 :- block(B).

% uniqueness and existence of value constraints 
:- not 1{on(B,LL,T)}1, block(B), T=1..m.

% actions are exogenous
{move(B,L,T)} :- block(B), location(L), T = 0..m-1.

% commonsense law of inertia 

{on(B,L,T+1)} :- on(B,L,T), T < m.

%number three
{move(B,L,T)} :- B=0..2,L=1,T=0.
count(N) :- N = #min{B: move(B,L,T), move(B1, L,T)}. 

#show count/1.
#show move/3.
