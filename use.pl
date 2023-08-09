# Use
# the following three statements:
use Caterpillar ("crawl", "pupate");
use Caterpillar ();
use Caterpillar;

# are respectively equivalent to:
BEGIN {
    require Caterpillar;
    Caterpillar->import("crawl", "pupate");
}
BEGIN {
    require Caterpillar;
}
BEGIN {
    require Caterpillar;
    Caterpillar->import();
}

# nope, not in the wrong order.......
# `use` is a disguised `BEGIN` block. the same warnings apply
# `use` statements must always be placed at the top of the file and NEVER INSIDE CONDITIONALS

# `import()` is not a built-in perl function. its a user-defined class method.
# the burden is on the programmer of the `Caterpillar` package to define or inherit `import()`,
# and the method could theoretically accept anything as arguments and do anything with those
# arguments
# `use Caterpillar;` could do anything. consult the documentation of `Caterpillar.pm` to find
# out exactly what will happen

# Notice how `require Caterpillar` loads a module named `Caterpillar.pm`, whereas
# `Caterpillar->import()` calls the `import()` subroutine that was defined inside the
# `Caterpillar` package. lets hope the module and package coincide....
