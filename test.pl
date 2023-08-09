use strict;
use warnings;

my $undef = undef;
#print $undef; # prints the empty string "" and raises a warning

# implicit undef:
my $undef2;
#print $undef2; # prints "" and raises exactly the same warning

my $num = 4040.5;
#print $num; # "4040.5"

my $string = "world";
#print $string; # "world"



#arrays

my @array = (
  "print",
  "these",
  "strings",
  "out",
  "for",
  "me",
);

print $array[0]." ";
print $array[-1]."\n";

print "This array has ".(scalar @array)." elements.\n";
print "The last populated index is ".$#array.".\n";

print "Hello $string\n";
print "@array\n";

print "Hello \$string\n";
print 'Hello $string'."\n";
print "\@array\n";
print '@array'."\n\n\n\n";



# hash variables

my %scientists = (
	"Newton" => "Isaac",
	"Einstein" => "Albert",
	"Darwin" => "Charles",
);

print $scientists{"Newton"}."\n";
print $scientists{"Einstein"}."\n";
print $scientists{"Darwin"}."\n";
#print $scientists{"Dyson"};

# and i can convert this to an array????
my @scientists = %scientists;
print "@scientists\n";

# what about...
my %array = @array;
print $array{"print"}."\n\n\n\n";



# lists
# ALSO, => is basically a glorified comma
# ALSO ALSO, arrays cant be nested ;)

my @array = (
  "apples",
  "bananas",
  (
    "inner",
    "list",
    "several",
    "entries",
  ),
  "cherries",
);

print $array[2]."\n"; # "inner"

# the same is true whether the fat comma (=>) is used or not
my %hash = (
  "beer" => "good",
  "bananas" => (
    "green" => "wait",
    "yellow" => "eat",
  ),
);

# warning bc an odd number of elements in a hash
print $hash{"beer"}."\n"; # "good"
print $hash{"bananas"}."\n"; # "green"
print $hash{"wait"}."\n"; # "yellow"
print $hash{"eat"}."\n"; # undef, so "" and warning 

# so this of course means array concatenation is ez
my @bones = ("humerus", ("jaw", "skull"), "tibia");
my @fingers = ("thumb", "index", "middle", "ring", "little");
my @parts = (@bones, @fingers, ("foot", "toes"), "eyeball", "knuckle");
print "@parts\n\n\n\n";



# context

my $scalar = "Mendeleev";

# these two are equivalent. remember that the fat comma (=>) is the same as a comma
my @array = ("Alpha", "Beta", "Gamma", "Pie");
my %hash = ("Alpha" => "Beta", "Gamma" => "Pie");

# a scalar expression evaluated in list context
# is silently converted into a single element list
my @array = "Mendeleev"; # same as 'my @array = ("Mendeleev");'
print $array[0]."\n";

# as previously mentioned, an array expression evaluated in scalar context
# returns the length of the array
my @array = ("Alpha", "Beta", "Gamma", "Pie");
my $scalar = @array;
print $scalar."\n"; # "4"

# HOWEVER, a LIST expression (different from an array exp.) evaluated in
# scalar context will return the last scalar in the list
my $scalar = ("Alpha", "Beta", "Gamma", "Pie");
print $scalar."\n"; # "Pie"

# the print function evaluates all of its args in list context
# it accepts an unlimited list of args and prints one after the other
# sooooooooo it can be used to print array directly o_o
my @array = ("Alpha", "Beta", "Goo");
my $scalar = "-X-";
print @array."\n";              # "AlphaBetaGoo"
print $scalar, @array, 98, "\n"; # "-X-AlphaBetaGoo98"

# the reverse function
# basically, it treats arguments as a list and reverses it sooooo
print reverse "hello world"."\n"; # "hello world"
my $string = reverse "hello world";
print $string."\n"; # "dlrow olleh"

# HOWEVER, you can force any expression to be evaluated in scalar context
# with the `scalar` built in function
print scalar reverse "\n"."hello world"; # "dlrow olleh"