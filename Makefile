all: final

final:	lex.yy.c grammar.tab.c	
	cc -o final lex.yy.c y.tab.c -ll -ly

lex.yy.c:	scanner.l grammar.y
	lex scanner.l

grammar.tab.c:	scanner.l grammar.y
	yacc -d --debug grammar.y

clean:
	rm -f final y.tab.c y.tab.h lex.yy.c lex.yy.h
