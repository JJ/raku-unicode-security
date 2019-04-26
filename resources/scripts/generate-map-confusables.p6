#!/usr/bin/env perl6

use v6;

use LWP::Simple;
use JSON::Fast;

constant confusables-url = "http://www.unicode.org/Public/security/latest/confusables.txt";

my $confusables = LWP::Simple.get(  confusables-url );

my %confusables;
for $confusables.split(/\n+/).grep(/";"/) -> $l {
    next unless $l ~~ /^$<source> = [ \w+ ] \s+ ";" \s+ $<target> = [ \w+ ] ** 1..* % " " \s+ ";"/;
    my $target;
    my $target-match = ~$<target>;
    my $source-match = ~$<source>;
    if $target-match ~~ /\s+/ {
        my @codepoints = $target-match.split(" ");
        $target = @codepoints.map( { chr( :16( $_ )) } ).join("");
    } else {
        $target = chr( :16($target-match));
    }
    %confusables{ chr( :16($source-match)) }.push: $target;
}

"confusables.json".IO.spurt( to-json %confusables );
