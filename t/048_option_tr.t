# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..3\n";

my $__FILE__ = __FILE__;

# tr///c
$a = "�J�L�N�P�R�T�V�X�Z�\�^�`�c�e�g";
if ($a =~ tr/�T�V�X�Z�\/����������/c) {
    print qq{ok - 1 \$a =~ tr/�T�V�X�Z�\/����������/c ($a) $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 \$a =~ tr/�T�V�X�Z�\/����������/c ($a) $^X $__FILE__\n};
}

# tr///d
$a = "�J�L�N�P�R�T�V�X�Z�\�^�`�c�e�g";
if ($a =~ tr/�T�V�X�Z�\//d) {
    print qq{ok - 2 \$a =~ tr/�T�V�X�Z�\//d ($a) $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 \$a =~ tr/�T�V�X�Z�\//d ($a) $^X $__FILE__\n};
}

# tr///s
$a = "�J�L�N�P�R�T�V�X�Z�\�^�`�c�e�g";
if ($a =~ tr/�T�V�X�Z�\/�i/s) {
    print qq{ok - 3 \$a =~ tr/�T�V�X�Z�\/�i/s ($a) $^X $__FILE__\n};
}
else {
    print qq{not ok - 3 \$a =~ tr/�T�V�X�Z�\/�i/s ($a) $^X $__FILE__\n};
}

__END__
