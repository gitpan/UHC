# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..8\n";

my $__FILE__ = __FILE__;

# /g �Ȃ��̃X�J���[�R���e�L�X�g
$success = "�A�\�A" =~ /�\/;
if ($success) {
    print qq{ok - 1 "�A�\�A" =~ /�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 "�A�\�A" =~ /�\/ $^X $__FILE__\n};
}

# /g �Ȃ��̃��X�g�R���e�L�X�g
if (($c1,$c2,$c3,$c4) = "�T�V�X�Z�\�^�`�c�e�g" =~ /^...(.)(.)(.)(.)...$/) {
    if ("($c1)($c2)($c3)($c4)" eq "(�Z)(�\)(�^)(�`)") {
        print qq{ok - 2 "�T�V�X�Z�\�^�`�c�e�g" =~ /^...(.)(.)(.)(.)...\$/ $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 2 "�T�V�X�Z�\�^�`�c�e�g" =~ /^...(.)(.)(.)(.)...\$/ ($c1)($c2)($c3)($c4) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 2 "�T�V�X�Z�\�^�`�c�e�g" =~ /^...(.)(.)(.)(.)...\$/ ($c1)($c2)($c3)($c4) $^X $__FILE__\n};
}

# /g ����̃��X�g�R���e�L�X�g
@c = "�T�V�X�Z�\�^�`�c�e�g" =~ /./g;
if (@c) {
    $c = join '', map {"($_)"} @c;
    if ($c eq "(�T)(�V)(�X)(�Z)(�\)(�^)(�`)(�c)(�e)(�g)") {
        print qq{ok - 3 \@c = "�T�V�X�Z�\�^�`�c�e�g" =~ /./g $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 3 \@c = "�T�V�X�Z�\�^�`�c�e�g" =~ /./g $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 3 \@c = "�T�V�X�Z�\�^�`�c�e�g" =~ /./g $^X $__FILE__\n};
}

# /g ����̃X�J���[�R���e�L�X�g
@c = ();
while ("�T�V�X�Z�\�^�`�c�e�g" =~ /(..)/g) {
    push @c, $1;
}
$c = join '', map {"($_)"} @c;
if ($c eq "(�T�V)(�X�Z)(�\�^)(�`�c)(�e�g)") {
    print qq{ok - 4 while ("�T�V�X�Z�\�^�`�c�e�g" =~ /(..)/g) { } $^X $__FILE__\n};
}
else {
    print qq{not ok - 4 while ("�T�V�X�Z�\�^�`�c�e�g" =~ /(..)/g) { } $^X $__FILE__\n};
}

#---

# /g �Ȃ��̃X�J���[�R���e�L�X�g
$success = "�A�\�A" =~ m/�\/;
if ($success) {
    print qq{ok - 5 "�A�\�A" =~ m/�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 5 "�A�\�A" =~ m/�\/ $^X $__FILE__\n};
}

# /g �Ȃ��̃��X�g�R���e�L�X�g
if (($c1,$c2,$c3,$c4) = "�T�V�X�Z�\�^�`�c�e�g" =~ m/^...(.)(.)(.)(.)...$/) {
    if ("($c1)($c2)($c3)($c4)" eq "(�Z)(�\)(�^)(�`)") {
        print qq{ok - 6 "�T�V�X�Z�\�^�`�c�e�g" =~ m/^...(.)(.)(.)(.)...\$/ $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 6 "�T�V�X�Z�\�^�`�c�e�g" =~ m/^...(.)(.)(.)(.)...\$/ $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 6 "�T�V�X�Z�\�^�`�c�e�g" =~ m/^...(.)(.)(.)(.)...\$/ $^X $__FILE__\n};
}

# /g ����̃��X�g�R���e�L�X�g
@c = "�T�V�X�Z�\�^�`�c�e�g" =~ m/./g;
if (@c) {
    $c = join '', map {"($_)"} @c;
    if ($c eq "(�T)(�V)(�X)(�Z)(�\)(�^)(�`)(�c)(�e)(�g)") {
        print qq{ok - 7 \@c = "�T�V�X�Z�\�^�`�c�e�g" =~ m/./g $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 7 \@c = "�T�V�X�Z�\�^�`�c�e�g" =~ m/./g $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 7 \@c = "�T�V�X�Z�\�^�`�c�e�g" =~ m/./g $^X $__FILE__\n};
}

# /g ����̃X�J���[�R���e�L�X�g
@c = ();
while ("�T�V�X�Z�\�^�`�c�e�g" =~ m/(..)/g) {
    push @c, $1;
}
$c = join '', map {"($_)"} @c;
if ($c eq "(�T�V)(�X�Z)(�\�^)(�`�c)(�e�g)") {
    print qq{ok - 8 while ("�T�V�X�Z�\�^�`�c�e�g" =~ m/(..)/g) { } $^X $__FILE__\n};
}
else {
    print qq{not ok - 8 while ("�T�V�X�Z�\�^�`�c�e�g" =~ m/(..)/g) { } $^X $__FILE__\n};
}

__END__
