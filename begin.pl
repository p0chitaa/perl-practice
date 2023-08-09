# BEGIN blocks

# a BEGIN block is executed as soon as perl has finished parsing
# that block, even before it parses the rest of the file. it is ignored at the execution time

use strict;
use warnings;

print "This gets printed second\n";

BEGIN {
    print "This gets printed first\n";
}

print "This gets printed third\n";

# a BEGIN block is ALWAYS executed first. if you create multiple BEGIN blocks (DONT)
# they are executed in order from top to bottom as the compiler encounters them
# a BEGIN block always executes first even if its placed halfway thru a script (don't do this) 
# or at the end (or this). DO NOT MESS WITH THE NATURAL ORDER OF CODE. PUT BEGIN BLOCKS AT THE
# BEGINNING

# a BEGIN block is executed as soon as the block has been parsed. once this is done, parsing 
# resumes at the end of the BEGIN block. only once the whole script or module has been parsed is
# any of the code outside of BEGIN blocks executed

use strict; 
use warnings;

print "This 'print' statement gets parsed successfully but never executed\n";

BEGIN {
    print "This gets printed first\n";
}

print "This, also, is parsed successfully but never executed\n";

# BEGIN blocks placed in a conditional block will STILL be executed first, even if false
# or even if the conditional is never evaluated

if(0) {
    BEGIN {
        print "This will def get printed\n";
    }
    print "Even though this wont\n";
}

# but also DONT PUT BEGIN BLOCKS INSIDE CONDITIONALS ffs
# if you wanna do something conditionally at compile time, you need to put the conditional
# INSIDE the BEGIN block:
BEGIN {
    if(0) {
        # etc
    }
}