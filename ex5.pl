:- module('ex5',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(1, "Isaac Asimov").
author(2, "Frank Herbert").
author(3, "William Morris").
author(4, "J.R.R Tolkein").


genre(1, "Science").
genre(2, "Literature").
genre(3, "Science Fiction").
genre(4, "Fantasy").

book("Inside The Atom", 1, 1, 500).
book("Asimov's Guide To Shakespeare", 1, 2, 400).
book("I, Robot", 1, 3, 450).
book("Dune", 2, 3, 550).
book("The Well at the World's End", 3, 4, 400).
book("The Hobbit", 4, 4, 250).
book("The Lord of the Rings", 4, 4, 1250).

% You can add more facts.
% Fill in the Purpose, Signature as requested in the instructions here

% Signature: authorOfGenre(GenreName, AuthorName)/2
% Purpose: Succeeds iff author {AuthorName}  has written a book
         belonging to the genre named {GenreName}       
authorOfGenre(GenreName, AuthorName) :-	
        author(X,AuthorName),
        genre(Y, GenreName),
        book(_, X, Y, _).

% Signature: maxlist([],0)/2
% Purpose: Base case for finding max element in a given list
maxlist([],0) :- true.

% Signature: maxlist([Head|Tail],Max)/2
% Purpose: Find the max {Max} element in a list.
maxlist([Head|Tail],Max) :-
    maxlist(Tail,TailMax),
    Head > TailMax,
    Max is Head.

% Signature: maxlist([Head|Tail],Max)/2
% Purpose: Find the max {Max} element in a list.
maxlist([Head|Tail],Max) :-
    maxlist(Tail,TailMax),
    Head =< TailMax,
    Max is TailMax.

% Signature: longestBook(AuthorId, BookName)
% Purpose: Succeeds iff the longest book that an author with 
        the ID {AuthorId} has written in titled {BookName}.
longestBook(AuthorId, BookName) :- 
    book(BookName, AuthorId, _, L),
    findall(X, book(_,AuthorId,_,X), List),
    maxlist(List,M),
   	L = M.

% Signature: listLen([], 0)/2
% Purpose: Base case for finding list length    
listLen([], 0) :- true.

% Signature: listLen([_|Tail], 0)/2
% Purpose: Find the length {Len} of a list.   
listLen([_|Tail], Len) :-
    listLen(Tail, Res),
    Len is Res+1.

% Signature: versatileAuthor(AuthorName)/1
% Purpose: Succeeds if an author by the name {AuthorName} has
        written books in at least three different genres. 
versatileAuthor(AuthorName) :-
    author(Id, AuthorName),
    findall(X, book(_,Id,X,_), List),
    listLen(List, Res),
    Res >= 3.
    

				
