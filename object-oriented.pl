# Object-oriented Perl

# tbh perl is not the best for object oriented programming
# an object simply has a reference, i.e. a scalar variable, which happens to know which 
# class its referent belongs to
# to tell a reference that its referent belongs to a class, use `bless`
# to find out what class a reference's referent belongs to (if any), use `ref`

# a method is simply a subroutine that expects an object (or, in the case of class methods,
# a package name) as its first arg
# object methods are invoked using `$obj->method();`
# class methods are invoked using `Package::Name->method();`

# a class is simply a package that happens to contain methods

# a quick example makes this clearer. an example module Animal.pm

# use strict;
# use warnings;

# package Animal;

# sub eat {
    # First arg is always the obj to act upon
    # my $self = shift @_;

    # foreach my $food ( @_ ) {
        # if($self->can_eat($food)) {
            # print "Eating ", $food;
        # } else {
            # print "Can't eat ", $food;
        # }
    # }
# }

# For the sake of argument, assume an Animal can eat anything.
# sub can_eat {
	# return 1;
# }

# return 1;

# and we might make a use of this class like so:
require Animal;

my $animal = {
    "legs" => 4,
    "colour" => "brown",
};
print ref $animal, "\n"; # "HASH"
bless $animal, "Animal"; # now its an object of class "Animal"
print ref $animal, "\n"; # Animal

# note that literally any reference can be blessed into any class. its up to you to
# ensure that (1) the referent can actually be used as an instance of this class and (2) that
# the class in question exists and has been loaded

# you can still work with the original hash in the usual way
print "Animal has ", $animal->{"legs"}, " leg(s)", "\n";

# but now you can also call methods on the object using the same `->` operator, like so:
$animal->eat("insects", "curry", "eucalyptus");
# equivalent to `Animal::eat($animal, "insects", "curry", "eucalyptus");`


# Constructors

# a constructor is a class method which returns a new object
# if you want one, just declare it. any name u like
# for class methods, the first arg passed is not an object but a class name

use strict; 
use warnings;

package Animal;

sub new {
    my $class = shift @_;
    return bless { "legs" => 4, "colour" => "brown" }, $class;
}

# ...etc.
# and then use it like so
my $animal = Animal->new();



# Inheritance
# to create a class inheriting from a parent class, use `use parent`
# lets suppose we subclassed `Animal` with `Koala`, located at Koala.pm

# and some sample code:
use strict;
use warnings;

require Koala;

my $koala = Koala->new();

$koala->eat("insects", "curry", "eucalyptus"); # eat only eucalyptus