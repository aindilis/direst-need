use strict;
use warnings;
use Test::More;


use Catalyst::Test 'DirestNeed';
use DirestNeed::Controller::Get;

ok( request('/get')->is_success, 'Request should succeed' );
done_testing();
