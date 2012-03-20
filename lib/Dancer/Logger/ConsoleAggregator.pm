use strict;
use warnings;
package Dancer::Logger::ConsoleAggregator;
use Dancer::Hook;
use Exporter qw( import );
use JSON qw(to_json);

use base 'Dancer::Logger::Abstract';

# ABSTRACT: Dancer Console Logger that aggregates each requests logs to 1 line.

our @EXPORT = our @EXPORT_OK = qw(flush);

my $log_message = [];

sub _log {
    my ($self, $level, $message) = @_;
    push (@$log_message => {$level => $message});
}

sub flush {
    print STDERR to_json($log_message) ."\n";
    $log_message = [];
}

sub init {
    Dancer::Hook->new( 'after', sub { flush } );
}

=head1 SYNOPSIS

This module will aggregate all logging done for each request into one line
in the output.  It does this by queueing everything up and adding an
C<after> hook that calls the C<flush> function, which causes the logger
to output the log line for the current request.

=cut
1;

