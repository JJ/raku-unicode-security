use Test; # -*- mode: perl6 -*-

use Unicode::Security;

ok mixed-script-confusable("p\x[0430]yp\x[0430]l"), 'paypal';
ok mixed-script-confusable("1i\x[03BD]\x[0435]"),  '1ive';
nok mixed-script-confusable("z\x[044F]"), 'zr';


done-testing;
