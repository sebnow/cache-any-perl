package Cache::Any::Proxy;
use strict;
use warnings;
use constant PROXIED_SUBS => qw(get set remove replace add exists);
use subs PROXIED_SUBS;

foreach my $sub (PROXIED_SUBS) {
	no strict 'refs';
	*{$sub} = sub {
		return shift->{'target'}->$sub(@_);
	};
}

sub new {
	my ($class, $target) = @_;
	my $self = bless({}, $class);
	$self->_set_target($target);

	return $self;
}

sub _set_target {
	my $self = shift;
	$self->{'target'} = shift;
}

1;

__END__

=head1 NAME

Cache::Any::Proxy - Proxy class for Cache::Any::Adapter

=head1 SYNOPSIS

	use Cache::Any::Adapter::Null;
	use Cache::Any::Proxy;

	my $adapter = Cache::Any::Adapter::Null->new();
	my $proxy = Cache::Any::Proxy->new($adapter);

	$proxy->get('foo'); # calls $adapter->get('foo')

=head1 DESCRIPTION

The Cache::Any::Proxy class proxies methods to the target
Cache::Any::Adapter object. This is to allow Cache::Any::Adapter to
dynamically substitute referenced adapters in calling modules. E.g.:

	Cache::Any::Adapter->set('SomeCache');

	# Proxy object for SomeCache
	my $cache = Cache::Any::Adapter->get_cache();

	Cache::Any::Adapter->set('SomeOtherCache');
	# The $cache object now proxies to SomeOtherCache

=head1 METHODS

=head2 new

	Cache::Any::Proxy->new($adapter);

Instantiates a new object with C<$adapter> as the target for proxied
methods. The object provided as the C<$adapter> must implement the
Cache::Any interface.

=cut

