use v6.c;
unit class Unicode::Security:ver<0.0.1>;


use JSON::Fast;
my $spec = CompUnit::DependencySpecification.new(:short-name<Unicode::Security>);
say $spec;
my $dist = $*REPO.resolve($spec).distribution;
say $dist;
say $dist.meta<resources>.list;



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
