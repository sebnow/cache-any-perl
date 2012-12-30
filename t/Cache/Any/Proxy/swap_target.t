#!/usr/bin/env perl
use strict;
use warnings;
use Cache::Any::Proxy;
use Test::MockObject;
use Test::More tests => 2;

{
	my $adapter1 = Test::MockObject->new()->set_true('get');
	my $adapter2 = Test::MockObject->new()->set_true('get');
	my $proxy = Cache::Any::Proxy->new($adapter1);
	$proxy->get();
	$adapter1->called_ok('get',
		'Given I have initialised an adapter, ' .
		'and I have initialised a proxy with the adapter, ' .
		'when I call the "get" method on the proxy, ' .
		'then the "get" method on the adapter should be called');
	$proxy->_set_target($adapter2);
	$proxy->get();
	$adapter2->called_ok('get',
		'Given I have initialised an adapter, ' .
		'and I have initialised a proxy with the adapter, ' .
		'and I have initialised another adapter, ' .
		'when I set the target of the proxy to the other adapter, ' .
		'when I call the "get" method on the proxy, ' .
		'then the "get" method on the other adapter should be called');
}

