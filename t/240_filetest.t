# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

# ��ʓI�ȃf�B���N�g�������� chr(0x5C) �ŏI���f�B���N�g�����̃t�@�C���e�X�g�̌��ʂ���v���邱�Ƃ̊m�F

my $__FILE__ = __FILE__;

use UHC;
print "1..52\n";

if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    for my $tno (1..52) {
        print "ok - $tno # SKIP $^X $0\n";
    }
    exit;
}

mkdir('directory',0777);
mkdir('D�@�\',0777);

opendir(DIR1,'directory');
opendir(DIR2,'D�@�\');

if (((-r 'directory') ne '') == ((-r 'D�@�\') ne '')) {
    print "ok - 1 -r 'directory' == -r 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 1 -r 'directory' == -r 'D�@�\' $^X $__FILE__\n";
}

if (((-r DIR1) ne '') == ((-r DIR2) ne '')) {
    print "ok - 2 -r DIR1 == -r DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 2 -r DIR1 == -r DIR2 $^X $__FILE__\n";
}

if (((-w 'directory') ne '') == ((-w 'D�@�\') ne '')) {
    print "ok - 3 -w 'directory' == -w 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 3 -w 'directory' == -w 'D�@�\' $^X $__FILE__\n";
}

if (((-w DIR1) ne '') == ((-w DIR2) ne '')) {
    print "ok - 4 -w DIR1 == -w DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 4 -w DIR1 == -w DIR2 $^X $__FILE__\n";
}

if (((-x 'directory') ne '') == ((-x 'D�@�\') ne '')) {
    print "ok - 5 -x 'directory' == -x 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 5 -x 'directory' == -x 'D�@�\' $^X $__FILE__\n";
}

if (((-x DIR1) ne '') == ((-x DIR2) ne '')) {
    print "ok - 6 -x DIR1 == -x DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 6 -x DIR1 == -x DIR2 $^X $__FILE__\n";
}

if (((-o 'directory') ne '') == ((-o 'D�@�\') ne '')) {
    print "ok - 7 -o 'directory' == -o 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 7 -o 'directory' == -o 'D�@�\' $^X $__FILE__\n";
}

if (((-o DIR1) ne '') == ((-o DIR2) ne '')) {
    print "ok - 8 -o DIR1 == -o DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 8 -o DIR1 == -o DIR2 $^X $__FILE__\n";
}

if (((-R 'directory') ne '') == ((-R 'D�@�\') ne '')) {
    print "ok - 9 -R 'directory' == -R 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 9 -R 'directory' == -R 'D�@�\' $^X $__FILE__\n";
}

if (((-R DIR1) ne '') == ((-R DIR2) ne '')) {
    print "ok - 10 -R DIR1 == -R DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 10 -R DIR1 == -R DIR2 $^X $__FILE__\n";
}

if (((-W 'directory') ne '') == ((-W 'D�@�\') ne '')) {
    print "ok - 11 -W 'directory' == -W 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 11 -W 'directory' == -W 'D�@�\' $^X $__FILE__\n";
}

if (((-W DIR1) ne '') == ((-W DIR2) ne '')) {
    print "ok - 12 -W DIR1 == -W DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 12 -W DIR1 == -W DIR2 $^X $__FILE__\n";
}

if (((-X 'directory') ne '') == ((-X 'D�@�\') ne '')) {
    print "ok - 13 -X 'directory' == -X 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 13 -X 'directory' == -X 'D�@�\' $^X $__FILE__\n";
}

if (((-X DIR1) ne '') == ((-X DIR2) ne '')) {
    print "ok - 14 -X DIR1 == -X DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 14 -X DIR1 == -X DIR2 $^X $__FILE__\n";
}

if (((-O 'directory') ne '') == ((-O 'D�@�\') ne '')) {
    print "ok - 15 -O 'directory' == -O 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 15 -O 'directory' == -O 'D�@�\' $^X $__FILE__\n";
}

if (((-O DIR1) ne '') == ((-O DIR2) ne '')) {
    print "ok - 16 -O DIR1 == -O DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 16 -O DIR1 == -O DIR2 $^X $__FILE__\n";
}

if (((-e 'directory') ne '') == ((-e 'D�@�\') ne '')) {
    print "ok - 17 -e 'directory' == -e 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 17 -e 'directory' == -e 'D�@�\' $^X $__FILE__\n";
}

if (((-e DIR1) ne '') == ((-e DIR2) ne '')) {
    print "ok - 18 -e DIR1 == -e DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 18 -e DIR1 == -e DIR2 $^X $__FILE__\n";
}

if (((-z 'directory') ne '') == ((-z 'D�@�\') ne '')) {
    print "ok - 19 -z 'directory' == -z 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 19 -z 'directory' == -z 'D�@�\' $^X $__FILE__\n";
}

if (((-z DIR1) ne '') == ((-z DIR2) ne '')) {
    print "ok - 20 -z DIR1 == -z DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 20 -z DIR1 == -z DIR2 $^X $__FILE__\n";
}

if (((-s 'directory') ne '') == ((-s 'D�@�\') ne '')) {
    print "ok - 21 -s 'directory' == -s 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 21 -s 'directory' == -s 'D�@�\' $^X $__FILE__\n";
}

if (((-s DIR1) ne '') == ((-s DIR2) ne '')) {
    print "ok - 22 -s DIR1 == -s DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 22 -s DIR1 == -s DIR2 $^X $__FILE__\n";
}

if (((-f 'directory') ne '') == ((-f 'D�@�\') ne '')) {
    print "ok - 23 -f 'directory' == -f 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 23 -f 'directory' == -f 'D�@�\' $^X $__FILE__\n";
}

if (((-f DIR1) ne '') == ((-f DIR2) ne '')) {
    print "ok - 24 -f DIR1 == -f DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 24 -f DIR1 == -f DIR2 $^X $__FILE__\n";
}

if (((-d 'directory') ne '') == ((-d 'D�@�\') ne '')) {
    print "ok - 25 -d 'directory' == -d 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 25 -d 'directory' == -d 'D�@�\' $^X $__FILE__\n";
}

if (((-d DIR1) ne '') == ((-d DIR2) ne '')) {
    print "ok - 26 -d DIR1 == -d DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 26 -d DIR1 == -d DIR2 $^X $__FILE__\n";
}

if (((-p 'directory') ne '') == ((-p 'D�@�\') ne '')) {
    print "ok - 27 -p 'directory' == -p 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 27 -p 'directory' == -p 'D�@�\' $^X $__FILE__\n";
}

if (((-p DIR1) ne '') == ((-p DIR2) ne '')) {
    print "ok - 28 -p DIR1 == -p DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 28 -p DIR1 == -p DIR2 $^X $__FILE__\n";
}

if (((-S 'directory') ne '') == ((-S 'D�@�\') ne '')) {
    print "ok - 29 -S 'directory' == -S 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 29 -S 'directory' == -S 'D�@�\' $^X $__FILE__\n";
}

if (((-S DIR1) ne '') == ((-S DIR2) ne '')) {
    print "ok - 30 -S DIR1 == -S DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 30 -S DIR1 == -S DIR2 $^X $__FILE__\n";
}

if (((-b 'directory') ne '') == ((-b 'D�@�\') ne '')) {
    print "ok - 31 -b 'directory' == -b 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 31 -b 'directory' == -b 'D�@�\' $^X $__FILE__\n";
}

if (((-b DIR1) ne '') == ((-b DIR2) ne '')) {
    print "ok - 32 -b DIR1 == -b DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 32 -b DIR1 == -b DIR2 $^X $__FILE__\n";
}

if (((-c 'directory') ne '') == ((-c 'D�@�\') ne '')) {
    print "ok - 33 -c 'directory' == -c 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 33 -c 'directory' == -c 'D�@�\' $^X $__FILE__\n";
}

if (((-c DIR1) ne '') == ((-c DIR2) ne '')) {
    print "ok - 34 -c DIR1 == -c DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 34 -c DIR1 == -c DIR2 $^X $__FILE__\n";
}

if (((-t 'directory') ne '') == ((-t 'D�@�\') ne '')) {
    print "ok - 35 -t 'directory' == -t 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 35 -t 'directory' == -t 'D�@�\' $^X $__FILE__\n";
}

if (((-t DIR1) ne '') == ((-t DIR2) ne '')) {
    print "ok - 36 -t DIR1 == -t DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 36 -t DIR1 == -t DIR2 $^X $__FILE__\n";
}

if (((-u 'directory') ne '') == ((-u 'D�@�\') ne '')) {
    print "ok - 37 -u 'directory' == -u 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 37 -u 'directory' == -u 'D�@�\' $^X $__FILE__\n";
}

if (((-u DIR1) ne '') == ((-u DIR2) ne '')) {
    print "ok - 38 -u DIR1 == -u DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 38 -u DIR1 == -u DIR2 $^X $__FILE__\n";
}

if (((-g 'directory') ne '') == ((-g 'D�@�\') ne '')) {
    print "ok - 39 -g 'directory' == -g 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 39 -g 'directory' == -g 'D�@�\' $^X $__FILE__\n";
}

if (((-g DIR1) ne '') == ((-g DIR2) ne '')) {
    print "ok - 40 -g DIR1 == -g DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 40 -g DIR1 == -g DIR2 $^X $__FILE__\n";
}

if (((-k 'directory') ne '') == ((-k 'D�@�\') ne '')) {
    print "ok - 41 -k 'directory' == -k 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 41 -k 'directory' == -k 'D�@�\' $^X $__FILE__\n";
}

if (((-k DIR1) ne '') == ((-k DIR2) ne '')) {
    print "ok - 42 -k DIR1 == -k DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 42 -k DIR1 == -k DIR2 $^X $__FILE__\n";
}

if (((-T 'directory') ne '') == ((-T 'D�@�\') ne '')) {
    print "ok - 43 -T 'directory' == -T 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 43 -T 'directory' == -T 'D�@�\' $^X $__FILE__\n";
}

if (((-T DIR1) ne '') == ((-T DIR2) ne '')) {
    print "ok - 44 -T DIR1 == -T DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 44 -T DIR1 == -T DIR2 $^X $__FILE__\n";
}

if (((-B 'directory') ne '') == ((-B 'D�@�\') ne '')) {
    print "ok - 45 -B 'directory' == -B 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 45 -B 'directory' == -B 'D�@�\' $^X $__FILE__\n";
}

if (((-B DIR1) ne '') == ((-B DIR2) ne '')) {
    print "ok - 46 -B DIR1 == -B DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 46 -B DIR1 == -B DIR2 $^X $__FILE__\n";
}

if (((-M 'directory') ne '') == ((-M 'D�@�\') ne '')) {
    print "ok - 47 -M 'directory' == -M 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 47 -M 'directory' == -M 'D�@�\' $^X $__FILE__\n";
}

if (((-M DIR1) ne '') == ((-M DIR2) ne '')) {
    print "ok - 48 -M DIR1 == -M DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 48 -M DIR1 == -M DIR2 $^X $__FILE__\n";
}

if (((-A 'directory') ne '') == ((-A 'D�@�\') ne '')) {
    print "ok - 49 -A 'directory' == -A 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 49 -A 'directory' == -A 'D�@�\' $^X $__FILE__\n";
}

if (((-A DIR1) ne '') == ((-A DIR2) ne '')) {
    print "ok - 50 -A DIR1 == -A DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 50 -A DIR1 == -A DIR2 $^X $__FILE__\n";
}

if (((-C 'directory') ne '') == ((-C 'D�@�\') ne '')) {
    print "ok - 51 -C 'directory' == -C 'D�@�\' $^X $__FILE__\n";
}
else {
    print "not ok - 51 -C 'directory' == -C 'D�@�\' $^X $__FILE__\n";
}

if (((-C DIR1) ne '') == ((-C DIR2) ne '')) {
    print "ok - 52 -C DIR1 == -C DIR2 $^X $__FILE__\n";
}
else {
    print "not ok - 52 -C DIR1 == -C DIR2 $^X $__FILE__\n";
}

closedir(DIR1,'directory');
closedir(DIR2,'D�@�\');
rmdir('directory');
rmdir('D�@�\');

__END__
