#!

open( OUTPUT, ">w.h" ) || die $!;
print OUTPUT "// this file is autogenerated - do not modify\n";

while (<STDIN>)
{
	($ord,$func) = /(\d+).*\)\s+(\S+)/;
	
	print OUTPUT "W( $func ) // $ord\n";
	$table[$i++] = $func;
	$ordinal{ $func } = $ord
}

open( OUTPUT, ">wrap.h" ) || die $!;
print OUTPUT "// this file is autogenerated - do not modify\n";

for ( $i = 0; $i <= $#table; ++$i )
{
	print OUTPUT "WRAP( $table[$i], $i )\n";
}

open( OUTPUT, ">wrap.def" ) || die $!;

print OUTPUT "LIBRARY WS2_32.DLL\n\nEXPORTS\n";

for ( $i = 0; $i <= $#table; ++$i )
{
	print OUTPUT " " . $table[$i] . "=WRAP_" . $table[$i] . " @" . $ordinal{ $table[ $i ] } ."\n";
}

exit;


while (<STDIN>)
{
	s/[\r\n]//g;
	if ( !/ / )
	{
		print "W( $_ ) // $foo\n";
		$table[$i++] = $_;
		$ordinal{ $_ } = $line + 1;
		$foo++;
	}
	$line++;
}

for ( $i = 0; $i <= $#table; ++$i )
{
	print "WRAP( $table[$i], $i )\n";
}

for ( $i = 0; $i <= $#table; ++$i )
{
	print " " . $table[$i] . "=WRAP_" . $table[$i] . " @" . $ordinal{ $table[ $i ] } ."\n";
}