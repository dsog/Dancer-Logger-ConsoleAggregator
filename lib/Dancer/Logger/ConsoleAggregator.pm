use strict;
use warnings;
package Dancer::Logger::ConsoleAggregator;
use Dancer::Hook;
use DateTime;
use JSON qw(to_json from_json);
use Try::Tiny;

use base 'Dancer::Logger::Abstract';

# ABSTRACT: Dancer Console Logger that aggregates each requests logs to 1 line.

my ($log_message, $strings) = ({}, []);

sub _log {
    no warnings;
    no strict;
    my ($self, $level, $message, $obj) = @_;
    try {
        # If its a perl object stringified
        $ev_res = eval $message;
        $obj = ref $ev_res ? $ev_res : undef;
    };
    try {
        # If its json stringified
        $obj = from_json($message);
    } if !$obj;

    # If its just a string
    push( @$strings, $message ) if( !$obj );

    # If its a hash, handle it, otherwise Dump it into a string
    if ( defined $obj and ref $obj eq 'HASH' ) {
        map { $log_message->{$_} = $obj->{$_} } keys %$obj if $obj;
    } elsif ( defined $obj ){
        push ( @$strings, Data::Dumper->new([$obj])
                                        ->Terse(1)
                                        ->Purity(1)
                                        ->Indent(0)
                                        ->Dump()
        );
    }
}

sub flush {
    if( @$strings > 0 || scalar( keys %$log_message ) > 0){
        $log_message->{timestamp} = DateTime->now . 'Z';
        $log_message->{messages} = $strings;
        print STDERR _to_json($log_message) ."\n";
    }
    ($log_message, $strings) = ({}, []);
}

sub init {
    Dancer::Hook->new( 'after', sub {
        try { flush }
        catch { print STDERR _to_json({ LOG_ERROR => $_ }) };
    } );
}

sub _to_json { to_json(shift, { allow_blessed => 1, convert_blessed => 1 }) }

=head1 SYNOPSIS

This module will aggregate all logging done for each request into one line
in the output.  It does this by queueing everything up and adding an
C<after> hook that calls the C<flush> function, which causes the logger
to output the log line for the current request.

In your C<config.yml> simply put:

    logger: 'consoleAggregator'

To use this log module.  Then you can debug like this:

    debug { field1 => "data" };
    debug to_json({ field2 => "data" });
    debug "Raw Data";

And this module will log something like this:

    { "field1" : "data", "field2" : "data", "messages" : [ "Raw Data" ] }

All on one line.

=cut
1;

