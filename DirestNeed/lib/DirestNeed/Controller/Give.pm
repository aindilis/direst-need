package DirestNeed::Controller::Give;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

DirestNeed::Controller::Give - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 index

=cut

sub index :Path :OptionalArgs(1) {
  my ( $self, $c, $donor ) = @_;
  if (defined $donor) {
    if (exists $c->model('DB')->roles->{$donor}{donor}) {
      $c->stash
	(
	 donor => $donor,
	 shoppinglists => $c->model('DB')->shoppinglists,
	);
    }
  } else {
    $c->stash
      (
       template => 'give/login_form.tt2',
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
