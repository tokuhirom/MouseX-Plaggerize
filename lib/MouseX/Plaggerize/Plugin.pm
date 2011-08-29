package MouseX::Plaggerize::Plugin;
use strict;
use warnings;
use Mouse;
use Scalar::Util qw/blessed/;
use Sub::Exporter;
use Carp;

{
    my $CALLER;
    my $HOOK_STORE = {};

    my %exports = (
        register => sub {
            sub {
                my ( $self, $c ) = @_;
                my $proto = blessed $self or confess "this is instance method: $self";

                for my $row ( @{ $HOOK_STORE->{$proto} || [] } ) {
                    my ( $hook, $code ) = @$row;
                    $c->register_hook( $hook, $self, $code );
                }
            }
        },
        hook => sub {
            sub {
                my ( $hook, $code ) = @_;
                my $caller = caller(0);
                push @{ $HOOK_STORE->{$caller} }, [ $hook, $code ];
            }
        },
    );

    my $exporter = Sub::Exporter::build_exporter(
        {
            exports => \%exports,
            groups  => { default => [':all'] }
        }
    );

    sub import {
        $CALLER = caller();

        strict->import;
        warnings->import;

        return if $CALLER eq 'main';

        Mouse->init_meta(for_class => $CALLER);
        Mouse->import( { into => $CALLER } );

        goto $exporter;
    }
}

1;
__END__

=head1 NAME

MouseX::Plaggerize::Plugin - plugin

=head1 SYNOPSIS

    package Your::Plugin::Foo;
    use MouseX::Plaggerize::Plugin;

=head1 DESCRIPTION

plugin class for MouseX:Plaggerize.

=head1 METHODS

=over 4

=item register

    $self->register( $c );

internal use only

=item hook

    hook 'hook point' => sub {
        # do something
    };

add coderef to hook point.

=back

=head1 SEE ALSO

L<MouseX::Plaggerize>

