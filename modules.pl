# Modules and Packages

# in perl, modules and packages are diff
# a MODULE is a .pm file you can include in another perl file. aka a text file with exactly the
# same syntax as a .pl script.

use strict;
use warnings;

sub zombify {
    my $word = shift @_;
    $word =~ s/[aeiou]/r/g;
    return $word;
}

# so that the perl interpreter can find them, directories containing perl modules
# should be listed in your environment variable `PERL5LIB` before calling `perl`
# list the root directory containing the modules, dont list the module directories or the
# modules themselves

# e.g. `set PERL5LIB="C:\foo\bar\baz;%PERL5LIB%"`
# or
# export PERL5LIB="/foo/bar/baz:$PERL5LIB"

require Demo::StringUtils;

print zombify("i want brains"), "\n"; # "r wrnt brrrns"

sub subroutine {
    print "universe\n";
}

package Food::Potatoes;

# no collision:
sub subroutine {
    print "kingedward\n";
}

# any time you call a subroutine, you implicitly call a subroutine which is inside the current
# package. alternatively, you can explicitly provide a package
subroutine(); # "kingedward"
main::subroutine(); # "universe"
Food::Potatoes::subroutine(); # "kingedward"

# so the logical solution to the problem described above is to modify 
# C:\foo\bar\baz\Demo\StringUtils.pm or /foo/bar/baz/Demo/StringUtils.pm to read:
# use strict;
# use warnings;

# package Demo::StringUtils;

# sub zombify {
	# my $word = shift @_;
	# $word =~ s/[aeiou]/r/g;
	# return $word;
# }

# return 1;

# and modify the main file to read:
use strict;
use warnings;

require Demo::StringUtils;

print Demo::StringUtils::zombify("i want brains"), "\n";

# time for a wall of text
# Packages and modules are two completely separate and distinct features of the Perl programming 
# language. The fact that they both use the same double colon delimiter is a huge red herring. 
# It is possible to switch packages multiple times over the course of a script or module, and 
# it is possible to use the same package declaration in multiple locations in multiple files. 
# Calling require Foo::Bar does not look for and load a file with a package Foo::Bar declaration 
# somewhere inside it, nor does it necessarily load subroutines in the Foo::Bar namespace. 
# Calling require Foo::Bar merely loads a file called Foo/Bar.pm, which need not have any kind 
# of package declaration inside it at all, and in fact might declare package Baz::Qux and other 
# nonsense inside it for all you know.

# Likewise, a subroutine call Baz::Qux::processThis() need not necessarily have been declared 
# inside a file named Baz/Qux.pm. It could have been declared literally anywhere.

# Separating these two concepts is one of the stupidest features of Perl, and treating them as 
# separate concepts invariably results in chaotic, maddening code. Fortunately for us, the 
# majority of Perl programmers obey the following two laws:

# 1. A Perl script (.pl file) must always contain exactly zero package declarations
# 2. A Perl module (.pm file) must always contain one package declaration, corresponding exactly
# to its name and location. E.g. module Demo/StringUtils.pm must begin 
# with package Demo::StringUtils

# Because of this, in practice you will find that most "packages" and "modules" produced by 
# reliable third parties can be regarded and referred to interchangeably. However, it is 
# important that you do not take this for granted, because one day you will meet code produced 
# by a madman.