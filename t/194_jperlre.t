# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..6\n";

my $__FILE__ = __FILE__;

if ('�AABC DEF GHI' =~ /\bABC/) {
    print "not ok - 1 $^X $__FILE__ ('�AABC DEF GHI' =~ /\\bABC/)\n";
}
else {
    print "ok - 1 $^X $__FILE__ ('�AABC DEF GHI' =~ /\\bABC/)\n";
}

if ('�AABC DEF GHI' =~ /\bDEF/) {
    print "ok - 2 $^X $__FILE__ ('�AABC DEF GHI' =~ /\\bDEF/)\n";
}
else {
    print "not ok - 2 $^X $__FILE__ ('�AABC DEF GHI' =~ /\\bDEF/)\n";
}

if ('�AABC DEF GHI' =~ /\bGHI/) {
    print "ok - 3 $^X $__FILE__ ('�AABC DEF GHI' =~ /\\bGHI/)\n";
}
else {
    print "not ok - 3 $^X $__FILE__ ('�AABC DEF GHI' =~ /\\bGHI/)\n";
}

if ('�AABC DEF GHI' =~ /ABC\b/) {
    print "ok - 4 $^X $__FILE__ ('�AABC DEF GHI' =~ /ABC\\b/)\n";
}
else {
    print "not ok - 4 $^X $__FILE__ ('�AABC DEF GHI' =~ /ABC\\b/)\n";
}

if ('�AABC DEF GHI' =~ /DEF\b/) {
    print "ok - 5 $^X $__FILE__ ('�AABC DEF GHI' =~ /DEF\\b/)\n";
}
else {
    print "not ok - 5 $^X $__FILE__ ('�AABC DEF GHI' =~ /DEF\\b/)\n";
}

if ('�AABC DEF GHI' =~ /GHI\b/) {
    print "ok - 6 $^X $__FILE__ ('�AABC DEF GHI' =~ /GHI\\b/)\n";
}
else {
    print "not ok - 6 $^X $__FILE__ ('�AABC DEF GHI' =~ /GHI\\b/)\n";
}

__END__
