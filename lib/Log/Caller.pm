package Log::Caller;
use strict;
use warnings;
use parent 'Exporter';
our @EXPORT_OK   = qw[ log_debug log_info log_error log_warn log_fatal ];
our %EXPORT_TAGS = ( all => \@EXPORT_OK );
our $VERSION     = '0.02';

sub _msg {
    my ( $lvl, $pkg, $fn, $ln, @yarrgs ) = @_;
    my $format = shift @yarrgs || '';
    my $msg = sprintf( $format, (@yarrgs) );
    print STDERR join( ' ', "[$lvl]", $msg, 'at', $fn, 'line', $ln ) . "\n";
}

sub log_warn  { _msg 'warn',  caller, @_ }
sub log_debug { _msg 'debug', caller, @_ }
sub log_info  { _msg 'info',  caller, @_ }
sub log_error { _msg 'error', caller, @_ }
sub log_fatal { _msg 'fatal', caller, @_ }
1;
__END__

=head1 NAME

Log::Caller

=head1 SYNOPSIS

 log_debug "scanning new data...";

 [debug] scanning new data...  at t/00compile.t line 6

 log_warn "client %d not found!",$id;

 [warn] client 123 not found! at t/00compile.t line 8

=head1 DESCRIPTION
 

=over 4

=item log_$level EXPR LIST

Take EXPR as a sprintf pattern and evaluate it with LIST if defined, print it to STDERR.

=back

=head1 EXPORT

The following functions are available for export:

log_debug, log_info, log_error, log_warn, log_fatal,

The :all tag is also available for importing all.

=head1 JUSTIFICATION

There are scores of loggers out there, of varying usefulness, yet I still find myself and others constantly putting 
warn "blah" everywhere in the code. 

Why? 

a) because we're lazy, and it's the lowest effort form of logging output for debugging.

b) the call stack is appended nicely

c) because most loggers are full of bloat

I wanted something that would work like warn but be filterable with proper log levels.

=head1 AUTHOR

 sam@socialflow.com, sponsored by SocialFlow, Inc.

=head1 COPYRIGHT & LICENSE

Copyright 2012, Sam Kaufman skaufman@cpan.org

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
