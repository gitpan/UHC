# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..5\n";

my $__FILE__ = __FILE__;

$a = "�\";
if ($a =~ qr/^\Q$a\E$/) {
    print qq#ok - 1 \$a =~ qr/^\\Q\$a\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 1 \$a =~ qr/^\\Q\$a\\E\$/ $^X $__FILE__\n#;
}

$a[0] = "�\";
if ($a[0] =~ qr/^\Q$a[0]\E$/) {
    print qq#ok - 2 \$a[0] =~ qr/^\\Q\$a[0]\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 2 \$a[0] =~ qr/^\\Q\$a[0]\\E\$/ $^X $__FILE__\n#;
}

$b = 1;
$a[1] = '';
if ($a[$b] =~ qr/^\Q$a[$b]\E$/) {
    print qq#ok - 3 \$a[\$b] =~ qr/^\\Q\$a[\$b]\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 3 \$a[\$b] =~ qr/^\\Q\$a[\$b]\\E\$/ $^X $__FILE__\n#;
}

$a{"�\"} = "�\";
if ($a{'�\'} =~ qr/^\Q$a{'�\'}\E$/) {
    print qq#ok - 4 \$a{'�\'} =~ qr/^\\Q\$a{'�\'}\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 4 \$a{'�\'} =~ qr/^\\Q\$a{'�\'}\\E\$/ $^X $__FILE__\n#;
}

$b = "�\";
if ($a{$b} =~ qr/^\Q$a{$b}\E$/) {
    print qq#ok - 5 \$a{\$b} =~ qr/^\\Q\$a{\$b}\\E\$/ $^X $__FILE__\n#;
}
else {
    print qq#not ok - 5 \$a{\$b} =~ qr/^\\Q\$a{\$b}\\E\$/ $^X $__FILE__\n#;
}

__END__
