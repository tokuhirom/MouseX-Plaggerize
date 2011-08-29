use inc::Module::Install;
name 'MouseX-Plaggerize';
all_from 'lib/MouseX/Plaggerize.pm';

requires 'Mouse'        => '0.93';
requires 'Scalar::Util' => '1.19';

tests 't/*.t t/*/*.t t/*/*/*.t';
author_tests('xt');
test_requires 'Test::More';
WriteAll;
