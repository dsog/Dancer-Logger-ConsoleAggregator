package Dancer::Logger::ConsoleAggregator;

use strict;
use warnings;

use vars '$VERSION';
use base 'Dancer::Logger::Abstract';
use JSON qw(to_json);

use Exporter qw( import );
our @EXPORT = our @EXPORT_OK = qw(flush);

$VERSION = '0.1';

my $log_message = [];

sub _log {
    my ($self, $level, $message) = @_;
    push ($log_message => {$level => $message});
}

sub flush {
    my ($self) = @_;
    print STDERR to_json($log_message);
}

1;
__END__

