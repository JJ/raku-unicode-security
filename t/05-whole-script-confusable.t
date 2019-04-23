use Test; # -*- mode: perl6 -*-

use Unicode::Security;

nok whole-script-confusable("Latin", "DFRVz"),  'unconfusable ascii';
ok whole-script-confusable("Cyrillic", "scope"), 'scope; latin';
ok whole-script-confusable( "Latin", "ѕсоре"), 'ѕсоре; cyrillic';

done-testing;
