# Regex
# fuck.

# avoid perl's full regex complexity WHENEVER possible
# match operations are performed using `=~ m//`. IN SCALAR CONTEXT, `=~ m//` returns true on
# success, false on failure

my $string = "Hello world";
if($string =~ m/(\w+)\s+(\w+)/) {
    print "success\n";
}

# parentheses perform sub-matches. after a successful match operation is performed, the
# sub-matches get stuffed into the built-in variables $1, $2, $3, ...:
print $1, "\n"; # "Hello"
print $2, "\n"; # "world"

# IN LIST CONTEXT, `=~ m//` returns $1, $2, ... as a list:
my $string = "colourless green ideas sleep furiously";
my @matches = $string =~ m/(\w+)\s+((\w+)\s+(\w+))\s+(\w+)\s+(\w+)/;

print join ", ", map { "'".$_."'" } @matches;
print "\n";
# prints "'colourless', 'green ideas', ..."

# substitution operations are performed using `=~ s///`
my $string = "Good morning world";
$string =~ s/world/Vietnam/;
print $string, "\n"; # "Good morning Vietnam"
# you have to pass a scalar variable to the left hand side of an `=~ s///`, not a literal string

# the /g flag indicates "global match"
# in scalar context, each `=~ m//g` call finds another match after the previous one
# returning true on success, false on failure. you can access `$1` and so on afterwards in the 
# usual way. for example:
my $string = "a tonne of feathers or a tonne of bricks";
while($string =~ m/(\w+)/g) {
    print "'".$1."'\n";
}

# IN LIST CONTEXT, an `=~ m//g` call returns all of the matches at once
my @matches = $string =~ m/(\w+)/g;
print join ", ", map { "'".$_."'" } @matches;
print "\n";

# An `=~ s///g` call performs a global search/replace and returns the number of matches
# here we replace all vowels with the letter "r"

# Try once without /g.
$string =~ s/[aeiou]/r/;
print $string, "\n"; # "r tonne of feathers or a tonne of bricks"

# Once more.
$string =~ s/[aeiou]/r/;
print $string, "\n"; # "r trnne of feathers or a tonne of bricks"

# And do all the rest using /g
$string =~ s/[aeiou]/r/g;
print $string, "\n"; # "r trnnr rf frrthrrs rr r trnnr rf brrcks"

# the `/i` flag makes matches and substitutions case-insensitive
# the `/x` flag allows your regular expression to contain whitespace (e.g. line breaks) and comments
"Hello world" =~ m/
    (\w+) # one or more word characters
    [ ]   # single literal space, stored inside a character class
    world # literal "world"
/x;

# returns true
