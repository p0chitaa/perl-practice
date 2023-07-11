#!/usr/bin/perl

# you dont need to declare a variable before using it
$a = 1;
$b = 2;
$c = $a + $b;

# output: 3
#print($c);

# but using a variable w/o explicitly declaring it may lead to problems
$color = 'red';
print "ur fav color is " . $colour ."\n";

# we can just use the 'strict' pragma which requires you to
# declare variables explicitly before using them
# so the following block will throw an error:

# use strict;
# my $color = 'red';
# print "ur fav color is " . $colour . "\n";

