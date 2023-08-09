# System Calls

# perl provides more than one way to - in a single call - spawn a child process, pause
# the current script until the child process has finished, and then resume interpretation of
# the currect script. whichever method is used, you will find that immediately afterwards
# the built in scalar varaible, $?, has been populated with the status word that was returned
# from that child process's termination. you can get the return code by taking just the highest
# 8 of those 16 bits: `$? >> 8`

# the `system` function can be used to invokeanother program with the args listed. the value
# returned by `system` is the same val with which `$?` is populated:
my $rc = system "perl", "built-in-functions.pl", "foo", "bar", "baz";
$rc >>= "8";
print $rc, "\n"; # "0"

# alternatively, you can use backticks `` to run an actual command at the command line and capture
# the std output from that command. IN SCALAR CONTEXT the entire output is returned as a single
# string. IN LIST CONTEXT the entire output is returned as an array of strings, each one 
# representing a line of output
my $text = `perl anotherscript.pl foo bar baz`;
print $text, "\n"; # "foobarbaz"