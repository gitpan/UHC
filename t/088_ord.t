# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC qw(ord);
print "1..2\n";

my $__FILE__ = __FILE__;

if (ord('��') == 0x82A0) {
    print qq{ok - 1 ord('��') == 0x82A0 $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 ord('��') == 0x82A0 $^X $__FILE__\n};
}

$_ = '��';
if (ord == 0x82A2) {
    print qq{ok - 2 \$_ = '��'; ord == 0x82A2 $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 \$_ = '��'; ord == 0x82A2 $^X $__FILE__\n};
}

__END__
