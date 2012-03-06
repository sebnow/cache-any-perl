package Cache::Any;
use strict;
use warnings;

our $VERSION = v0.1.0;

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

