package DirestNeed::Controller::Get;
use Moose;
use namespace::autoclean;

use File::Slurp;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

DirestNeed::Controller::Get - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 index

=cut

sub index1 :Path :Args(0) {
  my ( $self, $c ) = @_;
  $c->stash
    (
     template => 'get/login_form.tt2',
    );
}

sub index_user :Path :PathPart('get') Chained('') :CaptureArgs(1) {
  my ( $self, $c, $receiver ) = @_;
  my $google_maps_apikey = read_file($ENV{HOME}.'/.config/frdcsa/google_maps_apikey.txt');
  chomp $google_maps_apikey;
  if (defined $receiver) {
    if (exists $c->model('DB')->roles->{$receiver}{receiver}) {
      $c->stash
	(
	 template => 'get/index.tt2',
	 receiver => $receiver,
	 shoppinglist => $c->model('DB')->shoppinglists->{$receiver},
	 story => $c->model('DB')->stories->{$receiver},
	 google_maps_apikey => $google_maps_apikey,
	);
    }
  }
}

sub add_to_shoppinglist :Chained('index_user') :Args(0) {
  my ( $self, $c ) = @_;
  if (exists $c->request->params->{add_to_shoppinglist}) {
    push @{$c->model('DB')->shoppinglists->{$c->stash->{receiver}}}, $c->request->params->{add_to_shoppinglist};
  }
  $c->stash
    (
     params => $c->request->params,
     template => 'get/index.tt2',
    );
  $c->response->redirect($c->uri_for($c->{stash}{receiver}));
}

sub login :Local :Args(0) {
  my ( $self, $c ) = @_;
  $c->response->redirect($c->uri_for($c->request->params->{login}));
}

sub maps_test :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $google_maps_apikey = read_file($ENV{HOME}.'/.config/frdcsa/google_maps_apikey.txt');
  chomp $google_maps_apikey;
  $c->stash
    (
     google_maps_apikey => $google_maps_apikey,
    );
}

=encoding utf8

=head1 AUTHOR

Andrew John Dougherty,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
