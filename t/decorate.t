#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1;
use Text::FindLinks 'markup_links';

is markup_links(text => 'www.foo.com'),
    '<a href="http://www.foo.com">www.foo.com</a>',
    'Convert relative links to absolute';
