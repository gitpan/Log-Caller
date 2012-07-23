use strict;
use warnings FATAL => 'all';
use Test::More;
use Data::Dumper::Concise;
my($fh,$mem);
BEGIN {
    open($fh,">",\$mem) or die "$@ $!";
}
use Log::Caller ( ':all' => { fh => $fh } );
my $msg = "%222f hurdy gurdy";
log_debug $msg;
close($fh);
ok $mem =~ /$msg/,"found the 0 in $mem";
done_testing;

