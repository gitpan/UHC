# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..20\n";

my $__FILE__ = __FILE__;

if ("�\�A�A" =~ qr/^�\/) {
    print qq{ok - 1 "�\�A�A" =~ qr/^�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 "�\�A�A" =~ qr/^�\/ $^X $__FILE__\n};
}

if ("�A�\�A" !~ qr/^�\/) {
    print qq{ok - 2 "�A�\�A" !~ qr/^�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 "�A�\�A" !~ qr/^�\/ $^X $__FILE__\n};
}

if ("�A�A�\" =~ qr/�\$/) {
    print qq{ok - 3 "�A�A�\" =~ qr/�\\$/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 3 "�A�A�\" =~ qr/�\\$/ $^X $__FILE__\n};
}

if ("�A�\�A" !~ qr/�\$/) {
    print qq{ok - 4 "�A�\�A" !~ qr/�\\$/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 4 "�A�\�A" !~ qr/�\\$/ $^X $__FILE__\n};
}

if ("�A�\�A" =~ qr/(�A([�C�\�E])�A)/) {
    if ($1 eq "�A�\�A") {
        if ($2 eq "�\") {
            print qq{ok - 5 "�A�\�A" =~ qr/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
        }
        else {
            print qq{not ok - 5 "�A�\�A" =~ qr/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
        }
    }
    else {
        print qq{not ok - 5 "�A�\�A" =~ qr/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 5 "�A�\�A" =~ qr/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}

if ("�A�\�A" !~ qr/(�A([�C�E�G])�A)/) {
    print qq{ok - 6 "�A�\�A" !~ qr/(�A([�C�E�G])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}
else {
    print qq{not ok - 6 "�A�\�A" !~ qr/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}

if ("�A�\�A" =~ qr/(�A�\|�C�\)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 7 "�A�\�A" =~ qr/(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 7 "�A�\�A" =~ qr/(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 7 "�A�\�A" =~ qr/(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�A" !~ qr/(�A�C|�C�E)/) {
    print qq{ok - 8 "�A�\�A" !~ qr/(�A�C|�C�E)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 8 "�A�\�A" !~ qr/(�A�C|�C�E)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ qr/(�A�\?)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 9 "�A�\�\" =~ qr/(�A�\?)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 9 "�A�\�\" =~ qr/(�A�\?)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 9 "�A�\�\" =~ qr/(�A�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ qr/(�C�\?)/) {
    print qq{ok - 10 "�A�\�\" !~ qr/(�C�\?)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 10 "�A�\�\" !~ qr/(�C�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ qr/(�A�\�\?)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 11 "�A�\�\" =~ qr/(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 11 "�A�\�\" =~ qr/(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 11 "�A�\�\" =~ qr/(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ qr/(�C�\�\?)/) {
    print qq{ok - 12 "�A�\�\" !~ qr/(�C�\�\?)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 12 "�A�\�\" !~ qr/(�C�\�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ qr/(�A�\+)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 13 "�A�\�\" =~ qr/(�A�\+)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 13 "�A�\�\" =~ qr/(�A�\+)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 13 "�A�\�\" =~ qr/(�A�\+)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ qr/(�C�\+)/) {
    print qq{ok - 14 "�A�\�\" !~ qr/(�C�\+)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 14 "�A�\�\" !~ qr/(�C�\+)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ qr/(�A�\*)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 15 "�A�\�\" =~ qr/(�A�\*)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 15 "�A�\�\" =~ qr/(�A�\*)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 15 "�A�\�\" =~ qr/(�A�\*)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ qr/(�C�\*)/) {
    print qq{ok - 16 "�A�\�\" !~ qr/(�C�\*)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 16 "�A�\�\" !~ qr/(�C�\*)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ qr/(�A.)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 17 "�A�\�\" =~ qr/(�A.)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 17 "�A�\�\" =~ qr/(�A.)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 17 "�A�\�\" =~ qr/(�A.)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ qr/(�C.)/) {
    print qq{ok - 18 "�A�\�\" !~ qr/(�C.)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 18 "�A�\�\" !~ qr/(�C.)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ qr/(�A.{2})/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 19 "�A�\�\" =~ qr/(�A.{2})/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 19 "�A�\�\" =~ qr/(�A.{2})/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 19 "�A�\�\" =~ qr/(�A.{2})/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ qr/(�C.{2})/) {
    print qq{ok - 20 "�A�\�\" !~ qr/(�C.{2})/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 20 "�A�\�\" !~ qr/(�C.{2})/ \$1=($1) $^X $__FILE__\n};
}

__END__
