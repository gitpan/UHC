# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

my $__FILE__ = __FILE__;

use UHC;
use lib qw(./);
print "1..1\n";

my $chcp = `chcp`;
if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms or $chcp !~ /932|949/oxms) {
    print "ok - 1 # SKIP $^X $0\n";
    exit;
}

open(FILE,'>F�@�\') || die "Can't open file: F�@�\\n";
print FILE "1\n";
close(FILE);

# require
eval {
    require 'F�@�\';
};
if ($@) {
    print "not ok - 1 require: $@ $^X $__FILE__\n";
}
else {
    print "ok - 1 require $^X $__FILE__\n";
}

unlink('F�@�\');

__END__
