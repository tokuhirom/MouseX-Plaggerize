use strict;
use warnings;
use Test::More tests => 1;
use MouseX::Plaggerize;

my $context = Mouse::Meta::Class->create_anon_class(
    roles        => ['MouseX::Plaggerize'],
)->new_object;

my $plugin = Mouse::Meta::Class->create_anon_class()->new_object;

{
    $context->register_hook(
        'filter' => $plugin,
        sub {
            my ($self, $c, $txt) = @_;
            $txt . '1';
        }
    );
    $context->register_hook(
        'filter' => $plugin,
        sub {
            my ($self, $c, $txt) = @_;
            $txt . '2';
        }
    );
}

my ($got, ) = $context->run_hook_filter('filter', 'src');
is $got, 'src12';

