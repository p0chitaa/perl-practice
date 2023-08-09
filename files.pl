use strict;
use warnings;

# Files and File Handles

# a scalar var may contain a file handle instead of a number/string/reference or `undef`
# a file handle is essentially a reference to a specific location inside a specific file

# use `open` to turn a scalar var into a file handle. `open` must be supplied with a `mode`
# the mode `<` indicates that we wish to open the file to read from it:
my $f = "text.txt";
my $result = open my $fh, "<", $f;

if(!$result) {
    die "Couldn't open '".$f."' for reading because: ".$!;
}

# if successful, `open` returns a true value, otherwise false and an error message is stuffed
# into the built-in variable `$!`. as seen above, you should always check that the `open`
# operation completed successfully. this checking being rather tedious, a common idiom is:
# `open(my $fh, "<", $f) || die "Couldn't open '".$f."' for reading because: ".$!;`

# to read a line of text from a filehandle, use the `readline` built-in function. `readline`
# returns a fulll ine of text, with a line break intact at the end of it (except possibly for
# the final line of the file), or `undef` if you've reached the end of the file

while(1) {
    my $line = readline $fh;
    last unless defined $line;
    # process the line...
}

# to truncate that possible trailing line break, use `chomp`:
# `chomp $line;`

# `chomp` acts on `$line` in place. `$line = chomp $line` is probably not what you want
# you can also use `eof` to detect that the end of the file has been reached
while(!eof $fh) {
    my $line = readline $fh;
    # process $line...
}

# but beware of just using `while(my $line = readline $fh)`, bc if $line turns out to be "0"
# the loop will terminate early. if you want to write something like that, perl provides the
# <> operator which wraps up `readline` in a fractionally safer way. this is very commonly
# seen and perfectly safe:
while(my $line = <$fh>) {
    # process $line...
}

# and even:
while(<$fh>) {
    # process $_...
}

# if you wanna write to a file, we need to use the `>` mode. this will clobber the content
# of the target file if it already exists and has content
# use `>>` if you want to simply append to a file. then simply provide the filehandle as a
# zeroth arg for the print function:
open(my $fh2, ">", $f) || die "Couldn't open '".$f."' for writing because: ".$!;
print $fh2 "The eagles have left the nest\n";
# note the absence of a comma between `$fh2` and the next argument

# file handles are actually closed automatically when they drop out of scope, but otherwise:
close $fh2;
close $fh;

# 3 filehandles exist as global constants: `STDIN`, `STDOUT`, and `STDERR`
# these are open automatically when the script starts. to read a single line of user input:
my $line = <STDIN>;

# to just wait for the user to hit enter:
<STDIN>;

# calling `<>` with no filehandle reads data from `STDIN`, or from any files named in args
# when the perl script was called
# print prints to `STDOUT` by default if no filehandle was named



# File Tests
# the function `-e` is a built-in function which tests whether the named file exists
print "what\n" unless -e "/usr/bin/perl";
# the function `-d` is a built-in function which tests whether the named file is a directory
# `-f` for plain file
# these are called file tests