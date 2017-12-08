%{
#include "y.tab.h"
%}

string		[a-zA-Z0-9`~!@#$%\^&*()_\-+=:\[\]<>,\.?\\\/]+

%%

[ \t\n]             ;
interface           return T_interface;
pvd                 return T_pvd;
prefix              return T_prefix;
{string}	    {
			        static char string[256];
			        strncpy(string, yytext, sizeof(string));
			        string[sizeof(string)-1] = '\0';
			        yylval.str = string;
			        return STRING;
		        }
"{"|"}"|";"|"/"	return *yytext;
.		        {ECHO; yyerror ("unexpected character");}

%%

int yywrap (void) {return 1;}