# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('x������y' =~ /(������)/) {
    if ("$1" eq "������") {
        print "ok - 1 $^X $__FILE__ ('x������y' =~ /������/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('x������y' =~ /������/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('x������y' =~ /������/).\n";
}

__END__
