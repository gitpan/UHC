# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

# In string, @dog now must be written as \@dog (Perl 5.6.0�܂�)
# �u������̒��ł́A@dog�͍���\@dog�Ə����Ȃ���΂Ȃ�Ȃ��v
if ("���@dog" eq pack('C7',0x8c,0xa2,0x81,0x40,0x64,0x6f,0x67)) {
    print qq<ok - 1 "INU dog"\n>;
}
else {
    print qq<not ok - 1 "INU dog"\n>;
}

__END__

UHC.pm �̏������ʂ��ȉ��ɂȂ邱�Ƃ����҂��Ă���

if ("���\@dog" eq pack('C7',0x8c,0xa2,0x81,0x40,0x64,0x6f,0x67)) {

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
