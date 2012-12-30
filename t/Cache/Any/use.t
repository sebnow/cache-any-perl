#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
	use_ok('Cache::Any');
	use_ok('Cache::Any::Adapter::Null');
};

