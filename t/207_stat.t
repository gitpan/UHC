# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

my $__FILE__ = __FILE__;

use UHC;
print "1..2\n";

my $chcp = `chcp`;
if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms or $chcp !~ /932|949/oxms) {
    print "ok - 1 # SKIP $^X $__FILE__\n";
    print "ok - 2 # SKIP $^X $__FILE__\n";
    exit;
}

open(FILE,'>F�@�\') || die "Can't open file: F�@�\\n";
print FILE "1\n";
close(FILE);
mkdir('D�@�\', 0777);
open(FILE,'>D�@�\/a.txt') || die "Can't open file: D�@�\/a.txt\n";
print FILE "1\n";
close(FILE);
open(FILE,'>D�@�\/b.txt') || die "Can't open file: D�@�\/b.txt\n";
print FILE "1\n";
close(FILE);
open(FILE,'>D�@�\/c.txt') || die "Can't open file: D�@�\/c.txt\n";
print FILE "1\n";
close(FILE);
open(FILE,'>D�@�\/F�@�\') || die "Can't open file: D�@�\/F�@�\\n";
print FILE "1\n";
close(FILE);
mkdir('D�@�\/D�@�\', 0777);

$_ = 'F�@�\';
if (@_ = stat($_)) {
    print "ok - 1 $^X $__FILE__\n";
}
else{
    print "not ok - 1 $^X $__FILE__\n";
}

$_ = 'D�@�\';
if (@_ = stat($_)) {
    print "not ok - 2 $^X $__FILE__\n";
}
else{
    print "ok - 2 $^X $__FILE__\n";
}

unlink('F�@�\');
rmdir('D�@�\/D�@�\');
unlink('D�@�\/a.txt');
unlink('D�@�\/b.txt');
unlink('D�@�\/c.txt');
unlink('D�@�\/F�@�\');
rmdir('D�@�\');

__END__

Perl����/Windows�ł̃t�@�C���p�X
http://digit.que.ne.jp/work/wiki.cgi?Perl%E3%83%A1%E3%83%A2%2FWindows%E3%81%A7%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%91%E3%82%B9

�t�@�C���֘A�R�}���h�̓���m�F
�u�@�\�v�Ƃ����������ϐ�$_�ɓ���Astat($_)�Ƃ��Ă��Ԃ�l���Ȃ� 

