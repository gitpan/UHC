# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{あ} ne "\x82\xa0";

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('あ-い' =~ /(あ\Sい)/) {
    if ("-" eq "-") {
        print "ok - 1 $^X $__FILE__ ('あ-い' =~ /あ\Sい/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('あ-い' =~ /あ\Sい/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('あ-い' =~ /あ\Sい/).\n";
}

__END__
