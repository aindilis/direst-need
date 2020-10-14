use strict;
use warnings;

use DirestNeed;

my $app = DirestNeed->apply_default_middlewares(DirestNeed->psgi_app);
$app;

