package Cache::Any;
use strict;
use warnings;

require Cache::Any::Adapter::Null;

our $VERSION = v0.1.0;
our %NullAdapters;

sub import {
	my $class = shift;
	my $param = shift;
	if(defined($param)) {
		if($param eq '$cache') {
			my $caller = caller();
			my $cache = $class->get_cache('namespace' => $caller);
			no strict 'refs';
			my $var = "${caller}::cache";
			*$var = \$cache;
		} else {
			die("invalid import '$param' - must be '\$cache'");
		}
	}
}

sub get_cache {
	my ($self, %args) = @_;
	my $namespace = delete($args{'namespace'}) || qr/.*/;
	if($Cache::Any::Adapter::INITIALIZED) {
		return Cache::Any::Adapter->get_cache($namespace, %args);
	} else {
		$NullAdapters{$args{'namespace'}} ||= Cache::Any::Adapter::Null->new();
		return $NullAdapters{$args{'namespace'}};
	}
}

1;

__END__

=head1 NAME

Cache::Any - Lightweight interface for caching

=head1 SYNOPSIS

	package Foo;
	use Cache::Any qw($cache);

=head1 DESCRIPTION

C<Cache::Any> allows modules to efficiently and simply cache, while
letting applications choose a caching mechanism such as
L<Memcached|Cache::Memcached> or L<CHI|CHI>.

C<Cache::Any> has a very tiny footprint and no dependencies beyond Perl
5.6, which makes it appropriate for even small modules to use. It
defaults to 'null' logging activity, so a module can safely log without
worrying about whether the application has chosen (or will ever choose)
a caching mechanism.

=head1 INTERFACE

The C<Cache::Any|Cache::Any> interface consists of the following
methods:

=head2 get

	my $value = $cache->get($key);
	my @values = $cache->get(@keys);

Retrieve the specified C<$key> or C<@keys> from the cache. For every key
which does not exist, C<undef> is returned.

=head2 set

	$cache->set($key, $value, [$expires]);

Cache C<$value> using the C<$key>. If C<$expires> is provided, the key
will expire after C<$expires> seconds. If the caching mechanism does not
support expiring keys, setting C<$expires> has no effect.

=head2 add

	$cache->add($key, $value, [$expires]);

The same as L<set|Cache::Any::set> but the C<$value> will not be set if
the C<$key> already exists.

=head2 replace

	$cache->replace($key, $value, [$expires]);

The same as L<set|Cache::Any::set> but the C<$value> will only be set if
the C<$key> already exists.

=head2 remove

	$cache->remove($key);

Remove C<$key> from the cache. Depending on the caching mechanism the
C<$key> might be be removed immediately (i.e. expired instead).

=head2 exists

	$cache->exists($key);

Verifies whether the C<$key> exists in the cache and is not expired.

=head1 INSPIRATION

C<Cache::Any> is heavily influenced by L<Log::Any|Log::Any>. The concept
is identical; provide a lightweight interface with for modules, allowing
applications to specify the backend.

=head1 MOTIVATION

There are many caching interfaces, with the predominant ones being
L<CHI|CHI> and L<Cache::Cache|Cache::Cache>, however they do more than
just provide an interface. They implement some caching logic such as
expiration times or serialisation. Some of them also have many
dependencies which can be heavy (e.g. L<CHI|CHI> depends on
L<Moose|Moose>).

C<Cache::Any> aims to provide the thinnest possible interface and
delegates all the heavy lifting to the caching mechanism. This may be at
the cost of flexibility, but if that is a requirement then L<CHI|CHI> or
L<Cache::Cache> can be used instead.

=head1 SEE ALSO

L<CHI|CHI>, L<Cache::Cache|Cache::Cache>, L<Log::Any|Log::Any>

=head1 AUTHORS

Sebastian Nowicki <sebnow@gmail.com>

=cut

