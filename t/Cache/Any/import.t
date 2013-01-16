#!/usr/bin/env perl
use Test::More tests => 2;

BEGIN {
	use_ok('Cache::Any', qw($cache));
}

ok(defined($cache),
	'Given I have imported Cache::Any with the $cache variable, ' .
	'then the local $cache variable should be defined');

