use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name => 'Cache::Any',
	license => 'mit',
	configure_requires => {
		'Module::Build' => '',
	},
	build_requires => {
		'Test::MockObject' => '',
		'Test::More' => '',
	},
	requires => {
		'perl' => '>=5.006',
	},
	add_to_cleanup => ['Cache-Any-*'],
	create_readme => 1,
	recursive_test_files => 1,
	repository => 'git://github.com/sebnow/cache-any-perl.git',
);

$builder->create_build_script();

