# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..1\n";

# �}�b�`���Ȃ��͂��Ȃ̂Ƀ}�b�`����i�Q�j
if ("�Z��" =~ /Z/) {
    print qq<not ok - 1 "KYODAI" =~ /Z/>;
}
else {
    print qq<ok - 1 "KYODAI" =~ /Z/>;
}

__END__

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
