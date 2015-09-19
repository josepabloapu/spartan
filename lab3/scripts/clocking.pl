#!/usr/bin/perl


for ($M=2.0; $M <=32.0; $M++)
{
	for ($D=1.0; $D<=32.0; $D++)
	{
		printf( "%fMhz %d %d\n", ((32.0*$M)/$D),$M,$D);
	}
}
