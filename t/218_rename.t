# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

my $__FILE__ = __FILE__;

use UHC;
print "1..3\n";

if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    print "ok - 1 # SKIP $^X $0\n";
    print "ok - 2 # SKIP $^X $0\n";
    print "ok - 3 # SKIP $^X $0\n";
    exit;
}

open(FILE,'>F�@�\') || die "Can't open file: F�@�\\n";
print FILE "1\n";
close(FILE);

unlink('file');

# rename (1/3)
if (rename('F�@�\','file')) {
    print "ok - 1 rename (1/3) $^X $__FILE__\n";
}
else {
    print "not ok - 1 rename: $! $^X $__FILE__\n";
}

# rename (2/3)
if (rename('file','F�@�\')) {
    print "ok - 2 rename (2/3) $^X $__FILE__\n";
}
else {
    print "not ok - 2 rename: $! $^X $__FILE__\n";
}

# rename (3/3)
if (rename('F�@�\','F2�@�\')) {
    print "ok - 3 rename (3/3) $^X $__FILE__\n";
    system('del F2�@�\ 2>NUL');
}
else {
    print "not ok - 3 rename: $! $^X $__FILE__\n";
}

unlink('F�@�\');

__END__
