[![Build Status](https://travis-ci.org/JJ/perl6-unicode-security.svg?branch=master)](https://travis-ci.org/JJ/perl6-unicode-security)

NAME
====

Unicode::Security - Check scripts for confusables and mixed script strings

SYNOPSIS
========

```perl6
use Unicode::Security;

say "Nope" if mixed-script( "abcdef" );
say "Yea" if mixed-script( "aαbβ" );

say "Looks fake, Rick" if confusable('paypal', "p\x[0430]yp\x[0430]l");
say "No problem"  unless confusable('Paypal', 'paypal');

say "Not confusing" unless whole-script-confusable("Latin", "DFRVz");
say "Confusing" if whole-script-confusable("Cyrillic", "scope");
```

DESCRIPTION
===========

Unicode::Security is a (partial) transcription of its namesake Perl 5 module. It incorporates confusion tables from the Unicode consortium to detect which graphemes can cause confusion between two alphabets, or which strings could be confused between two or more alphabets; also detect when some strings have mixed scripts, which can be used to slip by literal-string detectors.

METHODS
=======

sub confusable( $string-a, $string-b )
--------------------------------------

Returns true if one string could be confusable for the other.

sub whole-script-comfusable( $script, $string )
-----------------------------------------------

Returns True if the string would be confusable for another written in the indicated script

sub mixed-script( $str )
------------------------

Returns `True` if the string includes several scripts, `False` otherwise

sub mixed-script-confusable( $str )
-----------------------------------

Returns `True` if the scripts present in a string could make it confusable for any of them. 

AUTHOR
======

JJ Merelo <jjmerelo@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

