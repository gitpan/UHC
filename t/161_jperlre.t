# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('��-��' =~ /(��\s��)/) {
    print "not ok - 1 $^X $__FILE__ not ('��-��' =~ /��\s��/).\n";
}
else {
    print "ok - 1 $^X $__FILE__ not ('��-��' =~ /��\s��/).\n";
}

__END__
