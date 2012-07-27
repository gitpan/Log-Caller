package Log::Caller;
use strict;
use warnings;
sub _exports {qw[ log_debug log_info log_error log_warn log_fatal ]}
use Sub::Exporter -setup => {
    exports => { map { $_ => \&_build_log_msg } _exports() },
    groups  => { all => [ _exports() ] },
};

our $VERSION = '0.0441';
$VERSION = eval $VERSION;
sub _msg {
    my ( $params, $pkg, $fn, $ln, @yarrgs ) = @_;
    my($lvl,$prefix,$fh) = @$params{qw/lvl prefix fh/};
    $fh ||= *STDERR;
    $prefix = $prefix ? $prefix." " : "";
    my $format = shift @yarrgs;
    $format = " " unless defined $format; #would rather use //, but backwards compatibilty 
    my $msg = @yarrgs ? sprintf( $format, (@yarrgs) ) : $format;
    print $fh $prefix."[$lvl] $msg at $fn line $ln.\n";
    
}


sub _build_log_msg {
    my ( $class, $log_func, $params ) = @_;
    $log_func =~ s/^log_//g;
    $params ||= {};
    return sub {
        _msg( { %$params, lvl => $log_func, }, caller, @_ );
    };
}

1;
__END__

=head1 NAME

Log::Caller

=head1 SYNOPSIS

 log_debug "scanning new data...";

 [debug] scanning new data...  at t/00compile.t line 6.

 log_warn "client %d not found!",$id;

 [warn] client 123 not found! at t/00compile.t line 8.

=head1 DESCRIPTION
 
 Log Caller is made for those who like the output from warn() but want something with log levels for ease of parsing and filtering.

=over 4

=item log_$level EXPR LIST

Take EXPR as a sprintf pattern and evaluate it with LIST if defined then print it to STDERR or the provided filehandle.

=back

=head1 EXPORT

=head2 Configuration

 use Log::Caller ":all";

 use Log::Caller qw[ log_debug log_warn ];

 use Log::Caller ":all" => { prefix => ' <prefixin>' };
 
 my $fh;
 BEGIN { open( $fh, ">", "outs.txt" ) or die "$@ $!" };
 use Log::Caller (
    "log_debug" => { prefix => 'prefix1>', fh => $fh },
    "log_warn" => { prefix => 'prefixDos::' },
    );
        


The following functions are available for export:

log_debug, log_info, log_error, log_warn, log_fatal,

The :all tag is also available for importing all.

=head1 SEE ALSO

L<Log::Fu> - A configurable logger with caller context among other features.

L<Log::Log4perl> - Also has callstack support, but waaaay more intense.

=head1 AUTHOR

 sam@socialflow.com, sponsored by SocialFlow, Inc.

=head1 COPYRIGHT & LICENSE

Copyright 2012, Sam Kaufman skaufman@cpan.org

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
