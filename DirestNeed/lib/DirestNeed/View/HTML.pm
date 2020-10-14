package DirestNeed::View::HTML;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
		     INCLUDE_PATH => [
				      DirestNeed->path_to( 'root', 'src' ),
				      DirestNeed->path_to( 'root', 'lib' )
				     ],
		     PRE_PROCESS  => 'config/main',
		     WRAPPER      => 'site/wrapper',
		     TEMPLATE_EXTENSION => '.tt2',
		     ERROR        => 'error.tt2',
		     TIMER        => 0,
		     render_die   => 1,
		    });

=head1 NAME

DirestNeed::View::HTML - Catalyst TT Twitter Bootstrap View

=head1 SYNOPSIS

See L<DirestNeed>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

Andrew John Dougherty,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

