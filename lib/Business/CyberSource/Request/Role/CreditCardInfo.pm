package Business::CyberSource::Request::Role::CreditCardInfo;
use 5.008;
use strict;
use warnings;
use Carp;
BEGIN {
	# VERSION
}
use Moose::Role;
use namespace::autoclean;
use MooseX::Aliases;
use MooseX::Types::Moose      qw( Int        );
use MooseX::Types::Varchar    qw( Varchar    );
use MooseX::Types::CreditCard 0.001001 qw( CreditCard CardSecurityCode );

has credit_card => (
	required => 1,
	is       => 'ro',
	isa      => CreditCard,
	coerce   => 1,
);

has card_type => (
	required => 0,
	is       => 'ro',
	isa      => Varchar[3],
);

has cc_exp_month => (
	required => 1,
	is       => 'ro',
	isa      => Int,
);

has cc_exp_year => (
	required => 1,
	is       => 'ro',
	isa      => Int,
);

has cv_indicator => (
	required => 0,
	lazy     => 1,
	is       => 'ro',
	isa      => Varchar[1],
	default  => '1',
	documentation => 'Flag that indicates whether a CVN code was sent'
);

has cvn => (
	required => 0,
	alias    => [ qw( cvv cvv2  cvc2 cid ) ],
	is       => 'ro',
	isa      => CardSecurityCode,
);

1;

# ABSTRACT: credit card info role
