# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

# s///g
$a = "ABCDEFGHIJCLMNOPQRSTUVWXYZ";

if ($a =~ s/C/������/g) {
    if ($a eq "AB������DEFGHIJ������LMNOPQRSTUVWXYZ") {
        print qq{ok - 1 \$a =~ s/C/������/g ($a) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 1 \$a =~ s/C/������/g ($a) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 1 \$a =~ s/C/������/g ($a) $^X $__FILE__\n};
}

__END__
