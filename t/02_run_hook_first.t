use strict;
use warnings;
use Test::More tests => 2;
use MouseX::Plaggerize;

my $context = Mouse::Meta::Class->create_anon_class(
    roles        => ['MouseX::Plaggerize'],
)->new_object;

my $plugin = Mouse::Meta::Class->create_anon_class()->new_object;

{
    $context->register_hook(
        'first' => $plugin,
        sub {
            ok 1, "this hook should run";
            return 0;
        }
    );
    $context->register_hook(
        'first' => $plugin,
        sub {
            ok 1, "this hook should run";
            return 1;
        }
    );
    $context->register_hook(
        'first' => $plugin,
        sub {
            ok 0, "this hook should not run";
            return 0;
        }
    );
}

$context->run_hook_first('first');

