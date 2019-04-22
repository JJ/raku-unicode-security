#!/usr/bin/env perl6

use v6;

use LWP::Simple;
use JSON::Fast;

constant confusables-url = "http://www.unicode.org/Public/security/latest/confusables.txt";

my $confusables = LWP::Simple.get(  confusables-url );

my @confusables;
for $confusables.split(/\n+/).grep(/";"/) -> $l {
    next unless $l ~~ /^$<source> = [ \w+ ] \s+ ";" \s+ $<target> = [ \w+ ]/;
    @confusables.push: [~$<source>,~$<target>];
}

"confusables.json".IO.spurt( to-json @confusables );
