# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..10\n";

my $__FILE__ = __FILE__;

my $tno = 1;

# m//i
if ("�A�C�E�G�I" !~ /a/i) {
    print qq{ok - $tno "�A�C�E�G�I" !~ /a/i $^X $__FILE__\n}
}
else {
    print qq{not ok - $tno "�A�C�E�G�I" !~ /a/i $^X $__FILE__\n}
}
$tno++;

# m//m
if ("�T�V�X�Z\n�\�^�`�c�e�g" =~ m/^�\/m) {
    print qq{ok - $tno "�T�V�X�Z\\n�\�^�`�c�e�g" =~ m/^�\/m $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�T�V�X�Z\\n�\�^�`�c�e�g" =~ m/^�\/m $^X $__FILE__\n};
}
$tno++;

if ("�T�V�X�Z�\\n�^�`�c�e�g" =~ m/�\$/m) {
    print qq{ok - $tno "�T�V�X�Z�\\\n�^�`�c�e�g" =~ m/�\\$/m $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�T�V�X�Z�\\\n�^�`�c�e�g" =~ m/�\\$/m $^X $__FILE__\n};
}
$tno++;

if ("�T�V�X�Z\n�\\n�^�`�c�e�g" =~ m/^�\$/m) {
    print qq{ok - $tno "�T�V�X�Z\\n�\\\n�^�`�c�e�g" =~ m/^�\\$/m $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�T�V�X�Z\\n�\\\n�^�`�c�e�g" =~ m/^�\\$/m $^X $__FILE__\n};
}
$tno++;

# m//o
@re = ("�\","�C");
for $i (1 .. 2) {
    $re = shift @re;
    if ("�\�A�A" =~ m/\Q$re\E/o) {
        print qq{ok - $tno "�\�A�A" =~ m/\\Q\$re\\E/o $^X $__FILE__\n};
    }
    else {
        if ($] =~ /^5\.006/) {
            print qq{ok - $tno # SKIP "�\�A�A" =~ m/\\Q\$re\\E/o $^X $__FILE__\n};
        }
        else {
            print qq{not ok - $tno "�\�A�A" =~ m/\\Q\$re\\E/o $^X $__FILE__\n};
        }
    }
    $tno++;
}

@re = ("�C","�\");
for $i (1 .. 2) {
    $re = shift @re;
    if ("�\�A�A" !~ m/\Q$re\E/o) {
        print qq{ok - $tno "�\�A�A" !~ m/\\Q\$re\\E/o $^X $__FILE__\n};
    }
    else {
        if ($] =~ /^5\.006/) {
            print qq{ok - $tno # SKIP "�\�A�A" !~ m/\\Q\$re\\E/o $^X $__FILE__\n};
        }
        else {
            print qq{not ok - $tno "�\�A�A" !~ m/\\Q\$re\\E/o $^X $__FILE__\n};
        }
    }
    $tno++;
}

# m//s
if ("�A\n�\" =~ m/�A.�\/s) {
    print qq{ok - $tno "�A\\n�\" =~ m/�A.�\/s $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�A\\n�\" =~ m/�A.�\/s $^X $__FILE__\n};
}
$tno++;

# m//x
if ("�A�\�\" =~ m/  �\  /x) {
    print qq{ok - $tno "�A�\�\" =~ m/  �\  /x $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�A�\�\" =~ m/  �\  /x $^X $__FILE__\n};
}
$tno++;

__END__
