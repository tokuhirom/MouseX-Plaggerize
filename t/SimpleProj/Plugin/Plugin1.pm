package t::SimpleProj::Plugin::Plugin1;
use MouseX::Plaggerize::Plugin;
our $TESTED = 0;

hook 'test1' => sub {
    $TESTED = 1;
};

1;
