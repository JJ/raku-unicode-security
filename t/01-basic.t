use v6.c;
use Test;
use Unicode::Security;

ok confusable('paypal', "p\x[0430]yp\x[0430]l"), 'paypal';
ok confusable('scope', "\x[0455,0441]\x[043E]\x[0440,0435]"), 'scope';
ok confusable('same', 'same'), 'identical strings';
ok confusable("Oracle", "O𝗿𝗮cle"), "Oracle in different scripts";
nok confusable('Paypal', 'paypal'),  'different case';

is soss( "p\x[0430]yp\x[0430]l" ).keys.elems, 2, "Soss OK";
is soss( "DFRVz" ).keys.elems, 1, "Unconfusable";
is soss( "scope" ).keys.elems, 1, "Unconfusable";
is soss( "\x[0455]\x[0441]\x[043e]\x[0440]\x[0435]" ).keys.elems, 1, "Unconfusable";


done-testing;
