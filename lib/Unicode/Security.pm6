use v6.c;
unit class Unicode::Security:ver<0.0.1>;


use JSON::Fast;
my $spec = CompUnit::DependencySpecification.new(:short-name<Unicode::Security>);
my $dist = $*REPO.resolve($spec).distribution;
my %confusables = from-json "resource/{$dist.meta<resources>[0]}".IO.slurp;
my %confusables-ws = from-json "resource/{$dist.meta<resources>[1]}".IO.slurp;

sub confusables( $c where %confusables{$c} ) is export {
    return  %confusables{$c}
}

sub confusables-whole-script( $c where %confusables-ws{$c} ) is export {
    return  %confusables-ws{$c}
}


=begin pod

=head1 NAME

Unicode::Security - blah blah blah

=head1 SYNOPSIS

=begin code :lang<perl6>

use Unicode::Security;

=end code

=head1 DESCRIPTION

Unicode::Security is ...

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
