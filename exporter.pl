# Exporter

# the most common way to define an `import()` method is to inherit it from the Exporter module
# Exporter is a core module, and a de facto core feature of the perl programming language.
# in Exporter's implementation of `import()`, the list of args that you pass in is
# interpreted as a list of subroutine names. when a subroutine is `import()`ed, it becomes available
# in the current package as well as in its own OG package

# this concept is easiest to grasp using an example. heres what `Caterpillar.pm` looks like:
# another piece of code may then `import()` these subroutines by name, typically using 
# a `use` statement:

use strict;
use warnings;
use Caterpillar ("crawl");

crawl(); # "inch inch"

# in this case, the current package is `main` so the `crawl()` call is actually a call to
# `main::crawl()` which (because it was imported) maps to `Caterpillar::crawl()`

# Note: regardless of the content of `@EXPORT_OK`, every method can always be called "longhand"
use strict;
use warnings;
use Caterpillar(); # no subroutines named, no import() call made

# and yet...
Caterpillar::crawl(); # "inch inch"
Caterpillar::eat(); #"chomp chomp"
Caterpillar::pupate(); # "bloop bloop"

# perl has no private methods. customarily, a method intended from private use is named with 
# a leading underscore or two


# @EXPORT
# the Exporter module also defines a package variable called @EXPORT, which can also be
# populated with a list of subroutine names
# see Caterpillar.pm (/foo/bar/baz/Caterpillar.pm)
# the subroutines named in @EXPORT are exported if `import()` is called with no args at all
# which is what happens here:
use strict;
use warnings;
use Caterpillar; # calls import() with no args

crawl(); # "inch inch"
eat(); # "chomp chomp"
pupate(); # "bloop bloop"

# but notice how we are back in a situation where, without other clues, it might not be easy
# to tell where `crawl()` was originall defined. moral of the story is twofold:

# 1. when creating a module which makes use of Exporter, never use @EXPORT to export
# subroutines "longhand" or `import()` them explicitly (using e.g. `use Caterpillar ("crawl")`,
# which is a strong clue to look in `Caterpillar.pm` for the definition of `crawl()`)

# 2. When `use`ing a module which makes use of Exporter, always explicitly name the subroutines
# you want to `import()`. if you don't want to `import()` any subroutines and wish to refer to
# them longhand, you must supply an explicit empty list: `use Caterpillar ()`.