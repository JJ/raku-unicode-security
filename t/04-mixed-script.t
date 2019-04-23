use Test;  # -*- mode: perl6 -*-
use Unicode::Security;

my @test = (
    [ "abcdef",            False ],
    [ "abc-def",           False ],
    [ "\x[267C]\x[203C]",  False ],
    [ "abc-\x[0BF6]ef",    True ],
);

for @test -> @t  {
    is mixed_script(@t[0]), @t[1], "@t[0] is OK";
}

done-testing;
