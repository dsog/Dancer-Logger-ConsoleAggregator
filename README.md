# NAME

Dancer::Logger::ConsoleAggregator - Dancer Console Logger that aggregates each requests logs to 1 line.

# VERSION

version 0.001

# SYNOPSIS

This module will aggregate all logging done for each request into one line
in the output.  It does this by queueing everything up and adding an
`after` hook that calls the `flush` function, which causes the logger
to output the log line for the current request.

# AUTHORS

- Khaled Hussein <khaled.hussein@gmail.com>
- William Wolf <throughnothing@gmail.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Khaled Hussein.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.