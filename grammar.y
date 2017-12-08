%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define NAME_SIZE 20

void yyerror (char *s);
void handle_pref(char *s);

char scope[20];
char scope_name[20];
//int yydebug = 1;
%}

%token T_interface
%token T_pvd
%token T_prefix
%token <str> STRING

%union {
    char *str;
}

%%

grammar     : grammar ifacedef
            | ifacedef
            ;

ifacedef    : ifacehead '{' { strncpy(scope, "interface", NAME_SIZE-1); }
                ifaceparams '}' { strncpy(scope, "unset", NAME_SIZE-1); }
            ;

ifacehead   : T_interface STRING
            {
                strncpy(scope_name, $2, NAME_SIZE-1);
            }
            ;

ifaceparams : ifaceparams ifaceparam
            |
            ;

ifaceparam  : prefdef
            | pvddef
            ;

prefdef    : T_prefix STRING
            {
                handle_pref($2);
            }
            ;

pvddef      : pvdhead '{' { strncpy(scope, "pvd", NAME_SIZE-1); }
                pvdparams '}' { strncpy(scope, "interface", NAME_SIZE-1); }
            ;

pvdhead     : T_pvd STRING
            {
                strncpy(scope_name, $2, NAME_SIZE-1);
            }
            ;

pvdparams   : pvdparams ifaceparam
            |
            ;

%%

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}

void handle_pref(char *s) {
    printf("Scope: %s\tName:%s\tPrefix:%s\n",scope, scope_name, s);
}
int main (void) {
	return yyparse ( );
}