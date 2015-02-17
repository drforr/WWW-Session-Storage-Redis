#!perl

use Test::More tests => 13;

my $have_redis = 1;

eval "use Cache::Redis";

$have_redis = 0 if $@;

SKIP: {
	skip "Cache::Redis is not installed", 13 unless $have_redis;
	
	use_ok('WWW::Session::Storage::Redis');

	my $storage;
        eval { $storage = WWW::Session::Storage::Redis->new({server => "127.0.0.1:5379"}) };
	
	skip "Redis server is not running on 127.0.0.1:6379", 12 if $@;

	{	
		my $sid = 'test1';
		my $expires = -1;
		my $string = "Test 123";

		ok($storage->save($sid,$expires,$string),'Save works');

		sleep 1;

		my $rstring = $storage->retrieve($sid);

		is($rstring,$string,"String preserved");

		$storage->delete($sid);
		
		$rstring = $storage->retrieve($sid);
		is($rstring,undef,"Session data removed after destory()");
	}

	{
		my $sid = 'test2';
		my $expires = 10;
		my $string = "Test 123";

		ok($storage->save($sid,$expires,$string),'Save2 works');

		sleep 1;

		my $rstring = $storage->retrieve($sid);

		is($rstring,$string,"String2 preserved");

		$storage->delete($sid);
		
		$rstring = $storage->retrieve($sid);
		is($rstring,undef,"Session data removed after destory()");
	}

	{
		my $sid = 'test3';
		my $expires = 1;
		my $string = "Test 123";

		ok($storage->save($sid,$expires,$string),'Save3 works');

		sleep 3;

		my $rstring = $storage->retrieve($sid);

		is($rstring,undef,"String3 preserved");
		
		$rstring = $storage->retrieve($sid);
		is($rstring,undef,"Session data removed after destroy()");
	}

	{#utf8 test
		my $sid = 'test4';
		my $expires = 1;
		my $string = "Test 123 îâăȚȘș";

		ok($storage->save($sid,$expires,$string),'Save4 works');

		my $rstring = $storage->retrieve($sid);

		is($rstring,'Test 123 îâăȚȘș',"String4 (utf8) preserved");

		$storage->delete($sid);
		$rstring = $storage->retrieve($sid);
		is($rstring,undef,"Session data removed after destory()");
	}
}
