package DirestNeed::Controller::Get;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

DirestNeed::Controller::Get - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 index

=cut

sub index :Path :OptionalArgs(1) {
  my ( $self, $c, $receiver ) = @_;
  if (defined $receiver) {
    if (exists $c->model('DB')->roles->{$receiver}{receiver}) {
      $c->stash
	(
	 receiver => $receiver,
	 shoppinglist => $c->model('DB')->shoppinglists->{$receiver},
	);
    }
  } else {
    $c->stash
      (
       template => 'get/login_form.tt2',
      );
  }
}

sub login :Local :Args(0) {
  my ( $self, $c ) = @_;
  $c->response->redirect($c->uri_for($c->request->params->{login}));
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
