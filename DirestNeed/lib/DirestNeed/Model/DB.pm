package DirestNeed::Model::DB;
use Moose;
use namespace::autoclean;

use Data::Dumper;
use Error qw(:try);

# use Language::Prolog::Types qw(:ctors);

extends 'Catalyst::Model';

=head1 NAME

ShinyCMS::Model::FRDCSA - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=cut

has 'users' =>
  (
   isa      => 'ArrayRef',
   is       => 'rw',
   default => sub {
     return ['jack','jill','david','dalia'];
   },
  );

has roles =>
  (
   isa      => 'HashRef',
   is       => 'rw',
   default => sub {
     return
       {
	'jack' => {'receiver' => 1},
	'jill' => {'receiver' => 1},
	'david' => {'donor' => 1},
	'dalia' => {'donor' => 1},
       };
   },
  );

has shoppinglists =>
  (
   isa      => 'HashRef',
   is       => 'rw',
   default => sub {
     return
       {
	'jack' => ['shoes','socks'],
	'jill' => ['socks','backpack'],
       };
   },
  );

has stories =>
  (
   isa      => 'HashRef',
   is       => 'rw',
   default => sub {
     return
       {
	'jack' => 'I had to caregive for my mother and that depleted all my financial reserves.',
       };
   },
  );


__PACKAGE__->meta->make_immutable;

1;
