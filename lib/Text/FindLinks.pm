package Text::FindLinks;

=head1 NAME

Text::FindLinks - The great new Text::FindLinks!

=head1 VERSION

Version 0.01

=cut

use warnings;
use strict;
use Exporter;

our @ISA = 'Exporter';
our @EXPORT_OK = qw/find_links markup_links/;
our $VERSION = '0.01';

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Text::FindLinks;

    my $foo = Text::FindLinks->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=cut

sub decorate_link
{
    my $url = shift;
    return qq|<a href="$url">$url</a>|;
}

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

sub find_links
{
    my %args = @_;
    my @links;
    markup_links(
        text    => $args{'text'},
        handler => sub { push @links, shift });
    return @links;
}

=head1 AUTHOR

Tomáš Znamenáček, C<< <zoul at fleuron.cz> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-text-findlinks at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Text-FindLinks>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tomáš Znamenáček.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
