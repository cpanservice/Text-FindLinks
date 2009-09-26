#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 7;
use Test::Warn;
use Test::Exception;
use Text::FindLinks qw/markup_links find_links/;

warning_is { markup_links(text => 'foo') } undef, 'markup_links: simple case, no warnings';
warning_is { markup_links(text => 'foo', handler => sub{'bar'}) } undef, 'pass custom URL handler';
dies_ok { markup_links() } 'markup_links dies with no args';
dies_ok { markup_links('foo') } 'markup_links: dies on wrong params';
dies_ok { markup_links(text => 'foo', handler => 'bar') } 'dies on invalid handler type';

warning_is { find_links(text=>'foo') } undef, 'find_links: simple case, no warnings';
dies_ok { find_links('foo') } 'find_links: dies on wrong params';
