use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DirestNeed';
use DirestNeed::Controller::Give;

ok( request('/give')->is_success, 'Request should succeed' );
done_testing();
