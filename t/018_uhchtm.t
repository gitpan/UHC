# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

# �}�b�`����͂��Ȃ̂Ƀ}�b�`���Ȃ��i�P�j
if ("�^�]�Ƌ�" =~ m'�^�]') {
    print qq<ok - 1 "UNTENMENKYO" =~ m'UNTEN'>;
}
else {
    print qq<not ok - 1 "UNTENMENKYO" =~ m'UNTEN'>;
}

__END__

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm