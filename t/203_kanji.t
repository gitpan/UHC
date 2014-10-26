# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use strict;
# use warnings;

use UHC;
print "1..1\n";

my $__FILE__ = __FILE__;

my $chcp = `chcp`;
if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms or $chcp !~ /932|949/oxms) {
    print "ok - 1 # SKIP $^X $__FILE__\n";
    exit;
}

mkdir('hoge', 0777);
open(FILE,'>hoge/�e�X�g�\�[�X.txt') || die "Can't open file: hoge/�e�X�g�\�[�X.txt\n";
print FILE "1\n";
close(FILE);

my($fileName) = glob("./hoge/*");
my $wk = "�\�[�X";
if ($fileName =~ /\Q$wk\E/) {
    print "ok - 1 $^X $__FILE__\n";
}
else {
    print "not ok - 1 $^X $__FILE__\n";
}

unlink('hoge/�e�X�g�\�[�X.txt');
rmdir('hoge');

__END__

���Ƃ��΁A./hoge�z���Ɂw�e�X�g�\�[�X.txt�x�Ƃ����t�@�C�����������Ƃ��܂��B
��x�w�\�[�X�x�������ϐ��Ɋi�[���Ă݂܂��B

�����̂R�F�R�[�h��shiftjis�A������shiftjis�A�W�����o�͂�shiftjis

���s����
C:\test>perl $0
Unmatch
./hoge/�e�X�g�\�[�X.txt

�������A��L�ł̓}�b�`���܂���B
����́A�wmy $wk = "�\�[�X";�x�Łw�\�x�̑�Q�o�C�g���G�X�P�[�v�����w\�x��
�R�[�h�ɂȂ��Ă��邩��ł��B
�����āA�w�\�x�̑�P�o�C�g�Ɓw�[�x�̑�P�o�C�g�������t���Ă��܂��̂ł��B

8/2(�y) ��[Perl�m�[�g] �V�t�gJIS�����̃t�@�C�����Ƀ}�b�`���Ă݂�
http://d.hatena.ne.jp/chaichanPaPa/20080802/1217660826
