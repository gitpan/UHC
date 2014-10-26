# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..2\n";

my $__FILE__ = __FILE__;

if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    print "ok - 1 # SKIP $^X $__FILE__\n";
    print "ok - 2 # SKIP $^X $__FILE__\n";
    exit;
}

$| = 1;

mkdir('dt',0777);
mkdir('dt/alphabet',0777);
mkdir('dt/���{��',0777);

open(FILE,">dt/alphabet/alpha.txt") || die "Can't open file: dt/alphabet/alpha.txt\n";
print FILE <<'END';
aaa
bbb
ccc
ddd
eee
END
close(FILE);

open(FILE,">dt/���{��/alpha.txt") || die "Can't open file: dt/���{��/alpha.txt\n";
print FILE <<'END';
aaa
bbb
ccc
ddd
eee
END
close(FILE);

open(FILE,">dt/alphabet/sjis.txt") || die "Can't open file: dt/alphabet/sjis.txt\n";
print FILE <<'END';
aaa
������
bbb
������
ccc
������
ddd
�\
eee
END
close(FILE);

open(FILE,">dt/���{��/sjis.txt") || die "Can't open file: dt/���{��/sjis.txt\n";
print FILE <<'END';
aaa
������
bbb
������
ccc
������
ddd
�\
eee
END
close(FILE);

my $aaa = <<'END';
!!dt/alphabet!!
!!dt/alphabet/alpha.txt!!
dt/alphabet/alpha.txt:aaa
!!dt/alphabet/sjis.txt!!
dt/alphabet/sjis.txt:aaa
!!dt/���{��!!
!!dt/���{��/alpha.txt!!
dt/���{��/alpha.txt:aaa
!!dt/���{��/sjis.txt!!
dt/���{��/sjis.txt:aaa
END

my $hyou = <<'END';
!!dt/alphabet!!
!!dt/alphabet/alpha.txt!!
!!dt/alphabet/sjis.txt!!
dt/alphabet/sjis.txt:�\
!!dt/���{��!!
!!dt/���{��/alpha.txt!!
!!dt/���{��/sjis.txt!!
dt/���{��/sjis.txt:�\
END

open(FILE,">01grepdir.pl") || die "Can't open file: 01grepdir.pl\n";
print FILE <DATA>;
close(FILE);

$_ = `$^X 01grepdir.pl aaa dt 2>NUL`;
sleep 1;
if ($_ eq $aaa) {
    print "ok - 1 $^X $__FILE__ aaa dt \n";
}
else {
    print "not ok - 1 $^X $__FILE__ aaa dt \n";
    print "($_)\n";
    print "($aaa)\n";
}

$_ = `$^X 01grepdir.pl �\ dt 2>NUL`;
sleep 1;
if ($_ eq $hyou) {
    print "ok - 2 $^X $__FILE__ �\ dt\n";
}
else {
    print "not ok - 2 $^X $__FILE__ �\ dt\n";
    print "($_)\n";
    print "($hyou)\n";
}
sleep 1;

unlink('01grepdir.pl');
unlink('01grepdir.pl.e');

unlink('dt/alphabet/alpha.txt');
unlink('dt/alphabet/sjis.txt');
unlink('dt/���{��/alpha.txt');
unlink('dt/���{��/sjis.txt');
rmdir('dt/alphabet');
rmdir('dt/���{��');
rmdir('dt');

__END__
# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;

local $^W = 1;

if (@ARGV < 2) {
    die <<END;
���s���@:

perl $0 aaa dt
perl $0 �\  dt
END
}

&grepdir(@ARGV);

exit 0;

sub grepdir ($$) {
    my($pat,$dir) = @_;
    my($node);

    opendir(D,$dir);
    my @nodes = grep (!/^\./, readdir(D));
    closedir(D);

    foreach $node (@nodes) {
        my $path="$dir/$node";
        print "!!$path!!\n";
        if ( -f $path ) {
            grepfile($pat,$path);
        }
        elsif( -d $path) {
            &grepdir($pat,$path);
        }
        else {
            print STDERR "skip:$path\n";
        }
    }
}

sub grepfile ($$) {
    my($pat,$file) = @_;
    open(IN,$file) or die "Error:open($file):$!\n";
    while (<IN>) {
        chomp;

# �C���ӏ�1
#       print "$file:$_\n" if (/$pat/);
        print "$file:$_\n" if (/\Q$pat\E/);
    }
}

__END__

Windows��Perl 5.8/5.10���g����������Ȃ�
http://www.aritia.org/hizumi/perl/perlwin.html

�́u�����ŏЉ���X�N���v�g�̃T���v���v�� grepdir.pl �𗘗p���Ă��܂��B

��: ���K�\�����w�肵�āC�w�肵���f�B���N�g���z���̃t�@�C��������o���R�[�h�������Ă�B

�R�}���h�`��: perl grepdir.pl {�p�^�[��} {�f�B���N�g��}

���̂悤�ȃe�X�g����p�ӂ���B

C:\TEMP\TP> tree /F dt
�t�H���_ �p�X�̈ꗗ: �{�����[�� vvvvv_vvvvvvvvv
�{�����[�� �V���A���ԍ��� vvvv-ssss �ł�
C:\TEMP\TP\DT
����alphabet
��      alpha.txt
��      sjis.txt
��
�������{��
       alpha.txt
       sjis.txt

����� perl �ɂĎ��s������ƁC���̂悤�ɂȂ�B

C:\TEMP\TP\DT>perl grepdir.pl aaa dt
!!dt/alphabet!!
!!dt/alphabet/alpha.txt!!
dt/alphabet/alpha.txt:aaa
!!dt/alphabet/sjis.txt!!
dt/alphabet/sjis.txt:aaa
!!dt/���{��!!
!!dt/���{��/alpha.txt!!
dt/���{��/alpha.txt:aaa
!!dt/���{��/sjis.txt!!
dt/���{��/sjis.txt:aaa

C:\TEMP\TP\DT>perl grepdir.pl �\ dt
!!dt/alphabet!!
!!dt/alphabet/alpha.txt!!
!!dt/alphabet/sjis.txt!!
dt/alphabet/sjis.txt:�\
!!dt/���{��!!
!!dt/���{��/alpha.txt!!
!!dt/���{��/sjis.txt!!
dt/���{��/sjis.txt:�\

�����Ȃ���΂Ȃ�Ȃ��Ƃ���́C�ȉ��̂悤�ȂƂ���ɂȂ�B

�C���ӏ�1
  ���K�\�����ɕϐ����L�q���A�ϐ��Ɋi�[����Ă�����e���̂��̂Ƀ}�b�`
  ���������̂ł���� \Q ... \E �ň͂ޕK�v������B

    ----------------------------------------------
    print "$file:$_\n" if (/$pat/);
    ----------------------------------------------
                �� ��������
    ----------------------------------------------
    print "$file:$_\n" if (/\Q$pat\E/);
    ----------------------------------------------

�ȏ�
