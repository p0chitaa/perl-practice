# Built In Functions

# the best advice regarding built in functions is to know that they exist



# User Defined Subroutines
# subroutines are declared using the `sub` keyword
# in contrast with built-in functions, user-defined subroutines always
# accept the same input: a list of scalars. that list may have a single
# element, or be empty. a single scalar is taken as a list with a single
# element. a hash with N elements is taken as a list w 2N elements

# although brackets are optional, subroutines should always be invoked
# using brackets, even when called with no arguments. this makes it clear
# that a subroutine call is happening

# once ur inside the subrouting, the arguments are available using the
# built-in array variable `@_`:
sub hyphenate {
    # Extract the first argument from the array, ignore everything else
    my $word = shift @_;

    # an overly clever list comprehension
    $word = join "-", map { substr $word, $_, 1 } (0 .. (length $word) - 1);
    return $word;
}

print hyphenate("exterminate"), "\n"; # "e-x-t-e-r-m-i-n-a-t-e"

# Perl Calls By Reference

# unlike almost every other major programming language, perl calls by
# reference. this means that the variables or values available inside
# the body of a subroutine are not copies of the originals. they ARE
# the originals

my $x = 7;
my $y = 300;

sub reassign {
    $_[0] = 42;
}

reassign($y);
print $y, "\n"; # "42"

# long story short, in the body of the subroutine, you should always
# unpack your arguments before working with them



# Unpacking Arguments
# theres more than one way to unpack `@_` but some are superior to others
# `left_pad` pads a string out to the required length using the supplied
# character. the `x` function concats multiple copies of the same string
# in a row.

# unpacking @_ entry by entry is effective but not terribly pretty:
sub left_pad {
    my $oldString = $_[0];
    my $iwdth     = $_[1];
    my $padChar   = $_[2];
    my $newString = ($padChar x ($width - length $oldString)) . $oldString;
    return $newString;
}

print left_pad("hello", 10, "+"), "\n"; # "+++++hello"

# unpacking `@_` by removing data from it using `shift` is recommended
# for up to 4 args
sub left_pad {
    my $oldString = shift @_;
    my $width     = shift @_;
    my $padChar   = shift @_;
    my $newString = ($padChar x ($width - length $oldString)) . $oldString;
	return $newString;
}

# if no array is provided to the shift function, then it operates on @_
# implicitly. this approach is seen very commonly
sub left_pad {
    my $oldString = shift;
    my $width     = shift;
    my $padChar   = shift;
    my $newString = ($padChar x ($width - length $oldString)) . $oldString;
	return $newString;
}

# beyond 4 args, is becomes hard to keep track of what is being assigned where

# you can unpack @_ all in one go using multiple simultaneous scalar
# assignment. again, this is okay for up to 4 args
sub left_pad {
    my ($oldString, $width, $padChar) = @_;
    my $newString = ($padChar x ($width - length $oldString)) . $oldString;
	return $newString;
}

# for subroutines with large numbers of args or where some args are
# optional or cant be used in combination with others, best practice
# is to require the user to provide a hash of args when calling the
# subroutine, and then unpack `@_` back into that hash of args
# for this approach, our subroutine call would look a lil different
# `print left_pad("oldString" => "pod", "width" => 10, "padChar" => "+")`

# and the subroutine:
sub left_pad {
    my %args = @_;
    my $newString = ($args{"padChar"} x ($args{"width"} - length $args{"oldString"})) . $args{"oldString"};
    return $newString;
}

print left_pad("oldString" => "pod", "width" => 10, "padChar" => "+"), "\n";

# Returning Values
# like other perl expressions, subroutine calls may display contextual behavior. you can use 
# the `wantarray` function (which should be called `wantlist` but nvm) to detect what context
# the subroutine is being evaluated in, an return a result appropriate to that context:
sub contextualSubroutine {
    # caller wants a list. return a list
    return ("Everest", "K2", "Etna") if wantarray;

    # caller wants a scalar. return a scalar
    return 3;
}

my @array = contextualSubroutine();
print @array, "\n"; # "EverestK2Etna"

my $scalar = contextualSubroutine();
print $scalar, "\n"; # "3"

