# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

# Unrecognized character \x82
# �u�F������Ȃ����� \x82�v
if (join('',"�Ή��\", "�Ȃ�ł���������") eq join('',pack('C6',0x91,0xce,0x89,0x9e,0x95,0x5c),"�Ȃ�ł���������")) {
    print qq<ok - 1 "TAIOUHYO","NANDEMOIIKEDO"\n>;
}
else {
    print qq<not ok - 1 "TAIOUHYO","NANDEMOIIKEDO"\n>;
}

__END__

UHC.pm �̏������ʂ��ȉ��ɂȂ邱�Ƃ����҂��Ă���

if (join('',"�Ή��\\", "�Ȃ�ł���������") eq join('',pack('C6',0x91,0xce,0x89,0x9e,0x95,0x5c),"�Ȃ�ł���������")) {

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
