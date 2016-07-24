%{

#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyparse();
FILE* yyin;
void yyerror(const char *s);

%}

%union
{
	long long ival;
	double fval;
	char *sval;
}

%token LEFT_BRACKET RIGHT_BRACKET

%token <ival> INT
%token <fval> FLOAT
%token <sval> STR

%%

config:			  sections { puts("Finished config file."); }
			;

sections:		  sections section
			| section
			;

section:		  section_header commands
			| section_header
			;

section_header:		  LEFT_BRACKET STR RIGHT_BRACKET { printf("Found a header: %s\n", $2); }
			;

commands:		  commands command
			| command
			;

command:		  STR { printf("Found a command: %s\n", $1); }
			;

%%

void yyerror(const char *s)
{
	printf("Parse error. Message: %s", s);
	exit(-1);
}
