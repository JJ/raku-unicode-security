use Test; # -*- mode: perl6 -*-

use Unicode::Security;

nok whole-script-confusable("Latin", "DFRVz"),  'unconfusable ascii';
ok whole-script-confusable("Cyrillic", "scope"), 'scope; latin';
ok whole-script-confusable( "Latin", "ѕсоре"), 'ѕсоре; cyrillic';
ok whole-script-confusable( "Latin", "\x[0455]\x[0441]\x[043e]\x[0440]\x[0435]"), 'scope; cyrillic';
ok whole-script-confusable("Cyrillic", "JASƳP"), 'JASYP; Latin';
ok whole-script-confusable("Latin", "ЈАЅҮР"), 'JASYP; Cyrillic';

done-testing;
