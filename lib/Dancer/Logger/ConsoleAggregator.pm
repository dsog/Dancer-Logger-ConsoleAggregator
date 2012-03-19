package Dancer::Logger::ConsoleAggregator;

use strict;
use warnings;
use Dancer::Hook;
use JSON qw(to_json);

use vars '$VERSION';
use base 'Dancer::Logger::Abstract';

use Exporter qw( import );
our @EXPORT = our @EXPORT_OK = qw(flush);

$VERSION = '0.1';

my $log_message = [];

sub _log {
    my ($self, $level, $message) = @_;
    push ($log_message => {$level => $message});
}

sub flush {
    print STDERR to_json($log_message);
    $log_message = [];
}

sub init {
    Dancer::Hook->new( 'after', sub { flush } );
}

1;
__END__

