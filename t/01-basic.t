use v6.c;
use Test;
use Unicode::Security;

ok confusable('paypal', "p\x[0430]yp\x[0430]l"), 'paypal';
ok confusable('scope', "\x[0455,0441]\x[043E]\x[0440,0435]"), 'scope';
ok confusable('same', 'same'), 'identical strings';
nok confusable('Paypal', 'paypal'),  'different case';

done-testing;
