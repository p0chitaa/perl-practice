# Loops
# "There's More Than One Way To Do It"

# while

my @array = ("Alpha", "Beta", "Goo");
my $i = 0;
while($i < scalar @array) {
    print $i, ": ", $array[$i], "\n";
    $i++;
}
print "\n";

# until
my $i = 0;
until($i >= scalar @array) {
    print $i, ": ", $array[$i], "\n";
    $i++;
}

print "\n";

# and these do loops are basically equivalent to the above two loops
my $i = 0;
do {
    print $i, ": ", $array[$i], "\n";
    $i++;
} while ($i < scalar @array);

print "\n";

my $i = 0;
do {
    print $i, ": ", $array[$i], "\n";
    $i++;
} until ($i >= scalar @array);

print "\n";

# also, C style for loops are available too
for(my $i = 0; $i < scalar @array; $i++) {
    print $i, ": ", $array[$i], "\n";
}
# however, this kind of for loop is considered old fashioned,
# and should be avoided whenever possible
print "\n";
# foreach:
foreach my $string ( @array ) {
    print $string, "\n";
}

print "\n";

# if on the off chance you actually NEED indices,
# the range operator .. creates an anonymous list of integers
foreach my $i ( 0 .. $#array ) {
    print $i, ": ", $array[$i],"\n";
}

print "\n";

# you can't iterate over a hash, but you can iterate over its keys
# use the `keys` built in function to retrieve an array
# containing all the keys of a hash. then use foreach
my %scientists = (
	"Newton" => "Isaac",
	"Einstein" => "Albert",
	"Darwin" => "Charles",
);

foreach my $key (keys %scientists) {
    print $key, ": ", $scientists{$key}, "\n";
}

print "\n";

# if you want them in alphabetical order, you can use `sort` beforehand
foreach my $key (sort keys %scientists) {
    print $key, ": ", $scientists{$key}, "\n";
}

print "\n";

# now, if you don't provide an explicit iterator, theres a default
# iterator, $_, the first and friendliest of the built-in variables
foreach ( @array ) {
    print $_, "\n";
}

print "\n";

# "If using the default iterator, and you only wish 
# to put a single statement inside your loop, you can 
# use the super-short loop syntax:
print $_, "\n" foreach @array;



# Loop Control
# `next` and `last` can be used to control the progress of a loop. 
# aka `continue` and `break` respectively
# we can also optionally provide a label for any loop
# conventionally, labels are written in ALLCAPS
# having labelled the loop, `next` and `last` may target that label
# this one finds primes below 100:
CANDIDATE: for my $candidate ( 2 .. 100 ) {
    for my $divisor ( 2 .. sqrt $candidate ) {
        next CANDIDATE if $candidate % $divisor == 0;
    }
    print $candidate." is prime\n";
}