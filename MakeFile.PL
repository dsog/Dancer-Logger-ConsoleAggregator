use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Dancer::Logger::ConsoleAggregator',
    AUTHOR              => q{Khaled Hussein <khaled.hussein@gmail.com>},
    VERSION_FROM        => 'lib/Dancer/Logger/ConsoleAggregator.pm',
    ABSTRACT            => 'Dancer logger engine for aggregating log messages',
    'LICENSE'           => 'perl',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'  => 0,
        'Dancer'      => 1.123,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
