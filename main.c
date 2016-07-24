#include "conf-parser.tab.h"

#include <stdio.h>

extern FILE *yyin;

int main(int argc, char **argv)
{
	if (argc != 2)
	{
		puts("usage: conf-parser [FILEPATH]");
		return -1;
	}

	FILE *input = fopen(argv[1], "r");
	if (input == NULL)
	{
		printf("error opening file: %s\n", argv[1]);
	}

	yyin = input;

	do
	{
		yyparse();
	} while (!feof(yyin));

	return 0;
}
