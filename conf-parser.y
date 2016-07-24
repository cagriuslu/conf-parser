%{

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyparse();
FILE* yyin;
void yyerror(const char *s);

%}

%union {
	int64_t ival;
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

section_header:		  LEFT_BRACKET STR RIGHT_BRACKET { printf("Found a header: %s", $2); }
			;

commands:		  commands command
			| command
			;

command:		  STR { printf("Found a command: %s", $1); }
			;

%%

int main(int argc, char **argv)
{
	do
	{
		yyparse();
	}
	while (!feof(yyin));
}

void yyerror(const char *s)
{
	printf("Parse error. Message: %s", s);
	exit(-1);
}

