# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..4\n";

my $__FILE__ = __FILE__;

# ���^���� C<\U>, C<\L>, C<\Q>, C<\E> ����ѕϐ��W�J�͍l������Ă���܂���B
# �K�v�Ȃ�AC<""> (or C<qq//>) ���Z�q���g���Ă��������B

if ('ABC' =~ /\Uabc\E/) {
    print "ok - 1 $^X $__FILE__ ('ABC' =~ /\\Uabc\\E/)\n";
}
else {
    print "not ok - 1 $^X $__FILE__ ('ABC' =~ /\\Uabc\\E/)\n";
}

if ('def' =~ /\LDEF\E/) {
    print "ok - 2 $^X $__FILE__ ('def' =~ /\\LDEF\\E/)\n";
}
else {
    print "not ok - 2 $^X $__FILE__ ('def' =~ /\\LDEF\\E/)\n";
}

if ('({[' =~ /\Q({\[\E/) {
    print "ok - 3 $^X $__FILE__ ('({[' =~ /\\Q({\\[\\E/)\n";
}
else {
    print "not ok - 3 $^X $__FILE__ ('({[' =~ /\\Q({\\[\\E/)\n";
}

my $var = 'GHI';
if ('GHI' =~ /GHI/) {
    print "ok - 4 $^X $__FILE__ ('GHI' =~ /GHI/)\n";
}
else {
    print "not ok - 4 $^X $__FILE__ ('GHI' =~ /GHI/)\n";
}

__END__

http://search.cpan.org/dist/UHC-Regexp/
