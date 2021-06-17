library('golog2_32.pl').

:-include(golog2_32).

new_frame().
father(adam,abel).
father(adam,caim).
mother(eve,seth).
mother(eve,abel).


son(S,P):-father(P,S);mother(P,S).
grandfather(A,N):-
    father(A,P),
    father(P,N),
    new_frame().
grandfather(A,N):-father(A,M),mother(M,N).

ancestor(A,D):-father(A,D).
ancestor(A,D):-father(A,Z),ancestor(Z,D).





