# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

# ��ʓI�ȃf�B���N�g�������� chr(0x5C) �ŏI���f�B���N�g�����̃t�@�C���e�X�g�̌��ʂ���v���邱�Ƃ̊m�F

my $__FILE__ = __FILE__;

use UHC;
print "1..23\n";

if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    for my $tno (1..23) {
        print "ok - $tno # SKIP $^X $0\n";
    }
    exit;
}

mkdir('directory',0777);
mkdir('D�@�\',0777);

if (((-r 'directory') ne '') == ((-r 'D�@�\') ne '')) {
    print "ok - 1 -r 'directory' == -r 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 1 -r 'directory' == -r 'D�@�\' $^X $__FILE__\n";
}

if (((-w 'directory') ne '') == ((-w 'D�@�\') ne '')) {
    print "ok - 2 -w 'directory' == -w 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 2 -w 'directory' == -w 'D�@�\' $^X $__FILE__\n";
}

if (((-x 'directory') ne '') == ((-x 'D�@�\') ne '')) {
    print "ok - 3 -x 'directory' == -x 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 3 -x 'directory' == -x 'D�@�\' $^X $__FILE__\n";
}

if (((-o 'directory') ne '') == ((-o 'D�@�\') ne '')) {
    print "ok - 4 -o 'directory' == -o 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 4 -o 'directory' == -o 'D�@�\' $^X $__FILE__\n";
}

if (((-R 'directory') ne '') == ((-R 'D�@�\') ne '')) {
    print "ok - 5 -R 'directory' == -R 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 5 -R 'directory' == -R 'D�@�\' $^X $__FILE__\n";
}

if (((-W 'directory') ne '') == ((-W 'D�@�\') ne '')) {
    print "ok - 6 -W 'directory' == -W 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 6 -W 'directory' == -W 'D�@�\' $^X $__FILE__\n";
}

if (((-X 'directory') ne '') == ((-X 'D�@�\') ne '')) {
    print "ok - 7 -X 'directory' == -X 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 7 -X 'directory' == -X 'D�@�\' $^X $__FILE__\n";
}

if (((-O 'directory') ne '') == ((-O 'D�@�\') ne '')) {
    print "ok - 8 -O 'directory' == -O 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 8 -O 'directory' == -O 'D�@�\' $^X $__FILE__\n";
}

if (((-e 'directory') ne '') == ((-e 'D�@�\') ne '')) {
    print "ok - 9 -e 'directory' == -e 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 9 -e 'directory' == -e 'D�@�\' $^X $__FILE__\n";
}

if (((-z 'directory') ne '') == ((-z 'D�@�\') ne '')) {
    print "ok - 10 -z 'directory' == -z 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 10 -z 'directory' == -z 'D�@�\' $^X $__FILE__\n";
}

if (((-s 'directory') ne '') == ((-s 'D�@�\') ne '')) {
    print "ok - 11 -s 'directory' == -s 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 11 -s 'directory' == -s 'D�@�\' $^X $__FILE__\n";
}

if (((-f 'directory') ne '') == ((-f 'D�@�\') ne '')) {
    print "ok - 12 -f 'directory' == -f 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 12 -f 'directory' == -f 'D�@�\' $^X $__FILE__\n";
}

if (((-d 'directory') ne '') == ((-d 'D�@�\') ne '')) {
    print "ok - 13 -d 'directory' == -d 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 13 -d 'directory' == -d 'D�@�\' $^X $__FILE__\n";
}

if (((-p 'directory') ne '') == ((-p 'D�@�\') ne '')) {
    print "ok - 14 -p 'directory' == -p 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 14 -p 'directory' == -p 'D�@�\' $^X $__FILE__\n";
}

if (((-S 'directory') ne '') == ((-S 'D�@�\') ne '')) {
    print "ok - 15 -S 'directory' == -S 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 15 -S 'directory' == -S 'D�@�\' $^X $__FILE__\n";
}

if (((-b 'directory') ne '') == ((-b 'D�@�\') ne '')) {
    print "ok - 16 -b 'directory' == -b 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 16 -b 'directory' == -b 'D�@�\' $^X $__FILE__\n";
}

if (((-c 'directory') ne '') == ((-c 'D�@�\') ne '')) {
    print "ok - 17 -c 'directory' == -c 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 17 -c 'directory' == -c 'D�@�\' $^X $__FILE__\n";
}

if (((-u 'directory') ne '') == ((-u 'D�@�\') ne '')) {
    print "ok - 18 -u 'directory' == -u 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 18 -u 'directory' == -u 'D�@�\' $^X $__FILE__\n";
}

if (((-g 'directory') ne '') == ((-g 'D�@�\') ne '')) {
    print "ok - 19 -g 'directory' == -g 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 19 -g 'directory' == -g 'D�@�\' $^X $__FILE__\n";
}

if (((-k 'directory') ne '') == ((-k 'D�@�\') ne '')) {
    print "ok - 20 -k 'directory' == -k 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 20 -k 'directory' == -k 'D�@�\' $^X $__FILE__\n";
}

if (((-M 'directory') ne '') == ((-M 'D�@�\') ne '')) {
    print "ok - 21 -M 'directory' == -M 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 21 -M 'directory' == -M 'D�@�\' $^X $__FILE__\n";
}

if (((-A 'directory') ne '') == ((-A 'D�@�\') ne '')) {
    print "ok - 22 -A 'directory' == -A 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 22 -A 'directory' == -A 'D�@�\' $^X $__FILE__\n";
}

if (((-C 'directory') ne '') == ((-C 'D�@�\') ne '')) {
    print "ok - 23 -C 'directory' == -C 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 23 -C 'directory' == -C 'D�@�\' $^X $__FILE__\n";
}

rmdir('directory');
rmdir('D�@�\');

__END__
