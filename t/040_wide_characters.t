#!perl

use strict;
use warnings;

use Test::More  tests => 4;
use Test::Fatal qw[lives_ok];
use t::Util     qw[throws_ok];

BEGIN {
    use_ok('Unicode::UTF8', qw[ decode_utf8 ]);
}

{
    my $got;
    utf8::decode(my $exp = "blåbär är gött!");
    utf8::upgrade(my $octets = "blåbär är gött!");
    lives_ok { $got = decode_utf8($octets); } 'decode_utf8() upgraded UTF-8 octets';
    is($got, $exp, "Got expected string");
}

{
    use utf8;
    my $str = "\x{26C7}";
    throws_ok { decode_utf8($str); } qr/Can't decode a wide character string/, 'wide character string';
}

