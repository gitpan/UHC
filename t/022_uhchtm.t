# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{あ} ne "\x82\xa0";

use UHC;
print "1..1\n";

# エラーにはならないけど文字化けする（５）
if (lc('アイウエオ') eq 'アイウエオ') {
    print "ok - 1 lc('アイウエオ') eq 'アイウエオ'\n";
}
else {
    print "not ok - 1 lc('アイウエオ') eq 'アイウエオ'\n";
}

__END__

UHC.pm の処理結果が以下になることを期待している

if (Euhc::lc('アイウエオ') eq 'アイウエオ') {

Shift-JISテキストを正しく扱う
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
