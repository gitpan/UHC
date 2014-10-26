# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

# ���� 2 �ɑΉ������֐� binmode() �̃e�X�g

my $__FILE__ = __FILE__;

use UHC;
print "1..10\n";

# ���� 0 ��

eval q{ binmode(); };
if ($@) {
    print "ok - 1 eval q{ binmode(); } $^X $__FILE__\n";
}
else {
    print "not ok - 1 eval q{ binmode(); } $^X $__FILE__\n";
}

# ���� 1 �� �x�A���[�h

open(FILE,'>binmode.txt');
binmode(FILE);
print FILE "\n" x 2;
close(FILE);

if (-s 'binmode.txt' == 2) {
    print "ok - 2 binmode(FILE); $^X $__FILE__\n";
}
else {
    print "not ok - 2 binmode(FILE); $^X $__FILE__\n";
}

# ���� 1 �� �t�@�C���n���h�����i�[���ꂽ�ϐ�

open(my $fh,'>binmode.txt');
binmode($fh);
print $fh "\n" x 3;
close($fh);

if (-s 'binmode.txt' == 3) {
    print "ok - 3 binmode(\$fh); $^X $__FILE__\n";
}
else {
    print "not ok - 3 binmode(\$fh); $^X $__FILE__\n";
}

# ���� 2 �� :raw, �x�A���[�h

open(FILE,'>binmode.txt');
binmode(FILE,':raw');
print FILE "\n" x 4;
close(FILE);

if (-s 'binmode.txt' == 4) {
    print "ok - 4 binmode(FILE,':raw'); $^X $__FILE__\n";
}
else {
    print "not ok - 4 binmode(FILE,':raw'); $^X $__FILE__\n";
}

# ���� 2 �� :raw, �t�@�C���n���h�����i�[���ꂽ�ϐ�

open(my $fh2,'>binmode.txt');
binmode($fh2,':raw');
print $fh2 "\n" x 5;
close($fh2);

if (-s 'binmode.txt' == 5) {
    print "ok - 5 binmode(\$fh,':raw'); $^X $__FILE__\n";
}
else {
    print "not ok - 5 binmode(\$fh,':raw'); $^X $__FILE__\n";
}

# ���� 2 �� :crlf, �x�A���[�h

if ($] =~ /^5\.006/) {
    print "ok - 6 # SKIP binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
}
else {
    open(FILE,'>binmode.txt');
    binmode(FILE,':crlf');
    print FILE "\n" x 6;
    close(FILE);

    if (-s 'binmode.txt' == 6*2) {
        print "ok - 6 binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
    }
    else {
        print "not ok - 6 binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
    }
}

# ���� 2 �� :crlf, �t�@�C���n���h�����i�[���ꂽ�ϐ�

if ($] =~ /^5\.006/) {
    print "ok - 7 # SKIP binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
}
else {
    open(my $fh,'>binmode.txt');
    binmode($fh,':crlf');
    print $fh "\n" x 7;
    close($fh);

    if (-s 'binmode.txt' == 7*2) {
        print "ok - 7 binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
    }
    else {
        print "not ok - 7 binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
    }
}

# ���� 2 �� :unknownmode, �x�A���[�h

if ($] =~ /^5\.006/) {
    print "ok - 8 # SKIP eval q{ binmode(FILE,':unknownmode'); } $^X $__FILE__\n";
}
else {
    eval q{
        open(FILE,'>binmode.txt');
        binmode(FILE,':unknownmode');
        print FILE "\n" x 8;
        close(FILE);
    };
    if (not $@) {
        print "ok - 8 eval q{ binmode(FILE,':unknownmode'); } $^X $__FILE__\n";
    }
    else {
        print "not ok - 8 eval q{ binmode(FILE,':unknownmode'); } $^X $__FILE__\n";
    }
}

# ���� 2 �� :unknownmode, �t�@�C���n���h�����i�[���ꂽ�ϐ�

if ($] =~ /^5\.006/) {
    print "ok - 9 # SKIP eval q{ binmode(\$fh,':unknownmode'); } $^X $__FILE__\n";
}
else {
    eval q{
        open(my $fh,'>binmode.txt');
        binmode($fh,':unknownmode');
        print $fh "\n" x 9;
        close($fh);
    };
    if (not $@) {
        print "ok - 9 eval q{ binmode(\$fh,':unknownmode'); } $^X $__FILE__\n";
    }
    else {
        print "not ok - 9 eval q{ binmode(\$fh,':unknownmode'); } $^X $__FILE__\n";
    }
}

# ���� 3 �� :raw, �x�A���[�h, ���̑�

eval q{
    open(FILE,'>binmode.txt');
    binmode(FILE,':raw',1);
    print FILE "\n" x 10;
    close(FILE);
};
if ($@) {
    print "ok - 10 eval q{ binmode(FILE,':raw',1); } $^X $__FILE__\n";
}
else {
    print "not ok - 10 eval q{ binmode(FILE,':raw',1); } $^X $__FILE__\n";
}

END {
    unlink 'binmode.txt';
}

__END__

