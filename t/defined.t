use strict;
use warnings;
use Test::More;
my($fh,$mem);
BEGIN {
    open($fh,">",\$mem) or die "$@ $!";
}
use Log::Caller ( ':all' => { fh => $fh } );

log_debug 0;
close($fh);
ok $mem =~ /0/,"found the 0 in $mem";
done_testing;
