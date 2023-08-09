# Array Functions

# In-place Array Modification
my @stack = ("Fred", "Eileen", "Denise", "Charlie");
print @stack, "\n"; # "FredEileenDeniseCharlie"

# pop extracts and returns the final element of the array (aka top of stack)
print pop @stack, "\n"; # "Charlie"

# push appens extra elements to the end
push @stack, "Bob", "Alice";
print @stack, "\n"; # "FredEileenDeniseCharlieBobAlice"

# `shift` extracts and returns the first element of the array
print shift @stack, "\n";
print @stack, "\n"; # "ElieenDeniseBobAlice";

# `unshift` inserts new elements at the START of the array
unshift @stack, "Hank", "Grace";
print @stack, "\n"; # "HankGraceEileenDeniseBobAlice";

# `pop`, `push`, `shift`, and `unshift` are all special cases of `splice`
# `splice` removes and returns an array slice, replacing it with a
# different array slice

print splice(@stack, 1, 4, "<<<", ">>>"), "\n"; # "GraceEileenDeniseBob"
print @stack, "\n"; # "Hank<<<>>>Alice"

# Creating New Arrays From Old
# `join` concats many strings into one
my @elements = ("Antimony", "Arsenic", "Aluminum", "Selenium");
print @elements, "\n";          # "AntimonyArsenicAluminumSelenium"
print "@elements", "\n";        # "Antimony Arsenic Aluminum Selenium"
print join(", ", @elements), "\n"; # "Antimony, Arsenic, Aluminum, Selenium"

# IN LIST CONTEXT, `reverse` returns a list in reverse order
# IN SCALAR CONTEXT, `reverse` concats the whole list together
# and then reverses it as a single word
print reverse("Hello", "World"), "\n"; # "WorldHello"
print reverse("HelloWorld"), "\n";     # "HelloWorld"
print scalar reverse("HelloWorld"), "\n"; # "dlroWolleH"
print scalar reverse("Hello", "World"), "\n"; # "dlroWolleH"

# `map` takes an array as input and applies an operation 
# to every scalar, `$_` in this array
# it then constructs a new array out of the results
# the operation to perform is provided in the form of a single expr inside braces
my @capitals = (
    "Baton Rouge", 
    "Indianapolis", 
    "Columbus", 
    "Montgomery", 
    "Helena", 
    "Denver", 
    "Boise"
);

print join ", ", map { uc $_ } @capitals, "\n"; # "BATON ROUGE, INDIANAPOLIS, COLUMBUS, MONTGOMERY, HELENA, DENVER, BOISE"

# `grep` takes an array as input and returns a filtered array as output
# syntax is similar to `map`, but this time the second argument is evaluated
# for each scalar, `$_` in the input array. if a boolean true value is
# returned, the scalar is put into the output array, otherwise not
print join ", ", grep { length $_ == 6 } @capitals; # "Helena, Denver"
print "\n";

# you can also use `grep` to quickly check whether an array contains
# an element
print scalar grep { $_ eq "Columbus" } @capitals; # "1"
print "\n";

# here we go
# `grep` and `map` may be combined to form list comprehensions
# an exceptionally powerful feature absent from many other languages
# by default, the `sort` function returns the input array, sorted into
# alphabetiacl order
my @elevations = (19, 1, 2, 100, 3, 98, 100, 1056);
print join ", ", sort @elevations; # "1, 100, 100, 1056, 19, 2, 3, 98"
print "\n";

# however, similar to `grep` and `map`, you may supply some code of your own
# sorting is always performed using a series of comparisons between two
# elements. your block receives $a and $b as inputs and should return -1
# if $a is "less than" $b, 0 if they are "equal" or 1 if $a is "greater than"
# $b
# the `cmp` operator does exactly this for strings
print join ", ", sort { $a cmp $b } @elevations; # "1, 100, 100, 1056, 19, 2, 3, 98"
print "\n";

# the "spaceship operator", `<=>` does the same for numbers
print join ", ", sort { $a <=> $b } @elevations; # "1, 2, 3, 19, 98, 100, 100, 1056"
print "\n";

# $a and $b are always scalars, but they can be references to quite
# complex objects which are difficult to compare
# if you need more space for the comparison, you can create a separate
# subroutine and provide its name instead
sub comparator {
    # lots of code...
    # return -1, 0, or 1
}

print join ", ", sort comparator @elevations;
print "\n";

# you can't do this for `grep` or `map` operations
# notice how the subroutine and block are never explicitly provided
# with $a and $b. Like `$_`, `$a` and `$b` are, in fact, global variables
# which are populated with a pair of values to be compared each time