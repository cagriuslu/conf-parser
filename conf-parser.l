%{

#include "conf-parser.tab.h"

%}

%option noyywrap

%%

[ \t\n]		{ ; }
\[		{ return LEFT_BRACKET; }
\]		{ return RIGHT_BRACKET; }
[a-zA-Z0-9 \t\n]+	{ yylval.sval = strdup(yytext); return STR; }
.		{ ; }

%%

