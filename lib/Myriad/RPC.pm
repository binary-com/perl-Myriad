package Myriad::RPC;

use strict;
use warnings;

# VERSION
# AUTHORITY

no indirect;
use Future::AsyncAwait;

use Myriad::RPC::Message;
use Myriad::Exception::RPCMethodNotFound;

=encoding utf8

=head1 NAME

Myriad::RPC - microservice RPC abstraction

=head1 SYNOPSIS

 my $rpc = $myriad->rpc;

=head1 DESCRIPTION

=head1 Implementation

Note that this is defined as a rôle, so it does not provide
a concrete implementation - instead, see classes such as:

=over 4

=item * L<Myriad::RPC::Implementation::Redis>

=item * L<Myriad::RPC::Implementation::Perl>

=back

=cut

use Role::Tiny;

requires 'rpc_map';

=head2 listen

The starting point of the RPC implementation where it should start receiving messages and process them.

=cut

requires 'listen';

=head2 reply_success

Reply back to the sender of the message with success payload.
The method will take the raw response and take care of how we are going to encapsulate it.

=over 4

=item * message - The message we are processing.

=item * response - The success response.

=back

=cut

requires 'reply_success';

=head2 reply_error

Same concept of C<reply_success> but for errors.

=over 4

=item * message - The message we are processing.

=item * error - The L<Myriad::Exception> that happened while processing the message.

=back

=cut

requires 'reply_error';

=head2 drop

This should be used to handle dead messages (messages that we couldn't even parse).

It doesn't matter how the implementation is going to deal with it (delete it/ move it to another queue ..etc) the RPC handler
should call this method when it's unable to parse a message and we can't reply to the client.

=over 4

=item * id - The transport message id.

=back

=cut

requires 'drop';

1;

__END__

=head1 AUTHOR

Binary Group Services Ltd. C<< BINARY@cpan.org >>.

See L<Myriad/CONTRIBUTORS> for full details.

=head1 LICENSE

Copyright Binary Group Services Ltd 2020. Licensed under the same terms as Perl itself.

