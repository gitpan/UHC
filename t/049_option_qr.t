# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..8\n";

my $__FILE__ = __FILE__;

my $tno = 1;

# qr//i
if ("�A�C�E�G�I" !~ /a/i) {
    print qq{ok - $tno "�A�C�E�G�I" !~ /a/i $^X $__FILE__\n}
}
else {
    print qq{not ok - $tno "�A�C�E�G�I" !~ /a/i $^X $__FILE__\n}
}
$tno++;

# qr//m
if ("�T�V�X�Z\n�\�^�`�c�e�g" =~ qr/^�\/m) {
    print qq{ok - $tno "�T�V�X�Z\\n�\�^�`�c�e�g" =~ qr/^�\/m $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�T�V�X�Z\\n�\�^�`�c�e�g" =~ qr/^�\/m $^X $__FILE__\n};
}
$tno++;

# qr//o
@re = ("�\","�C");
for $i (1 .. 2) {
    $re = shift @re;
    if ("�\�A�A" =~ qr/\Q$re\E/o) {
        print qq{ok - $tno "�\�A�A" =~ qr/\\Q\$re\\E/o $^X $__FILE__\n};
    }
    else {
        if ($] =~ /^5\.006/) {
            print qq{ok - $tno # SKIP "�\�A�A" =~ qr/\\Q\$re\\E/o $^X $__FILE__\n};
        }
        else {
            print qq{not ok - $tno "�\�A�A" =~ qr/\\Q\$re\\E/o $^X $__FILE__\n};
        }
    }
    $tno++;
}

@re = ("�C","�\");
for $i (1 .. 2) {
    $re = shift @re;
    if ("�\�A�A" !~ qr/\Q$re\E/o) {
        print qq{ok - $tno "�\�A�A" !~ qr/\\Q\$re\\E/o $^X $__FILE__\n};
    }
    else {
        if ($] =~ /^5\.006/) {
            print qq{ok - $tno # SKIP "�\�A�A" !~ qr/\\Q\$re\\E/o $^X $__FILE__\n};
        }
        else {
            print qq{not ok - $tno "�\�A�A" !~ qr/\\Q\$re\\E/o $^X $__FILE__\n};
        }
    }
    $tno++;
}

# qr//s
if ("�A\n�\" =~ qr/�A.�\/s) {
    print qq{ok - $tno "�A\\n�\" =~ qr/�A.�\/s $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�A\\n�\" =~ qr/�A.�\/s $^X $__FILE__\n};
}
$tno++;

# qr//x
if ("�A�\�\" =~ qr/  �\  /x) {
    print qq{ok - $tno "�A�\�\" =~ qr/  �\  /x $^X $__FILE__\n};
}
else {
    print qq{not ok - $tno "�A�\�\" =~ qr/  �\  /x $^X $__FILE__\n};
}
$tno++;

__END__
