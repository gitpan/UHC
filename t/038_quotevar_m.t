# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..10\n";

my $__FILE__ = __FILE__;

$a = "�\";
if ($a =~ /^\Q$a\E$/) {
    print qq#ok - 1 \$a =~ /^\\Q\$a\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 1 \$a =~ /^\\Q\$a\\E\$/ $^X $__FILE__\n#;
}

$a[0] = "�\";
if ($a[0] =~ /^\Q$a[0]\E$/) {
    print qq#ok - 2 \$a[0] =~ /^\\Q\$a[0]\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 2 \$a[0] =~ /^\\Q\$a[0]\\E\$/ $^X $__FILE__\n#;
}

$b = 1;
$a[1] = '';
if ($a[$b] =~ /^\Q$a[$b]\E$/) {
    print qq#ok - 3 \$a[\$b] =~ /^\\Q\$a[\$b]\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 3 \$a[\$b] =~ /^\\Q\$a[\$b]\\E\$/ $^X $__FILE__\n#;
}

$a{"�\"} = "�\";
if ($a{'�\'} =~ /^\Q$a{'�\'}\E$/) {
    print qq#ok - 4 \$a{'�\'} =~ /^\\Q\$a{'�\'}\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 4 \$a{'�\'} =~ /^\\Q\$a{'�\'}\\E\$/ $^X $__FILE__\n#;
}

$b = "�\";
if ($a{$b} =~ /^\Q$a{$b}\E$/) {
    print qq#ok - 5 \$a{\$b} =~ /^\\Q\$a{\$b}\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 5 \$a{\$b} =~ /^\\Q\$a{\$b}\\E\$/ $^X $__FILE__\n#;
}

#---

$a = "�\";
if ($a =~ m/^\Q$a\E$/) {
    print qq#ok - 6 \$a =~ m/^\\Q\$a\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 6 \$a =~ m/^\\Q\$a\\E\$/ $^X $__FILE__\n#;
}

$a[0] = "�\";
if ($a[0] =~ m/^\Q$a[0]\E$/) {
    print qq#ok - 7 \$a[0] =~ m/^\\Q\$a[0]\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 7 \$a[0] =~ m/^\\Q\$a[0]\\E\$/ $^X $__FILE__\n#;
}

$b = 1;
if ($a[$b] =~ m/^\Q$a[$b]\E$/) {
    print qq#ok - 8 \$a[\$b] =~ m/^\\Q\$a[\$b]\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 8 \$a[\$b] =~ m/^\\Q\$a[\$b]\\E\$/ $^X $__FILE__\n#;
}

$a{"�\"} = "�\";
if ($a{'�\'} =~ m/^\Q$a{'�\'}\E$/) {
    print qq#ok - 9 \$a{'�\'} =~ m/^\\Q\$a{'�\'}\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 9 \$a{'�\'} =~ m/^\\Q\$a{'�\'}\\E\$/ $^X $__FILE__\n#;
}

$b = "�\";
if ($a{$b} =~ m/^\Q$a{$b}\E$/) {
    print qq#ok - 10 \$a{\$b} =~ m/^\\Q\$a{\$b}\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 10 \$a{\$b} =~ m/^\\Q\$a{\$b}\\E\$/ $^X $__FILE__\n#;
}

__END__
