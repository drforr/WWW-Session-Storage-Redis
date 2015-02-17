use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::Session::Storage::Redis',
    AUTHOR              => q{Jeffrey Goff <jeffrey.goff@evozon.com>},
    VERSION_FROM        => 'lib/WWW/Session/Storage/Redis.pm',
    ABSTRACT_FROM       => 'lib/WWW/Session/Storage/Redis.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'	=> 0,
		'Test::Exception'	=> 0,
		'Test::Deep'	=> 0,
		'JSON'	=> 0,
		'WWW::Session'	=> 0,
		'Cache::Redis'	=> 0,
		'Storable'	=> 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-Session-Storage-Redis*' },
);
