package Text::FindLinks;

=head1 NAME

Text::FindLinks - Find and markup URLs in plain text

=cut

use warnings;
use strict;
use Exporter;

our @ISA = 'Exporter';
our @EXPORT_OK = qw/find_links markup_links/;
our $VERSION = '0.01';

=head1 SYNOPSIS

    use Text::FindLinks 'markup_links';
    my $text = "Have you seen www.google.com yet?";
    print markup_links(text => $text);
    # Have you seen <a href="www.google.com">www.google.com</a> yet?

=head1 FUNCTIONS

=cut

sub decorate_link
{
    my $url = shift;
    return qq|<a href="$url">$url</a>|;
}

=head2 markup_links(text => ..., [handler => sub { ... }])

Finds all URLs in the given text and replaces them using
the given handler (the found URL will be passed as the only
argument to the handler). If no handler is given, the default
handler will be used that simply creates a link to the URL.

=cut

sub markup_links
{
    my %args = @_;
    my $text = $args{'text'};
    my $decorator = $args{'handler'} || \&decorate_link;
    $text =~ s{(
        (
            (((https?)|(ftp))://)   # either a schema...
            | (www\.)               # or the ‘www’ token
        )
        [^\s]+                      # anything except whitespace
        (?<![,.;?!])                # must not end with given characters
        )}
        {&$decorator($1)}gex;
    return $text;
}

=head2 find_links(text => ...)

Returns an array with all the URLs found in given text.

=cut

sub find_links
{
    my %args = @_;
    my @links;
    markup_links(
        text    => $args{'text'},
        handler => sub { push @links, shift });
    return @links;
}

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tomáš Znamenáček, E<lt>zoul@fleuron.czE<gt>

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
