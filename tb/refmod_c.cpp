
#include <stdio.h>
#include <math.h>
//#include <ctype.h> 
//#include <stdlib.h> 
//#include <string.h> 

//Transação precisa não conter os campos de clk e valid

extern "C" int logica_ula(int A, int B, int instru)
{
  
	switch ( instru )
	{

		case 0 : return A + B;
		break;

		case 1 : if ( A > B )
				{
					return A - B;
				} 
			else 
				{
					return B - A;
				}
		break;

		case 2 : return A + 1;
		break;

		case 3 : return B + 1;
		break;
	}

}

