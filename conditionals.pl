# Conditionals

# "No surprises here, other than the spelling of elsif:"
my $word = "antidisestablishmentarianism";
my $strlen = length $word;

if($strlen >= 15) {
    print "'", $word, "' is a very long word\n";
} elsif(10 <= $strlen && $strlen <15) {
    print "'", $word, "' is a medium-length word\n";
} else {
    print "'", $word, "' is a short word\n";
}

# Now, there is a shorted "statement if condition" syntax
# Recommended for short statements

print "'", $word, "' is actually enormous\n" if $strlen >= 20;

# unless ... else ...
# wuh?
# can be basically refactored into an if ... else block by
# negating the condition(s)

my $temperature = 20;
unless($temperature > 30) {
    print $temperature, " degrees Celsius us not very hot\n";
} else {
    print $temperature, " degrees Celsius is actually pretty hot\n";
}

# thank god theres no elsunless word
# That said, by comparison, this is wayyyy easier to read
print "Oh no it's too cold\n" unless $temperature > 15;



# Ternary Operator
# As expected, this basically embeds if statements into statements
my $gain = 48;
print "You gained ", $gain, " ", ($gain == 1 ? "experience point" : "experience points"), "!\n";

# ternary operators may be nested!!!!!
my $eggs = 5;
print "You have ", $eggs == 0 ? "no eggs\n" :
                   $eggs == 1 ? "an egg\n"  :
                   "some eggs\n";