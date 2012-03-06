package Cache::Any::Adapter::Null;
use strict;
use warnings;

sub new {
	return bless({}, shift);
}

foreach my $null_method (qw(get exists replace)) {
	no strict 'refs';
	*{__PACKAGE__ . "::$null_method"} = sub {
		return;
	}
}

foreach my $success_method (qw(set add remove)) {
	no strict 'refs';
	*{__PACKAGE__ . "::$success_method"} = sub {
		return 1;
	}
}

1;

__END__

=head1 NAME

Cache::Any::Adapter::Null - An adapter which does nothing.

=head1 DESCRIPTION

C<Cache::Any::Adapter::Null> is the default adapter. It provides no
caching mechanism. Its sole purpose is to provide sane behaviour for the
cache interface.

=cut

