# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..10\n";

my $__FILE__ = __FILE__;

$a = "�\";
if ("$a" eq $a) {
    print qq/ok - 1 "\$a" eq \$a $^X $__FILE__\n/;
}
else {
    print qq/not ok - 1 "\$a" eq \$a $^X $__FILE__\n/;
}

$a[0] = "�\";
if ("$a[0]" eq $a[0]) {
    print qq/ok - 2 "\$a[0]" eq \$a[0] $^X $__FILE__\n/;
}
else {
    print qq/not ok - 2 "\$a[0]" eq \$a[0] $^X $__FILE__\n/;
}

$b = 1;
if ("$a[$b]" eq $a[$b]) {
    print qq/ok - 3 "\$a[\$b]" eq \$a[\$b] $^X $__FILE__\n/;
}
else {
    print qq/not ok - 3 "\$a[\$b]" eq \$a[\$b] $^X $__FILE__\n/;
}

$a{"�\"} = "�\";
if ("$a{'�\'}" eq $a{'�\'}) {
    print qq/ok - 4 "\$a{'�\'}" eq \$a{'�\'} $^X $__FILE__\n/;
}
else {
    print qq/not ok - 4 "\$a{'�\'}" eq \$a{'�\'} $^X $__FILE__\n/;
}

$b = "�\";
if ("$a{$b}" eq $a{$b}) {
    print qq/ok - 5 "\$a{\$b}" eq \$a{\$b} $^X $__FILE__\n/;
}
else {
    print qq/not ok - 5 "\$a{\$b}" eq \$a{\$b} $^X $__FILE__\n/;
}

#---

$a = "�\";
if (qq{$a} eq $a) {
    print qq/ok - 6 qq{\$a} eq \$a $^X $__FILE__\n/;
}
else {
    print qq/not ok - 6 "\$a" eq \$a $^X $__FILE__\n/;
}

$a[0] = "�\";
if (qq{$a[0]} eq $a[0]) {
    print qq/ok - 7 qq{\$a[0]} eq \$a[0] $^X $__FILE__\n/;
}
else {
    print qq/not ok - 7 "\$a[0]" eq \$a[0] $^X $__FILE__\n/;
}

$b = 1;
if (qq{$a[$b]} eq $a[$b]) {
    print qq/ok - 8 qq{\$a[\$b]} eq \$a[\$b] $^X $__FILE__\n/;
}
else {
    print qq/not ok - 8 "\$a[\$b]" eq \$a[\$b] $^X $__FILE__\n/;
}

$a{"�\"} = "�\";
if (qq{$a{'�\'}} eq $a{'�\'}) {
    print qq/ok - 9 qq{\$a{'�\'}} eq \$a{'�\'} $^X $__FILE__\n/;
}
else {
    print qq/not ok - 9 "\$a{'�\'}" eq \$a{'�\'} $^X $__FILE__\n/;
}

$b = "�\";
if (qq{$a{$b}} eq $a{$b}) {
    print qq/ok - 10 qq{\$a{\$b}} eq \$a{\$b} $^X $__FILE__\n/;
}
else {
    print qq/not ok - 10 "\$a{\$b}" eq \$a{\$b} $^X $__FILE__\n/;
}

__END__
