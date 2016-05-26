<?php
include 'test-more.php';
plan(28);

ok(true);
ok(true, 'ok() pass');
ok(false);
ok(false, 'ok() fail');

is('foo', 'foo');
is('foo', 'foo', 'is() pass');
is('foo', 'bar');
is('foo', 'bar', 'is() fail');

isnt('foo', 'bar');
isnt('foo', 'bar', 'isnt() pass');
isnt('foo', 'foo');
isnt('foo', 'foo', 'isnt() fail');

like('foo', '/oo/');
like('foo', '/oo/', 'like() pass');
like('foo', '/ar/');
like('foo', '/ar/', 'like() fail');

unlike('foo', '/ar/');
unlike('foo', '/ar/', 'unlike() pass');
unlike('foo', '/oo/');
unlike('foo', '/oo/', 'unlike() fail');

cmp_ok('foo', '==', 'foo');
cmp_ok('foo', '==', 'foo', 'cmp_ok() pass');
cmp_ok('foo', '==', 'bar');
cmp_ok('foo', '==', 'bar', 'cmp_ok() fail');

# FIXME: can_ok()

# FIXME: isa_ok()

pass();
pass('pass()');
fail();
fail('fail()');
diag('diag()');

# FIXME: require_ok()

# FIXME: is_deeply()

# FIXME: eq_array()

# FIXME: eq_hash()

# FIXME: eq_set()
?>
