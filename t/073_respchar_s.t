# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

$a = "�A�\�A";
if ($a !~ s/(�A�C|�C�E)//) {
    print qq{ok - 1 "�A�\�A" !~ s/(�A�C|�C�E)// \$1=() $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 "�A�\�A" !~ s/(�A�C|�C�E)// \$1=($1) $^X $__FILE__\n};
}

__END__
