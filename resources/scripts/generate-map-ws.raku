#!/usr/bin/env perl6

use v6;

use LWP::Simple;
use JSON::Fast;

constant confusables-whole-script-url = "https://www.unicode.org/reports/tr39/data/confusablesWholeScript.txt";
constant scripts-file = "../data/iso15924.txt";

die "Please run this script from its own directory" unless "data".IO.e;

# Load 4-letter script names
my %four-letter-codes;

for "../data/iso15924.txt".IO.lines -> $l {
    next unless $l ~~ /^ \w+ ";"/;
    my @data = $l.split(";");
    %four-letter-codes{@data[0]} = @data[4];
}

# Download confusables table from Unicode
my $confusables = LWP::Simple.get(  confusables-whole-script-url );
my %confusables;
for $confusables.split(/\n+/).grep(/";"/) -> $l {
    next unless $l ~~ /^$<source> = [ \S+ ] \s+ ";" \s+ $<source-script> = [ \w+ ] \s* ";" \s+ $<target-script> = [ \w+ ] \s* ";" \s+ /;
    my ($codepoint, $source, $target ) = ~$<source>,
      %four-letter-codes{~$<source-script>},
      %four-letter-codes{~$<target-script>};
    if $codepoint.index("..") {
        my ($min,$max) = $codepoint.split("..");
        for :16($min)..:16($max) -> $c {
            %confusables{$source}{$target}.push: chr($c);
        }
    } else {
        %confusables{$source}{$target}.push: chr(:16($codepoint));
    }
}


"confusables-ws.json".IO.spurt( to-json %confusables );
