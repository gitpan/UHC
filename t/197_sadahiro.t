# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..10\n";

my $__FILE__ = __FILE__;

# �P�ꋫ�E���������^���� C<\b> ����� C<\B> �͐��������삵�܂���B

if ('ABC �ADEF GHI' =~ /\bDEF/) {
    print "not ok - 1 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\bDEF/)\n";
}
else {
    print "ok - 1 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\bDEF/)\n";
}

if ('ABC �ADEF GHI' =~ /DEF\b/) {
    print "ok - 2 $^X $__FILE__ ('ABC �ADEF GHI' =~ /DEF\\b/)\n";
}
else {
    print "not ok - 2 $^X $__FILE__ ('ABC �ADEF GHI' =~ /DEF\\b/)\n";
}

if ('ABC �ADEF GHI' =~ /\bDEF\b/) {
    print "not ok - 3 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\bDEF\\b/)\n";
}
else {
    print "ok - 3 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\bDEF\\b/)\n";
}

if ('ABC �ADEF GHI' =~ /\bABC/) {
    print "ok - 4 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\bABC/)\n";
}
else {
    print "not ok - 4 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\bABC/)\n";
}

if ('ABC �ADEF GHI' =~ /GHI\b/) {
    print "ok - 5 $^X $__FILE__ ('ABC �ADEF GHI' =~ /GHI\\b/)\n";
}
else {
    print "not ok - 5 $^X $__FILE__ ('ABC �ADEF GHI' =~ /GHI\\b/)\n";
}

if ('ABC �ADEF GHI' =~ /\B�ADEF G/) {
    print "ok - 6 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\B�ADEF G/)\n";
}
else {
    print "not ok - 6 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\B�ADEF G/)\n";
}

if ('ABC �ADEF GHI' =~ /�ADEF G\B/) {
    print "ok - 7 $^X $__FILE__ ('ABC �ADEF GHI' =~ /�ADEF G\\B/)\n";
}
else {
    print "not ok - 7 $^X $__FILE__ ('ABC �ADEF GHI' =~ /�ADEF G\\B/)\n";
}

if ('ABC �ADEF GHI' =~ /\B�ADEF G\B/) {
    print "ok - 8 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\B�ADEF G\\B/)\n";
}
else {
    print "not ok - 8 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\B�ADEF G\\B/)\n";
}

if ('ABC �ADEF GHI' =~ /\BABC/) {
    print "not ok - 9 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\BABC/)\n";
}
else {
    print "ok - 9 $^X $__FILE__ ('ABC �ADEF GHI' =~ /\\BABC/)\n";
}

if ('ABC �ADEF GHI' =~ /GHI\B/) {
    print "not ok - 10 $^X $__FILE__ ('ABC �ADEF GHI' =~ /GHI\\B/)\n";
}
else {
    print "ok - 10 $^X $__FILE__ ('ABC �ADEF GHI' =~ /GHI\\B/)\n";
}

__END__

http://search.cpan.org/dist/UHC-Regexp/
