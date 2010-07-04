# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{あ} ne "\x82\xa0";

use UHC;
print "1..1\n";

# Can't find string terminator '"' anywhere before EOF
# 「終端文字 '"'がファイルの終り EOF までに見つからなかった」
if ("対応表" eq pack('C6',0x91,0xce,0x89,0x9e,0x95,0x5c)) {
    print qq<ok - 1 "TAIOUHYO"\n>;
}
else {
    print qq<not ok - 1 "TAIOUHYO"\n>;
}

__END__

UHC.pm の処理結果が以下になることを期待している

if ("対応表\" eq pack('C6',0x91,0xce,0x89,0x9e,0x95,0x5c)) {

Shift-JISテキストを正しく扱う
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
