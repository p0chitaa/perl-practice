# Miscellaneous

# the core module Data::Dumper can be used to output an arbitrary scalar to the screen
# this is an essential debug tool

# theres an alternate syntax, `qw{ }`, for declaring arrays. this is oftern seen in `use` statements
use Account qw{create open close suspend delete};
# there are MANY other quote-like operators

# In `=~ m//` and `=~ s///` operations, you can use braces instead of slashes as the regex
# delimiters. this is quite useful if your regex contains a lot of slashes, which would otherwise
# need escaping with backslashes. for example, `=~ m{///}` matches three literal forward slashes,
# and `=~ s{^https?://}{}` removes the protocol part of a URL

# Perl does have CONSTANTS. these are discouraged now, but werent always. constants are actually
# just subroutine calls with omitted brackets

# sometimes people omit quotes around hash keys, writing `$hash{key}` instead of `$hash{"key"}`
# they can get away with it because in this situation the bareword `key` occurs as the string
# `"key"` as opposed to a subroutine call key()

# if you see a block of unformatted code wrapped in a delimiter with double chevrons, like
# `<<EOF`, the magic word to Google for is "here-doc"

# WARNING: many built-in functions can be called with no arguments, CAUSING THEM TO OPERATE
# ON `$_` INSTEAD
# hopefully this will help you understand formations like:
print foreach @array;

# and

foreach ( @array ) {
    next unless defined;
}

# but this pretty easily leads to problems when refactoring