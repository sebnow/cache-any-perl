#!/usr/bin/env perl
use strict;
use warnings;

use Cache::Any::Adapter::Null;
use Test::More tests => 8;

my $NULL_ADAPTER = 'Cache::Any::Adapter::Null';

{
	my $cache = $NULL_ADAPTER->new();
	$cache->set('foo', 'bar');
	is($cache->get('foo'), undef,
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'when I cache "bar" using the key "foo", ' .
		'then it should succeed ' .
		'and the key "foo" should not exist');
}

{
	my $cache = $NULL_ADAPTER->new();
	$cache->replace('foo', 'zing');
	is($cache->get('foo'), undef,
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and the key "foo" does not exist, ' .
		'when I replace "zing" for the key "foo", ' .
		'then it should succeed ' .
		'and the key "foo" should not exist');
	$cache->set('foo', 'bar');
	$cache->replace('foo', 'zing');
	is($cache->get('foo'), undef,
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and I cached "bar" using the key "foo", ' .
		'when I replace "zing" for the key "foo", ' .
		'then it should succeed ' .
		'and the key "foo" should not exist');
}

{
	my $cache = $NULL_ADAPTER->new();
	$cache->add('foo', 'bar');
	is($cache->get('foo'), undef,
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and the key "foo" does not exist, ' .
		'when I add "bar" for the key "foo", ' .
		'then it should succeed ' .
		'and the key "foo" should not exist');
	$cache->add('foo', 'zing');
	is($cache->get('foo'), undef,
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and I cached "bar" using the key "foo", ' .
		'when I add "zing" for the key "foo", ' .
		'then it should succeed ' .
		'and the key "foo" should not exist');
}

{
	my $cache = $NULL_ADAPTER->new();
	$cache->set('foo', 'bar');
	$cache->remove('foo');
	is($cache->get('foo'), undef,
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and I cached "bar" using the key "foo", ' .
		'when I remove the key "foo", ' .
		'then the key "foo" should not exist');
}

{
	my $cache = $NULL_ADAPTER->new();
	ok(!$cache->exists('foo'),
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and they key "foo" does not exist, ' .
		'when I check whether the key "foo" exists, ' .
		'then it should fail');
	$cache->set('foo', 'bar');
	ok(!$cache->exists('foo'),
		"Given I initialised the \"$NULL_ADAPTER\" adapter, " .
		'and I cached "bar" using the key "foo", ' .
		'when I check whether the key "foo" exists, ' .
		'then it should fail');
}

