# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{あ} ne "\x82\xa0";

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('あ]' =~ /(あ])/) {
    if ("$1" eq "あ]") {
        print "ok - 1 $^X $__FILE__ ('あ]' =~ /あ]/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('あ]' =~ /あ]/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('あ]' =~ /あ]/).\n";
}

__END__
