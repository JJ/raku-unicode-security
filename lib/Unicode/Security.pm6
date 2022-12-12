use v6.c;
unit class Unicode::Security:ver<0.0.2>;
use JSON::Fast;



my %confusables = from-json %?RESOURCES<data/confusables.json>.slurp;
my @confusables-sources; my @confusables-targets;

for %confusables.kv -> $key, @values {
    for @values -> $v {
        push @confusables-sources: $key;
        push @confusables-targets: $v;
    }
}

my %confusables-ws = from-json %?RESOURCES<data/confusables-ws.json>.slurp;
my %confusables-ws-sets;

for %confusables-ws.keys -> $key {
    for %confusables-ws{$key}.keys -> $k {
        %confusables-ws-sets{$key}{$k} = set %confusables-ws{$key}{$k}.list;
    }
}

sub confusables( $c where %confusables{$c} ) is export {
    return %confusables{$c}
}

sub confusables-whole-script( $c where %confusables-ws{$c} ) is export {
    return %confusables-ws{$c}
}

sub skeleton( $string ) is export {
    my $copy = $string.NFD.Str;
    $copy.=trans( @confusables-sources => @confusables-targets );
    return $copy
}

sub confusable( $this-string, $that-string ) is export {
    return skeleton( $this-string) eq skeleton( $that-string );
}

sub soss( $string ) is export is pure {
    my %soss;
    for $string.comb ->$c {
        my $script = $c.uniprop("Script") // "Unknown";
        %soss{$script}.push: $c if $script eq none("Common","Inherited");
    }
    return %soss;
}

sub whole-script-confusable( $target, $str ) is export {
    my $norm-target = $target.wordcase;
    my %soss = soss($str.NFD.Str) || return False;
    my @scripts = %soss.keys;
    return False if @scripts.elems > 1;
    my $source = @scripts.pop;
    my $char-set = %confusables-ws-sets{$source}{$norm-target};
    return True if $char-set ∩ %soss{$source}.list.Set;

}

sub mixed-script-confusable( $str ) is export {
    my %soss = soss($str.NFD.Str);
    for %soss.keys -> $source {
        my $sum = 0;
        for %soss.keys -> $target {
            next if $target eq $source;
            my $char-set = %confusables-ws-sets{$target}{$source};
            last unless $char-set ∩ %soss{$target}.list.Set; $sum++;
        }
        return True if 1 == ( %soss.keys.elems - $sum );
    }
    return False;
}

sub mixed-script ($str) is export { return 1 < soss $str; }

=begin pod

=head1 NAME

Unicode::Security - Check scripts for confusables and mixed script strings

=head1 SYNOPSIS

=begin code :lang<perl6>

use v6.d;
use Unicode::Security;

say "Nope" if mixed-script( "abcdef" );
say "Yea" if mixed-script(
"aαbβ" );

say "Looks fake, Rick" if confusable('paypal',
				     "p\x[0430]yp\x[0430]l");
say "No problem" unless confusable('Paypal', 'paypal');

say "Not confusing" unless whole-script-confusable("Latin", "DFRVz");
say "Confusing" if whole-script-confusable("Cyrillic", "scope");


=end code

=head1 DESCRIPTION

Unicode::Security is a (partial) transcription of its namesake Perl 5
module. It incorporates confusion tables from the Unicode consortium
to detect which graphemes can cause confusion between two alphabets,
or which strings could be confused between two or more alphabets; also
detect when some strings have mixed scripts, which can be used to slip
by literal-string detectors.

The list of confusables is generated from the list published by the
unicode consortium using the scripts in C<resources/script>. You
should have received a copy along with this. The scripts generate two
JSON files, which must be moved by hand to the C<resources/data>
		  directory. You don't need to do this unless you're certain that the
		  supplied copy is I<really> out of sync with the real
		  ones.


=head1 METHODS

=head2 sub confusable( $string-a, $string-b )

Returns true if one string could be confusable for the other.

=head2 sub whole-script-comfusable( $script, $string )

Returns True if the string would be confusable for another written in the indicated script

=head2 sub mixed-script( $str )

Returns C<True> if the string includes several scripts, C<False> otherwise

							
=head2 sub mixed-script-confusable( $str )

Returns C<True> if the scripts present in a string could make it confusable for any of them. 

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
