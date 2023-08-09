# References and Nested Data Structures
# Similar to how lists cant contain lists as elements, arrays
# and hashes cannot contain other arrays and hashes as elements.
# Only scalars.

my @outer = ("Sun", "Mercury", "Venus", undef, "Mars");
my @inner = ("Earth", "Moon");

$outer[3] = @inner;
print $outer[3]."\n"; # "2"

# HOWEVER, a scalar variable may contain a reference to any variable
# including an array variable or a hash variable. This is how more
# complicated data structures are created in Perl.
# A reference is created using a backslash.

my $color = "Indigo";
my $scalarRef = \$color;

# Any time you wanna use the name of a variable, you can just
# put some braces in, and, within the braces, put a reference
# to a variable instead.

print $color."\n"; # "Indigo"
print $scalarRef."\n"; # reference text i.e. SCALAR(0x55c865cc38880)
print ${ $scalarRef }."\n"; # "Indigo" 

# And as long as the result isnt ambiguous, you can omit the curly braces

print $$scalarRef."\n"; # "Indigo"

# Now if your reference is a reference to an array or hash variable,
# you can get data out of it using braces or using the more popular
# arrow operator, ->

my @colors = ("Red", "Orange", "Yellow", "Green", "Blue");
my $arrayRef = \@colors;

print $colors[0]."\n";       # direct array access
print ${ $arrayRef }[0]."\n"; # use the reference to get to the array
print $arrayRef->[0]."\n";    # exactly the same thing

my %atomicWeights = (
    "Hydrogen" => 1.008, 
    "Helium" => 4.003, 
    "Manganese" => 54.94
);
my $hashRef = \%atomicWeights;

print $atomicWeights{"Helium"}."\n"; # direct hash access
print ${ $hashRef }{"Helium"}."\n";  # use a reference to get to the hash
print $hashRef->{"Helium"}."\n";     # exactly the same thing



# Declaring a Data Structure

# Ok so here are four examples, but the last one is the most useful in practice

my %owner1 = (
    "name" => "Santa Claus",
    "DOB" => "1882-12-25",
);

my $owner1Ref = \%owner1;

my %owner2 = (
    "name" => "Mickey Mouse",
    "DOB" => "1928-11-18",
);

my $owner2Ref = \%owner2;

my @owners = ( $owner1Ref, $owner2Ref );

my $ownersRef = \@owners;

my %account = (
    "number" => "12345678",
    "opened" => "2000-01-01",
    "owners" => $ownersRef,
);

# WHICH CAN BE SHORTENED TO......
my %owner1 = (
    "name" => "Santa Claus",
    "DOB" => "1882-12-25",
);

my %owner2 = (
    "name" => "Mickey Mouse",
    "DOB" => "1928-11-18",
);

my @owners = ( \%owner1, \%owner2 );

my %account = (
    "number" => "12345678",
    "opened" => "2000-01-01",
    "owners" => \@owners,
);

# It's also possible to declare anonymous arrays and hashes using
# different symbols. Use square brackets for an anonymous array and
# braces for an anonymous hash. The value returned in each case is a 
# reference to the anonymous data structure in question. Watch carefully,
# this results in exactly the same %account as above:

# Remember, braces denote an anonymous hash:
my $owner1Ref = {
    "name" => "Santa Claus",
    "DOB" => "1882-12-25",
};

my $owner2Ref = {
    "name" => "Mickey Mouse",
    "DOB" => "1928-11-18",
};

# And square brackets denote an anonymous array
my $ownersRef = [ $owner1Ref, $owner2Ref ];

my %account = (
    "number" => "12345678",
    "opened" => "2000-01-01",
    "owners" => $ownersRef,
);

# now, for short, as well the form you should actually use when declaring
# complex data structures in-line:
my %account = (
    "number" => "31415926",
    "opened" => "3000-01-01",
    "owners" => [
        {
            "name" => "Phillip Fry",
            "DOB" => "1974-08-06",
        },
        {
            "name" => "Hubert Farnsworth",
            "DOB" => "2841-04-09",
        },
    ],
);



# Getting Information out of Data Structures
# Once again, here are 4 examples, the last one being the most useful:
my $ownersRef = $account{"owners"};
my @owners = @{ $ownersRef };
my $owner1Ref = $owners[0];
my %owner1 = %{ $owner1Ref };
my $owner2Ref = $owners[1];
my %owner2 = %{ $owner2Ref };
print "Account #", $account{"number"}, "\n";
print "opened on ", $account{"opened"}, "\n";
print "Joint owners: \n";
print "\t", $owner1{"name"}, " (born ", $owner1{"DOB"}, ")\n";
print "\t", $owner2{"name"}, " (born ", $owner2{"DOB"}, ")\n\n";

# Or for short:
my @owners = @{ $account{"owners"} };
my %owner1 = %{ $owners[0] };
my %owner2 = %{ $owners[1] };
print "Account #", $account{"number"}, "\n";
print "opened on ", $account{"opened"}, "\n";
print "Joint owners: \n";
print "\t", $owner1{"name"}, " (born ", $owner1{"DOB"}, ")\n";
print "\t", $owner2{"name"}, " (born ", $owner2{"DOB"}, ")\n\n";

# Now with references and the arrow operator, ->
my $ownersRef = $account{"owners"};
my $owner1Ref = $ownersRef->[0];
my $owner2Ref = $ownersRef->[1];
print "Account #", $account{"number"}, "\n";
print "opened on ", $account{"opened"}, "\n";
print "Joint owners: \n";
print "\t", $owner1Ref->{"name"}, " (born ", $owner1Ref->{"DOB"}, ")\n";
print "\t", $owner2Ref->{"name"}, " (born ", $owner2Ref->{"DOB"}, ")\n\n";

# Aaaaaand if we completely skip all the intermediate values:
print "Account #", $account{"number"}, "\n";
print "Opened on ", $account{"opened"}, "\n";
print "Joint owners:\n";
print "\t", $account{"owners"}->[0]->{"name"}, " (born ", $account{"owners"}->[0]->{"DOB"}, ")\n";
print "\t", $account{"owners"}->[1]->{"name"}, " (born ", $account{"owners"}->[1]->{"DOB"}, ")\n";

# How exactly to shoot yourself in the foot with array references
# This array has 5 elements:
my @array1 = (1, 2, 3, 4, 5);
print @array1, "\n"; # "12345"

# This array, however, has ONE element 
# (which happens to be a reference to an anonymous, five-element array):
my @array2 = [1, 2, 3, 4, 5];
print @array2, "\n"; # e.g. "ARRAY(nums n stuff)"

# This SCALAR is a reference to an anonymous, five-element array:
my $array3Ref = [1, 2, 3, 4, 5];
print $array3Ref, "\n"; # e.g. "ARRAY(nums n stuff)"
print @{ $array3Ref }, "\n"; # "12345"
print @$array3Ref, "\n"; # "12345"