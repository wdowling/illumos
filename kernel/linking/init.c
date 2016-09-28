/*
 * The init and fini pragma directives allow the execution
 * of routines before and after the main application or library
 * executes. Thus the output of the below code would be:
 * 	$ ./a.out
 *	Started
 *	Executed
 *	End
 *
 * This is useful for lazy loading libraries around specific 
 * routines.
 */ 
#include <stdio.h>

#pragma init (start)
#pragma fini (end)

void start()
{
	printf("Started\n");
}

void end()
{
	printf("Ended\n");
}

void main()
{
	printf("Executing\n");
}
