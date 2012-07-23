use strict;
use warnings;
use Test::More;
use Data::Dumper::Concise;
my($fh,$mem,$prefix);
BEGIN {
    $prefix = '{test-prefix}';
    open($fh,">",\$mem) or die "$@ $!";
}

use Log::Caller ( ':all' => { prefix => $prefix, fh => $fh } );
eval { log_debug "this is a debug %s", "line"; };
ok( !$@ ) or die "$@ $!";
close($fh);
ok $mem =~ /^$prefix/,"prefix is present";
done_testing;

