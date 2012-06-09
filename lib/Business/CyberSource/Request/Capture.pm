package Business::CyberSource::Request::Capture;
use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose;
extends 'Business::CyberSource::Request';
with 'Business::CyberSource::Request::Role::DCC';

has '+service' => ( remote_name => 'ccCaptureService' );

sub BUILD { ## no critic ( Subroutines::RequireFinalReturn )
	my $self = shift;

	confess 'Capture must have an auth_request_id'
		unless $self->service->has_auth_request_id
		;

	confess 'Capture Must not have a capture_request_id'
		if $self->service->has_capture_request_id
		;
}

__PACKAGE__->meta->make_immutable;
1;

# ABSTRACT: CyberSource Capture Request Object

=head1 SYNOPSIS

	use Business::CyberSource::Request::Capture;

	my $capture = Business::CyberSource::Request::Capture->new({
		reference_code => 'merchant reference code',
		service => {
			auth_request_id => 'authorization response request_id',
		},
		purchase_totals => {
			total    => 5.01,  # same amount as in authorization
			currency => 'USD', # same currency as in authorization
		},
	});

=head1 DESCRIPTION

This object allows you to create a request for a capture.

=head1 EXTENDS

L<Business::CyberSource::Request>

=head1 WITH

=over

=item L<Business::CyberSource::Request::Role::DCC>

=back

=cut
