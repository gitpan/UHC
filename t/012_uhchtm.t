# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

# Bareword found where operator expected
# �u���̌ꂪ���Z�q�������Ăق����ʒu�Ɍ��������v
if ("<img alt=\"�Ή��\\" height=115 width=150>" eq sprintf('<img alt="%s" height=115 width=150>',pack('C6',0x91,0xce,0x89,0x9e,0x95,0x5c))) {
    print qq<ok - 1 "<img alt="TAIOUHYO" height=115 width=150>"\n>;
}
else {
    print qq<not ok - 1 "<img alt="TAIOUHYO" height=115 width=150>"\n>;
}

__END__

UHC.pm �̏������ʂ��ȉ��ɂȂ邱�Ƃ����҂��Ă���

if ("<img alt=\"�Ή��\\\" height=115 width=150>" eq sprintf('<img alt="%s" height=115 width=150>',pack('C6',0x91,0xce,0x89,0x9e,0x95,0x5c))) {

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
