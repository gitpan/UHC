# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..40\n";

my $__FILE__ = __FILE__;

if ("�\�A�A" =~ /^�\/) {
    print qq{ok - 1 "�\�A�A" =~ /^�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 "�\�A�A" =~ /^�\/ $^X $__FILE__\n};
}

if ("�A�\�A" !~ /^�\/) {
    print qq{ok - 2 "�A�\�A" !~ /^�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 "�A�\�A" !~ /^�\/ $^X $__FILE__\n};
}

if ("�A�A�\" =~ /�\$/) {
    print qq{ok - 3 "�A�A�\" =~ /�\\$/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 3 "�A�A�\" =~ /�\\$/ $^X $__FILE__\n};
}

if ("�A�\�A" !~ /�\$/) {
    print qq{ok - 4 "�A�\�A" !~ /�\\$/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 4 "�A�\�A" !~ /�\\$/ $^X $__FILE__\n};
}

if ("�A�\�A" =~ /(�A([�C�\�E])�A)/) {
    if ($1 eq "�A�\�A") {
        if ($2 eq "�\") {
            print qq{ok - 5 "�A�\�A" =~ /(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
        }
        else {
            print qq{not ok - 5 "�A�\�A" =~ /(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
        }
    }
    else {
        print qq{not ok - 5 "�A�\�A" =~ /(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 5 "�A�\�A" =~ /(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}

if ("�A�\�A" !~ /(�A([�C�E�G])�A)/) {
    print qq{ok - 6  "�A�\�A" !~ /(�A([�C�E�G])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}
else {
    print qq{not ok - 6 "�A�\�A" !~ /(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}

if ("�A�\�A" =~ /(�A�\|�C�\)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 7 "�A�\�A" =~ /(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 7 "�A�\�A" =~ /(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 7 "�A�\�A" =~ /(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�A" !~ /(�A�C|�C�E)/) {
    print qq{ok - 8 "�A�\�A" !~ /(�A�C|�C�E)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 8 "�A�\�A" !~ /(�A�C|�C�E)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ /(�A�\?)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 9 "�A�\�\" =~ /(�A�\?)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 9 "�A�\�\" =~ /(�A�\?)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 9 "�A�\�\" =~ /(�A�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ /(�C�\?)/) {
    print qq{ok - 10 "�A�\�\" !~ /(�C�\?)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 10 "�A�\�\" !~ /(�C�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ /(�A�\�\?)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 11 "�A�\�\" =~ /(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 11 "�A�\�\" =~ /(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 11 "�A�\�\" =~ /(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ /(�C�\�\?)/) {
    print qq{ok - 12 "�A�\�\" !~ /(�C�\�\?)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 12 "�A�\�\" !~ /(�C�\�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ /(�A�\+)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 13 "�A�\�\" =~ /(�A�\+)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 13 "�A�\�\" =~ /(�A�\+)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 13 "�A�\�\" =~ /(�A�\+)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ /(�C�\+)/) {
    print qq{ok - 14 "�A�\�\" !~ /(�C�\+)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 14 "�A�\�\" !~ /(�C�\+)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ /(�A�\*)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 15 "�A�\�\" =~ /(�A�\*)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 15 "�A�\�\" =~ /(�A�\*)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 15 "�A�\�\" =~ /(�A�\*)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ /(�C�\*)/) {
    print qq{ok - 16 "�A�\�\" !~ /(�C�\*)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 16 "�A�\�\" !~ /(�C�\*)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ /(�A.)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 17 "�A�\�\" =~ /(�A.)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 17 "�A�\�\" =~ /(�A.)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 17 "�A�\�\" =~ /(�A.)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ /(�C.)/) {
    print qq{ok - 18 "�A�\�\" !~ /(�C.)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 18 "�A�\�\" !~ /(�C.)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ /(�A.{2})/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 19 "�A�\�\" =~ /(�A.{2})/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 19 "�A�\�\" =~ /(�A.{2})/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 19 "�A�\�\" =~ /(�A.{2})/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ /(�C.{2})/) {
    print qq{ok - 20 "�A�\�\" !~ /(�C.{2})/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 20 "�A�\�\" !~ /(�C.{2})/ \$1=($1) $^X $__FILE__\n};
}

#---

if ("�\�A�A" =~ m/^�\/) {
    print qq{ok - 21 "�\�A�A" =~ m/^�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 21 "�\�A�A" =~ m/^�\/ $^X $__FILE__\n};
}

if ("�A�\�A" !~ m/^�\/) {
    print qq{ok - 22 "�A�\�A" !~ m/^�\/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 22 "�A�\�A" !~ m/^�\/ $^X $__FILE__\n};
}

if ("�A�A�\" =~ m/�\$/) {
    print qq{ok - 23 "�A�A�\" =~ m/�\\$/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 23 "�A�A�\" =~ m/�\\$/ $^X $__FILE__\n};
}

if ("�A�\�A" !~ m/�\$/) {
    print qq{ok - 24 "�A�\�A" !~ m/�\\$/ $^X $__FILE__\n};
}
else {
    print qq{not ok - 24 "�A�\�A" !~ m/�\\$/ $^X $__FILE__\n};
}

if ("�A�\�A" =~ m/(�A([�C�\�E])�A)/) {
    if ($1 eq "�A�\�A") {
        if ($2 eq "�\") {
            print qq{ok - 25 "�A�\�A" =~ m/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
        }
        else {
            print qq{not ok - 25 "�A�\�A" =~ m/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
        }
    }
    else {
        print qq{not ok - 25 "�A�\�A" =~ m/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 25 "�A�\�A" =~ m/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}

if ("�A�\�A" !~ m/(�A([�C�E�G])�A)/) {
    print qq{ok - 26 "�A�\�A" !~ m/(�A([�C�E�G])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}
else {
    print qq{not ok - 26 "�A�\�A" !~ m/(�A([�C�\�E])�A)/ \$1=($1), \$2=($2) $^X $__FILE__\n};
}

if ("�A�\�A" =~ m/(�A�\|�C�\)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 27 "�A�\�A" =~ m/(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 27 "�A�\�A" =~ m/(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 27 "�A�\�A" =~ m/(�A�\|�C�\)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�A" !~ m/(�A�C|�C�E)/) {
    print qq{ok - 28 "�A�\�A" !~ m/(�A�C|�C�E)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 28 "�A�\�A" !~ m/(�A�C|�C�E)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ m/(�A�\?)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 29 "�A�\�\" =~ m/(�A�\?)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 29 "�A�\�\" =~ m/(�A�\?)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 29 "�A�\�\" =~ m/(�A�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ m/(�C�\?)/) {
    print qq{ok - 30 "�A�\�\" !~ m/(�C�\?)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 30 "�A�\�\" !~ m/(�C�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ m/(�A�\�\?)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 31 "�A�\�\" =~ m/(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 31 "�A�\�\" =~ m/(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 31 "�A�\�\" =~ m/(�A�\�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ m/(�C�\�\?)/) {
    print qq{ok - 32 "�A�\�\" !~ m/(�C�\�\?)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 32 "�A�\�\" !~ m/(�C�\�\?)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ m/(�A�\+)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 33 "�A�\�\" =~ m/(�A�\+)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 33 "�A�\�\" =~ m/(�A�\+)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 33 "�A�\�\" =~ m/(�A�\+)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ m/(�C�\+)/) {
    print qq{ok - 34 "�A�\�\" !~ m/(�C�\+)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 34 "�A�\�\" !~ m/(�C�\+)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ m/(�A�\*)/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 35 "�A�\�\" =~ m/(�A�\*)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 35 "�A�\�\" =~ m/(�A�\*)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 35 "�A�\�\" =~ m/(�A�\*)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ m/(�C�\*)/) {
    print qq{ok - 36 "�A�\�\" !~ m/(�C�\*)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 36 "�A�\�\" !~ m/(�C�\*)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ m/(�A.)/) {
    if ($1 eq "�A�\") {
        print qq{ok - 37 "�A�\�\" =~ m/(�A.)/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 37 "�A�\�\" =~ m/(�A.)/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 37 "�A�\�\" =~ m/(�A.)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ m/(�C.)/) {
    print qq{ok - 38 "�A�\�\" !~ m/(�C.)/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 38 "�A�\�\" !~ m/(�C.)/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" =~ m/(�A.{2})/) {
    if ($1 eq "�A�\�\") {
        print qq{ok - 39 "�A�\�\" =~ m/(�A.{2})/ \$1=($1) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 39 "�A�\�\" =~ m/(�A.{2})/ \$1=($1) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 39 "�A�\�\" =~ m/(�A.{2})/ \$1=($1) $^X $__FILE__\n};
}

if ("�A�\�\" !~ m/(�C.{2})/) {
    print qq{ok - 40 "�A�\�\" !~ m/(�C.{2})/ \$1=($1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 40 "�A�\�\" !~ m/(�C.{2})/ \$1=($1) $^X $__FILE__\n};
}

__END__
