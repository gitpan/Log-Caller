use strict;
use warnings;
use Test::More;
use Log::Caller qw[ :all ];
eval {
log_debug "this is a debug %s", "line";
};
ok(!$@);
done_testing;
