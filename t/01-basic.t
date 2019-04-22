use v6.c;
use Test;
use Unicode::Security;

say  confusables( "\x[00F8]");
is confusables( "\x[00F8]"), "o", "Confusables includes o";

ok confusable("s\x[006F,0337]s", "s\x[00F8]s"), 'sos';
ok confusable('paypal', "p\x[0430]yp\x[0430]l"), 'paypal';
ok confusable('scope', "\x[0455,0441]\x[043E]\x[0440,0435]"), 'scope';
ok confusable('same', 'same'), 'identical strings';
nok confusable('Paypal', 'paypal'),  'different case';

done-testing;
