use strict;
use warnings;

use Test::BDD::Cucumber::StepFile;
use Test::More;
use Cache::Any;

Given qr/a Cache::Any object/, sub {
	my $c = shift;
	$c->stash->{'scenario'}->{'cache'} = Cache::Any->get_cache();
};

When qr/the Null adapter is set/, sub {
	eval {
		require Cache::Any::Adapter;
		Cache::Any::Adapter->set('Null');
	};
	isa_ok(Cache::Any->get_cache(), 'Cache::Any::Adapter::Null');
};

When qr/I cache "([^"]+)" using the key "([^"]+)"/, sub {
	my $c = shift;
	my $result = $c->stash->{'scenario'}->{'cache'}->set($2, $1);
	$c->stash->{'scenario'}->{'result'} = $result;
};

When qr/I get the key "([^"]+)" from the cache/, sub {
	my $c = shift;
	my $value = $c->stash->{'scenario'}->{'cache'}->get($1);
	$c->stash->{'scenario'}->{'value'} = $value;
};

When qr/I remove the key "([^"]+)" from the cache/, sub {
	my $c = shift;
	my $result = $c->stash->{'scenario'}->{'cache'}->remove($1);
	$c->stash->{'scenario'}->{'result'} = $result;
};

When qr/I add "([^"]+)" to the cache using the key "([^"]+)"/, sub {
	my $c = shift;
	my $result = $c->stash->{'scenario'}->{'cache'}->add($2, $1);
	$c->stash->{'scenario'}->{'result'} = $result;
};

When qr/I replace "([^"]+)" with the value "([^"]+)" in the cache/, sub {
	my $c = shift;
	my $result = $c->stash->{'scenario'}->{'cache'}->replace($1, $2);
	$c->stash->{'scenario'}->{'result'} = $result;
};

Then qr/it should succeed/, sub {
	my $c = shift;
	ok($c->stash->{'scenario'}->{'result'});
};

Then qr/it should fail/, sub {
	my $c = shift;
	ok(!$c->stash->{'scenario'}->{'result'});
};

Then qr/the key "([^"]+)" should not exist/, sub {
	my $c = shift;
	ok(!$c->stash->{'scenario'}->{'cache'}->exists($1));
};

Then qr/the value should be undefined/, sub {
	my $c = shift;
	my $value = $c->stash->{'scenario'}->{'value'};
	is($value, undef);
};

