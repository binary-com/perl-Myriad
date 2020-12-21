package Myriad::Service::Storage;

use Myriad::Class;

# VERSION
# AUTHORITY

=encoding utf8

=head1 NAME

Myriad::Service:Storage - microservice storage abstraction

=head1 SYNOPSIS

 my $storage = $myriad->storage;
 await $storage->get('some_key');
 await $storage->hash_add('some_key', 'hash_key', 13);

=head1 DESCRIPTION

=cut

use Role::Tiny::With;

with qw(Myriad::Role::Storage);

has $storage;
has $prefix;

BUILD (%args) {
    $prefix = delete $args{prefix} // die 'need a prefix';
    $storage = delete $args{storage} // die 'need a storage instance';
}

=head2 apply_prefix

Maps the requested key into the service's keyspace
so we can pass it over to the generic storage layer.

Takes the following parameters:

=over 4

=item * C<$k> - the key

=back

Returns the modified key.

=cut

method apply_prefix ($k) {
    return $prefix . '.' . $k;
}

async method get ($k, %args) { return await $storage->get($self->apply_prefix($k)) }
async method set ($k, $v, %args) { return await $storage->set($self->apply_prefix($k), $v) }
async method observe ($k, %args) { return await $storage->observe($self->apply_prefix($k)) }
async method push ($k, $v, %args) { return await $storage->push($self->apply_prefix($k), $v) }
async method unshift ($k, %args) { return await $storage->unshift($self->apply_prefix($k)) }
async method pop ($k, %args) { return await $storage->pop($self->apply_prefix($k)) }
async method shift ($k, %args) { return await $storage->shift($self->apply_prefix($k)) }
async method hash_set ($k, %args) { return await $storage->hash_set($self->apply_prefix($k), %args) }
async method hash_get ($k, %args) { return await $storage->hash_get($self->apply_prefix($k)) }
async method hash_add ($k, %args) { return await $storage->hash_add($self->apply_prefix($k), %args) }
async method hash_keys ($k, %args) { return await $storage->hash_keys($self->apply_prefix($k)) }
async method hash_values ($k, %args) { return await $storage->hash_values($self->apply_prefix($k)) }
async method hash_exists ($k, %args) { return await $storage->hash_exists($self->apply_prefix($k)) }
async method hash_count ($k, %args) { return await $storage->hash_count($self->apply_prefix($k)) }
async method hash_as_list ($k, %args) { return await $storage->hash_as_list($self->apply_prefix($k)) }

1;

=head1 AUTHOR

Deriv Group Services Ltd. C<< DERIV@cpan.org >>.

See L<Myriad/CONTRIBUTORS> for full details.

=head1 LICENSE

Copyright Deriv Group Services Ltd 2020. Licensed under the same terms as Perl itself.

