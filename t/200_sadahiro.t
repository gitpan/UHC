# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..2\n";

my $__FILE__ = __FILE__;

# �T���߂ȗʎw��q���܂ރp�^�[�� (�Ⴆ�� C<.??>��C<\d*?>) �́A
# �󕶎���ƃ}�b�`���邱�Ƃ��ł��܂����AC<jsplit()> �̃p�^�[���Ƃ��ėp�����ꍇ�A
# �g�ݍ��݂� C<split()> ����\�z����铮��ƈقȂ邱�Ƃ�����܂��B

if (join('', map {"($_)"} split(/.??/, '�A�C�E')) eq '(�A)(�C)(�E)') {
    print "ok - 1 $^X $__FILE__ (join('', map {qq{($_)}} split(/.??/, '�A�C�E')) eq '(�A)(�C)(�E)')\n";
}
else {
    print "not ok - 1 $^X $__FILE__ (join('', map {qq{($_)}} split(/.??/, '�A�C�E')) eq '(�A)(�C)(�E)')\n";
}

if (join('', map {"($_)"} split(/\d*?/, '�A�C�E')) eq '(�A)(�C)(�E)') {
    print "ok - 2 $^X $__FILE__ (join('', map {qq{($_)}} split(/\\d*?/, '�A�C�E')) eq '(�A)(�C)(�E)')\n";
}
else {
    print "not ok - 2 $^X $__FILE__ (join('', map {qq{($_)}} split(/\\d*?/, '�A�C�E')) eq '(�A)(�C)(�E)')\n";
}

__END__

http://search.cpan.org/dist/UHC-Regexp/
