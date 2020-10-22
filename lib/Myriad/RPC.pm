package Myriad::RPC;

use strict;
use warnings;

# VERSION
# AUTHORITY

no indirect qw(fatal);
use utf8;

use constant ERROR_CATEGORY => 'rpc';

=encoding utf8

=head1 NAME

Myriad::RPC - microservice RPC abstraction

=head1 SYNOPSIS

 my $rpc = $myriad->rpc;

=head1 DESCRIPTION

=cut

use Role::Tiny;
use Myriad::Exception::Builder;

=head1 Exceptions

=cut

=head2 InvalidRequest

Returned when there is issue parsing the request, or if the request parameters are incomplete.

=cut

declare_exception InvalidRequest => (
    category => ERROR_CATEGORY,
    message => 'Invalid request'
);

=head2 MethodNotFound

Returned if the requested method is not recognized by the service.

=cut

declare_exception MethodNotFound => (
    category => ERROR_CATEGORY,
    message => 'Method not found'
);

=head2 Timeout

Returned when there is an external timeout or the request deadline is already passed.

=cut

declare_exception Timeout => (
    category => ERROR_CATEGORY,
    message => 'Timeout'
);

=head2 BadEncoding

Returned when the service is unable to decode/encode the request correctly.

=cut

declare_exception BadEncoding => (
    category => ERROR_CATEGORY,
    message => 'Bad encoding'
);

1;

__END__

=head1 AUTHOR

Deriv Group Services Ltd. C<< DERIV@cpan.org >>.

See L<Myriad/CONTRIBUTORS> for full details.

=head1 LICENSE

Copyright Deriv Group Services Ltd 2020. Licensed under the same terms as Perl itself.

