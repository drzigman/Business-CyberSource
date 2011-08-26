package Business::CyberSource::Request::Role::BillingInfo;
use 5.008;
use strict;
use warnings;
use Carp;

# VERSION

use Moose::Role;
use namespace::autoclean;
use MooseX::Aliases;
use MooseX::Types::Varchar         qw( Varchar       );
use MooseX::Types::Email           qw( EmailAddress  );
use MooseX::Types::Locale::Country qw( Alpha2Country );

has first_name => (
	required => 1,
	is       => 'ro',
	isa      => Varchar[60],
	documentation => 'Card Holder\'s first name',
);

has last_name => (
	required => 1,
	is       => 'ro',
	isa      => Varchar[60],
	documentation => 'Card Holder\'s last name',
);

has street => (
	required => 1,
	is       => 'ro',
	isa      => Varchar[60],
	alias    => 'street1',
	documentation => 'Street address on credit card billing statement',
);

has city => (
	required => 1,
	is       => 'ro',
	isa      => Varchar[50],
	documentation => 'City on credit card billing statement',
);

has state => (
	required => 1,
	is       => 'ro',
	isa      => Varchar[2],
	documentation => 'State on credit card billing statement',
);

has country => (
	required => 1,
	coerce   => 1,
	is       => 'ro',
	isa      => Alpha2Country,
	documentation => 'ISO 2 character country code '
		. '(as it would apply to a credit card billing statement)',
);

has zip => (
	required => 1,
	is       => 'ro',
	isa      => Varchar[10],
	documentation => 'postal code on credit card billing statement',
);

has email => (
	required => 1,
	is       => 'ro',
	isa      => EmailAddress,
);

has ip => (
	required => 0,
	is       => 'ro',
	isa      => Varchar[15],
	documentation => 'IP address that customer submitted transaction from',
);

sub _build_bill_to_info {
	my ( $self, $sb ) = @_;

	my $bill_to = $sb->add_elem(
		name => 'billTo',
	);

	$sb->add_elem(
		name   => 'firstName',
		value  => $self->first_name,
		parent => $bill_to,
	);

	$sb->add_elem(
		name   => 'lastName',
		value  => $self->last_name,
		parent => $bill_to,
	);

	$sb->add_elem(
		name   => 'street1',
		value  => $self->street,
		parent => $bill_to,
	);

	$sb->add_elem(
		name   => 'city',
		value  => $self->city,
		parent => $bill_to,
	);

	$sb->add_elem(
		name   => 'state',
		parent => $bill_to,
		value  => $self->state,
	);

	$sb->add_elem(
		name   => 'postalCode',
		parent => $bill_to,
		value  => $self->zip,
	);

	$sb->add_elem(
		name   => 'country',
		parent => $bill_to,
		value  => $self->country,
	);

	$sb->add_elem(
		name   => 'email',
		value  => $self->email,
		parent => $bill_to,
	);

	if ( $self->ip ) {
		$sb->add_elem(
			name   => 'ipAddress',
			value  => $self->ip,
			parent => $bill_to,
		);
	}

	return $sb;
}

1;

# ABSTRACT: Role for requests that require "bill to" information
