# vim: ft=perl6

plan(15);

my $p5code := '{ foo => 2, bar => 7 }';

pir::load_bytecode("perl5.pir");
my $p5obj := pir::compreg__ps("perl5").make_interp($p5code)();

my %expected;
my $got;
my $iter;

$iter := pir::iter__pp($p5obj);
$got  := pir::shift__pp($iter);
if $got.key eq 'foo' {
    $got := pir::shift__pp($iter);
}

ok((~$got.key) eq 'bar', "iterator results have keys accessible on .key");
ok((~$got) eq 'bar', "iterator results stringify to keys");
ok((+$got.value) == 7, "iterator values are accessible on .value");
ok((~pir::deref__PP($got)) eq 'bar', "iterator keys are on get_pmc");

pir::shift__pp(pir::iter__pp($p5obj));

ok((~$got.key) eq 'bar', "pair keys remain accessible after a new iteration");
ok((+$got.value) == 7, "pair values remain accessible after a new iteration");

%expected<foo> := 1;
%expected<bar> := 1;

$iter := pir::iter__pp($p5obj);

ok(?$iter, "iterator reports more elements [0/2]");
$got := ~pir::shift__pp($iter);
ok(%expected{$got}, "got foo or bar [0/2]");
%expected{$got} := 0;

ok(?$iter, "iterator reports more elements [1/2]");
$got := ~pir::shift__pp($iter);
ok(%expected{$got}, "got the other [1/2]");
%expected{$got} := 0;

ok(!?$iter, "iterator reports no more elements [2/2]");
{
    $got := pir::shift__pp($iter);
    CATCH {
        ok($!<message> ~~ /StopIteration/, "getting next dies [2/2]");
    }
    ok(0, "getting next dies [2/2]");
};

%expected<foo> := 1;
%expected<bar> := 1;

$iter := pir::iter__pp($p5obj);

$got := ~pir::shift__pp($iter);
ok(%expected{$got}, "got foo or bar without priming [0/2]");
%expected{$got} := 0;

$got := ~pir::shift__pp($iter);
ok(%expected{$got}, "got the other without priming [1/2]");
%expected{$got} := 0;

{
    $got := pir::shift__pp($iter);
    CATCH {
        ok($!<message> ~~ /StopIteration/, "getting next dies without priming [2/2]");
    }
    ok(0, "getting next dies without priming [2/2]");
}

