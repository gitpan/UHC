package Euhc;
######################################################################
#
# Euhc - Run-time routines for euhc.pl
#
# Copyright (c) 2008 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION $_warning);

$VERSION = sprintf '%d.%02d', q$Revision: 0.29 $ =~ m/(\d+)/xmsg;

use Carp qw(carp croak confess cluck verbose);
use Symbol qw(qualify_to_ref);

use constant DEBUG => 1;
local $SIG{__WARN__} = sub { cluck @_ } if DEBUG;
$_warning = $^W; # push warning, warning on
local $^W = 1;

BEGIN {
    if ($^X =~ m/jperl/xmsi) {
        croak "$0 need perl(not jperl) 5.00503 or later. (\$^X==$^X)";
    }
}

sub import() {}
sub unimport() {}

#
# UHC split
#
sub Euhc::split(;$$$) {

    if (@_ == 0) {
        return CORE::split;
    }
    elsif (@_ == 1) {
        if ($_[0] eq '') {
            if (wantarray) {
                return      m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
            }
            else {
                cluck "$0: Use of implicit split to \@_ is deprecated" if $^W;
                return @_ = m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
            }
        }
        else {
            return CORE::split $_[0];
        }
    }
    elsif (@_ == 2) {
        if ($_[0] eq '') {
            if (wantarray) {
                return      $_[1] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
            }
            else {
                cluck "$0: Use of implicit split to \@_ is deprecated" if $^W;
                return @_ = $_[1] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
            }
        }
        else {
            return CORE::split $_[0], $_[1];
        }
    }
    elsif (@_ == 3) {
        if ($_[0] eq '') {
            if ($_[2] == 0) {
                if (wantarray) {
                    return      $_[1] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
                }
                else {
                    cluck "$0: Use of implicit split to \@_ is deprecated" if $^W;
                    return @_ = $_[1] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
                }
            }
            elsif ($_[2] == 1) {
                return $_[1];
            }
            else {
                my @split = $_[1] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
                if (scalar(@split) < $_[2]) {
                    if (wantarray) {
                        return      @split, '';
                    }
                    else {
                        cluck "$0: Use of implicit split to \@_ is deprecated" if $^W;
                        return @_ = @split, '';
                    }
                }
                elsif (scalar(@split) == $_[2]) {
                    if (wantarray) {
                        return      @split;
                    }
                    else {
                        cluck "$0: Use of implicit split to \@_ is deprecated" if $^W;
                        return @_ = @split;
                    }
                }
                else {
                    if (wantarray) {
                        return      @split[0..$_[2]-2], join '', @split[$_[2]-1..$#split];
                    }
                    else {
                        cluck "$0: Use of implicit split to \@_ is deprecated" if $^W;
                        return @_ = @split[0..$_[2]-2], join '', @split[$_[2]-1..$#split];
                    }
                }
            }
        }
        else {
            return CORE::split $_[0], $_[1], $_[2];
        }
    }
}

#
# UHC transliteration (tr///)
#
sub Euhc::tr($$$;$) {

    my $searchlist      = $_[1];
    my $replacementlist = $_[2];
    my $opt             = $_[3] || '';

    my @char            = ();
    my @searchlist      = ();
    my @replacementlist = ();

    @char = $_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg;
    @searchlist = _charlist_tr($searchlist =~ m{\G(
        \\     [0-7]{2,3}          |
        \\x    [0-9A-Fa-f]{2}      |
        \\c    [\x40-\x5F]         |
        \\  (?:[\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) |
            (?:[\x81-\xFE][\x00-\xFF] | [\x00-\xFF])
    )}oxmsg);
    @replacementlist = _charlist_tr($replacementlist =~ m{\G(
        \\     [0-7]{2,3}          |
        \\x    [0-9A-Fa-f]{2}      |
        \\c    [\x40-\x5F]         |
        \\  (?:[\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) |
            (?:[\x81-\xFE][\x00-\xFF] | [\x00-\xFF])
    )}oxmsg);

    my %tr = ();
    for (my $i=0; $i <= $#searchlist; $i++) {
        if (not exists $tr{$searchlist[$i]}) {
            if (defined $replacementlist[$i] and ($replacementlist[$i] ne '')) {
                $tr{$searchlist[$i]} = $replacementlist[$i];
            }
            elsif ($opt =~ m/d/oxms) {
                $tr{$searchlist[$i]} = '';
            }
            elsif (defined $replacementlist[-1] and ($replacementlist[-1] ne '')) {
                $tr{$searchlist[$i]} = $replacementlist[-1];
            }
            else {
                $tr{$searchlist[$i]} = $searchlist[$i];
            }
        }
    }

    my $tr = 0;
    $_[0] = '';
    if ($opt =~ m/c/oxms) {
        while (defined(my $char = shift @char)) {
            if (not exists $tr{$char}) {
                if (defined $replacementlist[0]) {
                    $_[0] .= $replacementlist[0];
                }
                $tr++;
                if ($opt =~ m/s/oxms) {
                    while (@char and (not exists $tr{$char[0]})) {
                        shift @char;
                        $tr++;
                    }
                }
            }
            else {
                $_[0] .= $char;
            }
        }
    }
    else {
        while (defined(my $char = shift @char)) {
            if (exists $tr{$char}) {
                $_[0] .= $tr{$char};
                $tr++;
                if ($opt =~ m/s/oxms) {
                    while (@char and (exists $tr{$char[0]}) and ($tr{$char[0]} eq $tr{$char})) {
                        shift @char;
                        $tr++;
                    }
                }
            }
            else {
                $_[0] .= $char;
            }
        }
    }
    return $tr;
}

#
# UHC chop
#
sub Euhc::chop(;@) {

    my $chop;
    if (@_ == 0) {
        my @char = m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
        $chop = pop @char;
        $_ = join '', @char;
    }
    else {
        for my $string (@_) {
            my @char = $string =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg;
            $chop = pop @char;
            $string = join '', @char;
        }
    }
    return $chop;
}

#
# UHC index
#
sub Euhc::index($$;$) {

    my($str,$substr,$position) = @_;
    $position ||= 0;
    my $pos = 0;

    while ($pos < length($str)) {
        if (substr($str,$pos,length($substr)) eq $substr) {
            if ($pos >= $position) {
                return $pos;
            }
        }
        if (substr($str,$pos,1) =~ m/\A [\x81-\xFE] \z/oxms) {
            $pos += 2;
        }
        else {
            $pos += 1;
        }
    }
    return -1;
}

#
# UHC reverse index
#
sub Euhc::rindex($$;$) {

    my($str,$substr,$position) = @_;
    $position ||= length($str) - 1;
    my $pos = 0;
    my $rindex = -1;

    while (($pos < length($str)) and ($pos <= $position)) {
        if (substr($str,$pos,length($substr)) eq $substr) {
            $rindex = $pos;
        }
        if (substr($str,$pos,1) =~ m/\A [\x81-\xFE] \z/oxms) {
            $pos += 2;
        }
        else {
            $pos += 1;
        }
    }
    return $rindex;
}

#
# UHC lower case (lc)
#
sub Euhc::lc(;@) {

    my %lc = ();
    @lc{qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)} =
        qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);

    if (@_ == 0) {
        local $^W = 0;
        return join '', map {$lc{$_}||$_} m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg;
    }
    elsif (@_ == 1) {
        local $^W = 0;
        return join '', map {$lc{$_}||$_} ($_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg);
    }
    else {
        local $^W = 0;

        # P.95 Named Unary and File Test Operators
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.

        return join('', map {$lc{$_}||$_} ($_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg)), @_[1..$#_];
    }
}

#
# UHC upper case (uc)
#
sub Euhc::uc(;@) {

    my %uc = ();
    @uc{qw(a b c d e f g h i j k l m n o p q r s t u v w x y z)} =
        qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);

    if (@_ == 0) {
        local $^W = 0;
        return join '', map {$uc{$_}||$_} m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg;
    }
    elsif (@_ == 1) {
        local $^W = 0;
        return join '', map {$uc{$_}||$_} ($_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg);
    }
    else {
        local $^W = 0;

        # P.95 Named Unary and File Test Operators
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.

        return join('', map {$uc{$_}||$_} ($_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg)), @_[1..$#_];
    }
}

#
# UHC regexp ignore case option
#
sub Euhc::ignorecase(@) {

    my @string = @_;
    my $metachar = qr/[\@\\|[\]{]/oxms;

    # ignore case of $scalar or @array
    for my $string (@string) {

        # split regexp
        my @char = $string =~ m{\G(
            \[\^ |
                (?:[\x81-\xFE\\][\x00-\xFF] | [\x00-\xFF])
        )}oxmsg;

        # unescape character
        for (my $i=0; $i <= $#char; $i++) {
            next if not defined $char[$i];

            # open character class [...]
            if ($char[$i] eq '[') {
                my $left = $i;
                while (1) {
                    if (++$i > $#char) {
                        confess "$0: unmatched [] in regexp";
                    }
                    if ($char[$i] eq ']') {
                        my $right = $i;
                        my @charlist = _charlist_qr(@char[$left+1..$right-1], 'i');

                        # escape character
                        for my $char (@charlist) {

                            # do not use quotemeta here
                            if ($char =~ m/\A ([\x81-\xFE]) ($metachar) \z/oxms) {
                               $char = $1.'\\'.$2;
                            }
                            elsif ($char =~ m/\A [.|)] \z/oxms) {
                                $char = '\\' . $char;
                            }
                        }

                        # [...]
                        splice @char, $left, $right-$left+1, '(?:' . join('|', @charlist) . ')';

                        $i = $left;
                        last;
                    }
                }
            }

            # open character class [^...]
            elsif ($char[$i] eq '[^') {
                my $left = $i;
                while (1) {
                    if (++$i > $#char) {
                        confess "$0: unmatched [] in regexp";
                    }
                    if ($char[$i] eq ']') {
                        my $right = $i;
                        my @charlist = _charlist_not_qr(@char[$left+1..$right-1], 'i');

                        # escape character
                        for my $char (@charlist) {

                            # do not use quotemeta here
                            if ($char =~ m/\A ([\x81-\xFE]) ($metachar) \z/oxms) {
                                $char = $1 . '\\' . $2;
                            }
                            elsif ($char =~ m/\A [.|)] \z/oxms) {
                                $char = '\\' . $char;
                            }
                        }

                        # [^...]
                        splice @char, $left, $right-$left+1, '(?!' . join('|', @charlist) . ')(?:[\x81-\xFE][\x00-\xFF] | [\x00-\xFF])';

                        $i = $left;
                        last;
                    }
                }
            }

            # rewrite character class or escape character
            elsif (my $char = {
                '\D' => '(?:[\x81-\xFE][\x00-\xFF]|[^\d])',
                '\H' => '(?:[\x81-\xFE][\x00-\xFF]|[^\h])',
                '\S' => '(?:[\x81-\xFE][\x00-\xFF]|[^\s])',
                '\V' => '(?:[\x81-\xFE][\x00-\xFF]|[^\v])',
                '\W' => '(?:[\x81-\xFE][\x00-\xFF]|[^\w])',
                }->{$char[$i]}
            ) {
                $char[$i] = $char;
            }

            # /i option
            elsif ($char[$i] =~ m/\A ([A-Za-z]) \z/oxms) {
                my $c = $1;
                $char[$i] = '[' . CORE::uc($c) . CORE::lc($c) . ']';
            }
        }

        # characterize
        for (my $i=0; $i <= $#char; $i++) {
            next if not defined $char[$i];

            # join separated double octet
            if ($char[$i] =~ m/\A [\x81-\xFE] \z/oxms) {
                if ($i < $#char) {
                    $char[$i] .= $char[$i+1];
                    splice @char, $i+1, 1;
                }
            }

            # escape second octet of double octet
            if ($char[$i] =~ m/\A ([\x81-\xFE]) ($metachar) \z/oxms) {
                $char[$i] = $1 . '\\' . $2;
            }

            # quote double octet character before ? + * {
            elsif (
                ($i >= 1) and
                ($char[$i] =~ m/\A [\?\+\*\{] \z/oxms) and
                ($char[$i-1] =~ m/\A [\x81-\xFE] (?: \\?[\x00-\xFF] ) \z/oxms)
            ) {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }

        $string = join '', @char;
    }

    # make regexp string
    return @string;
}

#
# UHC open character list for tr
#
sub _charlist_tr {

    my(@char) = @_;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {
        next if not defined $char[$i];

        # escape - to ...
        if ($char[$i] eq '-') {
            if ((0 < $i) and ($i < $#char)) {
                $char[$i] = '...';
            }
        }
        elsif ($char[$i] =~ m/\A \\ ([0-7]{2,3}) \z/oxms) {
            $char[$i] = chr(oct $1);
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{2}) \z/oxms) {
            $char[$i] = chr(hex $1);
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = chr(ord($1) & 0x1F);
        }
        elsif ($char[$i] =~ m/\A (\\ [0nrtfbae]) \z/oxms) {
            $char[$i] = {
                '\0' => "\0",
                '\n' => "\n",
                '\r' => "\r",
                '\t' => "\t",
                '\f' => "\f",
                '\b' => "\x08", # \b means backspace in character class
                '\a' => "\a",
                '\e' => "\e",
            }->{$1};
        }
        elsif ($char[$i] =~ m/\A \\ ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) \z/oxms) {
            $char[$i] = $1;
        }
    }

    # join separated double octet
    for (my $i=0; $i <= $#char-1; $i++) {
        if ($char[$i] =~ m/\A [\x81-\xFE] \z/oxms) {
            $char[$i] .= $char[$i+1];
            splice @char, $i+1, 1;
        }
    }

    # open character list
    for (my $i=$#char-1; $i >= 1; ) {

        # escaped -
        if ($char[$i] eq '...') {
            my @range = ();

            # range of single octet code
            if (
                ($char[$i-1] =~ m/\A [\x00-\xFF] \z/oxms) and
                ($char[$i+1] =~ m/\A [\x00-\xFF] \z/oxms)
            ) {
                my $begin = unpack 'C', $char[$i-1];
                my $end   = unpack 'C', $char[$i+1];
                if ($begin <= $end) {
                    for my $c ($begin..$end) {
                        push @range, pack 'C', $c;
                    }
                }
                else {
                    confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
                }
            }

            # range of double octet code
            elsif (
                ($char[$i-1] =~ m/\A [\x81-\xFE] [\x00-\xFF] \z/oxms) and
                ($char[$i+1] =~ m/\A [\x81-\xFE] [\x00-\xFF] \z/oxms)
            ) {
                my($begin1,$begin2) = unpack 'CC', $char[$i-1];
                my($end1,$end2)     = unpack 'CC', $char[$i+1];
                my $begin = $begin1 * 0x100 + $begin2;
                my $end   = $end1   * 0x100 + $end2;
                if ($begin <= $end) {
                    for my $cc ($begin..$end) {
                        my $char = pack('CC', int($cc / 0x100), $cc % 0x100);
                        if ($char =~ m/\A [\x81-\xFE] [\x41-\x5A\x61-\x7A\x81-\xFE] \z/oxms) {
                            push @range, $char;
                        }
                    }
                }
                else {
                    confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
                }
            }

            # range error
            else {
                confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
            }

            splice @char, $i-1, 3, @range;
            $i -= 2;
        }
        else {
            $i -= 1;
        }
    }

    return @char;
}

#
# UHC open character list for qr
#
sub _charlist_qr {
    my $modifier = pop @_;
    my @char = @_;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {

        # escape - to ...
        if ($char[$i] eq '-') {
            if ((0 < $i) and ($i < $#char)) {
                $char[$i] = '...';
            }
        }
        elsif ($char[$i] =~ m/\A \\ ([0-7]{2,3}) \z/oxms) {
            $char[$i] = chr oct $1;
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{2}) \z/oxms) {
            $char[$i] = chr hex $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{1,2}) \} \z/oxms) {
            $char[$i] = pack 'H2', $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{3,4}) \} \z/oxms) {
            $char[$i] = pack 'H4', $1;
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = chr(ord($1) & 0x1F);
        }
        elsif ($char[$i] =~ m/\A (\\ [0nrtfbaedDhHsSvVwW]) \z/oxms) {
            $char[$i] = {
                '\0' => "\0",
                '\n' => "\n",
                '\r' => "\r",
                '\t' => "\t",
                '\f' => "\f",
                '\b' => "\x08", # \b means backspace in character class
                '\a' => "\a",
                '\e' => "\e",
                '\d' => '\d',
                '\h' => '\h',
                '\s' => '\s',
                '\v' => '\v',
                '\w' => '\w',
                '\D' => '(?:[\x81-\xFE][\x00-\xFF]|[^\d])',
                '\H' => '(?:[\x81-\xFE][\x00-\xFF]|[^\h])',
                '\S' => '(?:[\x81-\xFE][\x00-\xFF]|[^\s])',
                '\V' => '(?:[\x81-\xFE][\x00-\xFF]|[^\v])',
                '\W' => '(?:[\x81-\xFE][\x00-\xFF]|[^\w])',
            }->{$1};
        }
        elsif ($char[$i] =~ m/\A \\ ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) \z/oxms) {
            $char[$i] = $1;
        }
    }

    # open character list
    my @singleoctet = ();
    my @charlist    = ();
    if ((scalar(@char) == 1) or ((scalar(@char) >= 2) and ($char[1] ne '...'))) {
        if ($char[0] =~ m/\A [\x00-\xFF] \z/oxms) {
            push @singleoctet, $char[0];
        }
        else {
            push @charlist, $char[0];
        }
    }
    for (my $i=1; $i <= $#char-1; ) {

        # escaped -
        if ($char[$i] eq '...') {

            # range of single octet code
            if (
                ($char[$i-1] =~ m/\A [\x00-\xFF] \z/oxms) and
                ($char[$i+1] =~ m/\A [\x00-\xFF] \z/oxms)
            ) {
                my $begin = unpack 'C', $char[$i-1];
                my $end   = unpack 'C', $char[$i+1];
                if ($begin > $end) {
                    confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
                }
                else {
                    if ($modifier =~ m/i/oxms) {
                        my %range = ();
                        for my $c ($begin .. $end) {
                            $range{ord CORE::uc chr $c} = 1;
                            $range{ord CORE::lc chr $c} = 1;
                        }

                        my @lt = grep {$_ < $begin} sort {$a <=> $b} keys %range;
                        if (scalar(@lt) == 1) {
                            push @singleoctet, sprintf(q{\\x%02X},         $lt[0]);
                        }
                        elsif (scalar(@lt) >= 2) {
                            push @singleoctet, sprintf(q{\\x%02X-\\x%02X}, $lt[0], $lt[-1]);
                        }

                        push @singleoctet, sprintf(q{\\x%02X-\\x%02X},     $begin, $end);

                        my @gt = grep {$_ > $end  } sort {$a <=> $b} keys %range;
                        if (scalar(@gt) == 1) {
                            push @singleoctet, sprintf(q{\\x%02X},         $gt[0]);
                        }
                        elsif (scalar(@gt) >= 2) {
                            push @singleoctet, sprintf(q{\\x%02X-\\x%02X}, $gt[0], $gt[-1]);
                        }
                    }
                    else {
                        push @singleoctet, sprintf(q{\\x%02X-\\x%02X},     $begin, $end);
                    }
                }
            }

            # range of double octet code
            elsif (
                ($char[$i-1] =~ m/\A [\x81-\xFE] [\x00-\xFF] \z/oxms) and
                ($char[$i+1] =~ m/\A [\x81-\xFE] [\x00-\xFF] \z/oxms)
            ) {
                my($begin1,$begin2) = unpack 'CC', $char[$i-1];
                my($end1,  $end2)   = unpack 'CC', $char[$i+1];
                my $begin = $begin1 * 0x100 + $begin2;
                my $end   = $end1   * 0x100 + $end2;
                if ($begin > $end) {
                    confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
                }
                elsif ($begin1 == $end1) {
                    push @charlist, sprintf(q{\\x%02X[\\x%02X-\\x%02X]}, $begin1, $begin2, $end2);
                }
                elsif (($begin1 + 1) == $end1) {
                    push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},   $begin1, $begin2);
                    push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},   $end1,   $end2);
                }
                else {
                    my @middle = ();
                    for my $c ($begin1+1 .. $end1-1) {
                        if ((0x81 <= $c and $c <= 0x9F) or (0xE0 <= $c and $c <= 0xFC)) {
                            push @middle, $c;
                        }
                    }
                    if (scalar(@middle) == 0) {
                        push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},         $begin1,    $begin2);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},         $end1,      $end2);
                    }
                    elsif (scalar(@middle) == 1) {
                        push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},         $begin1,    $begin2);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\xFF]},           $middle[0]);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},         $end1,      $end2);
                    }
                    else {
                        push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},         $begin1,    $begin2);
                        push @charlist, sprintf(q{[\\x%02X-\\x%02X][\\x00-\\xFF]}, $middle[0], $middle[-1]);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},         $end1,      $end2);
                    }
                }
            }

            # range error
            else {
                confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
            }

            $i += 2;
        }

        # /i modifier
        elsif (($char[$i] =~ m/\A ([A-Za-z]) \z/oxms) and (($i+1 > $#char) or ($char[$i+1] ne '...'))) {
            my $c = $1;
            if ($modifier =~ m/i/oxms) {
                push @singleoctet, CORE::uc $c, CORE::lc $c;
            }
            else {
                push @singleoctet, $c;
            }
            $i += 1;
        }

        # single character
        elsif ($char[$i] =~ m/\A (?: [\x00-\xFF] | \\d | \\h | \\s | \\v | \\w )  \z/oxms) {
            push @singleoctet, $char[$i];
            $i += 1;
        }
        else {
            push @charlist, $char[$i];
            $i += 1;
        }
    }
    if ((scalar(@char) >= 2) and ($char[-2] ne '...')) {
        if ($char[-1] =~ m/\A [\x00-\xFF] \z/oxms) {
            push @singleoctet, $char[-1];
        }
        else {
            push @charlist, $char[-1];
        }
    }

    # quote metachar
    for (@singleoctet) {
        if (m/\A \n \z/oxms) {
            $_ = '\n';
        }
        elsif (m/\A \r \z/oxms) {
            $_ = '\r';
        }
        elsif (m/\A ([\x00-\x21\x7F-\xA0\xE0-\xFF]) \z/oxms) {
            $_ = sprintf(q{\\x%02X}, ord $1);
        }
        elsif (m/\A ([\x00-\xFF]) \z/oxms) {
            $_ = quotemeta $1;
        }
    }
    for (@charlist) {
        if (m/\A ([\x81-\xFE]) ([\x00-\xFF]) \z/oxms) {
            $_ = $1 . quotemeta $2;
        }
    }

    # return character list
    if (scalar(@singleoctet) == 0) {
    }
    elsif ((scalar(@singleoctet) == 1) and ($singleoctet[0] !~ m/\A .-. \z/oxms)) {
        push @charlist, $singleoctet[0];
    }
    else {
        push @charlist, '[' . join('',@singleoctet) . ']';
    }
    if (scalar(@charlist) >= 2) {
        return '(?:' . join('|', @charlist) . ')';
    }
    else {
        return @charlist;
    }
}

#
# UHC open character list for not qr
#
sub _charlist_not_qr {
    my $modifier = pop @_;
    my @char = @_;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {

        # escape - to ...
        if ($char[$i] eq '-') {
            if ((0 < $i) and ($i < $#char)) {
                $char[$i] = '...';
            }
        }
        elsif ($char[$i] =~ m/\A \\ ([0-7]{2,3}) \z/oxms) {
            $char[$i] = chr oct $1;
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{2}) \z/oxms) {
            $char[$i] = chr hex $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{1,2}) \} \z/oxms) {
            $char[$i] = pack 'H2', $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{3,4}) \} \z/oxms) {
            $char[$i] = pack 'H4', $1;
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = chr(ord($1) & 0x1F);
        }
        elsif ($char[$i] =~ m/\A (\\ [0nrtfbaedDhHsSvVwW]) \z/oxms) {
            $char[$i] = {
                '\0' => "\0",
                '\n' => "\n",
                '\r' => "\r",
                '\t' => "\t",
                '\f' => "\f",
                '\b' => "\x08", # \b means backspace in character class
                '\a' => "\a",
                '\e' => "\e",
                '\d' => '\d',
                '\h' => '\h',
                '\s' => '\s',
                '\v' => '\v',
                '\w' => '\w',
                '\D' => '(?:[\x81-\xFE][\x00-\xFF]|[^\d])',
                '\H' => '(?:[\x81-\xFE][\x00-\xFF]|[^\h])',
                '\S' => '(?:[\x81-\xFE][\x00-\xFF]|[^\s])',
                '\V' => '(?:[\x81-\xFE][\x00-\xFF]|[^\v])',
                '\W' => '(?:[\x81-\xFE][\x00-\xFF]|[^\w])',
            }->{$1};
        }
        elsif ($char[$i] =~ m/\A \\ ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) \z/oxms) {
            $char[$i] = $1;
        }
    }

    # open character list
    my @singleoctet = ();
    my @charlist    = ();
    if ((scalar(@char) == 1) or ((scalar(@char) >= 2) and ($char[1] ne '...'))) {
        if ($char[0] =~ m/\A [\x00-\xFF] \z/oxms) {
            push @singleoctet, $char[0];
        }
        else {
            push @charlist, $char[0];
        }
    }
    for (my $i=1; $i <= $#char-1; ) {

        # escaped -
        if ($char[$i] eq '...') {

            # range of single octet code
            if (
                ($char[$i-1] =~ m/\A [\x00-\xFF] \z/oxms) and
                ($char[$i+1] =~ m/\A [\x00-\xFF] \z/oxms)
            ) {
                my $begin = unpack 'C', $char[$i-1];
                my $end   = unpack 'C', $char[$i+1];
                if ($begin > $end) {
                    confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
                }
                else {
                    if ($modifier =~ m/i/oxms) {
                        my %range = ();
                        for my $c ($begin .. $end) {
                            $range{ord CORE::uc chr $c} = 1;
                            $range{ord CORE::lc chr $c} = 1;
                        }

                        my @lt = grep {$_ < $begin} sort {$a <=> $b} keys %range;
                        if (scalar(@lt) == 1) {
                            push @singleoctet, sprintf(q{\\x%02X},         $lt[0]);
                        }
                        elsif (scalar(@lt) >= 2) {
                            push @singleoctet, sprintf(q{\\x%02X-\\x%02X}, $lt[0], $lt[-1]);
                        }

                        push @singleoctet, sprintf(q{\\x%02X-\\x%02X},     $begin, $end);

                        my @gt = grep {$_ > $end  } sort {$a <=> $b} keys %range;
                        if (scalar(@gt) == 1) {
                            push @singleoctet, sprintf(q{\\x%02X},         $gt[0]);
                        }
                        elsif (scalar(@gt) >= 2) {
                            push @singleoctet, sprintf(q{\\x%02X-\\x%02X}, $gt[0], $gt[-1]);
                        }
                    }
                    else {
                        push @singleoctet, sprintf(q{[\\x%02X-\\x%02X]},   $begin, $end);
                    }
                }
            }

            # range of double octet code
            elsif (
                ($char[$i-1] =~ m/\A [\x81-\xFE] [\x00-\xFF] \z/oxms) and
                ($char[$i+1] =~ m/\A [\x81-\xFE] [\x00-\xFF] \z/oxms)
            ) {
                my($begin1,$begin2) = unpack 'CC', $char[$i-1];
                my($end1,  $end2)   = unpack 'CC', $char[$i+1];
                my $begin = $begin1 * 0x100 + $begin2;
                my $end   = $end1   * 0x100 + $end2;
                if ($begin > $end) {
                    confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
                }
                elsif ($begin1 == $end1) {
                    push @charlist, sprintf(q{\\x%02X[\\x%02X-\\x%02X]}, $begin1, $begin2, $end2);
                }
                elsif (($begin1 + 1) == $end1) {
                    push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},   $begin1, $begin2);
                    push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},   $end1,   $end2);
                }
                else {
                    my @middle = ();
                    for my $c ($begin1+1 .. $end1-1) {
                        if ((0x81 <= $c and $c <= 0x9F) or (0xE0 <= $c and $c <= 0xFC)) {
                            push @middle, $c;
                        }
                    }
                    if (scalar(@middle) == 0) {
                        push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},         $begin1,    $begin2);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},         $end1,      $end2);
                    }
                    elsif (scalar(@middle) == 1) {
                        push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},         $begin1,    $begin2);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\xFF]},           $middle[0]);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},         $end1,      $end2);
                    }
                    else {
                        push @charlist, sprintf(q{\\x%02X[\\x%02X-\\xFF]},         $begin1,    $begin2);
                        push @charlist, sprintf(q{[\\x%02X-\\x%02X][\\x00-\\xFF]}, $middle[0], $middle[-1]);
                        push @charlist, sprintf(q{\\x%02X[\\x00-\\x%02X]},         $end1,      $end2);
                    }
                }
            }

            # range error
            else {
                confess "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
            }

            $i += 2;
        }

        # /i modifier
        elsif (($char[$i] =~ m/\A ([A-Za-z]) \z/oxms) and (($i+1 > $#char) or ($char[$i+1] ne '...'))) {
            my $c = $1;
            if ($modifier =~ m/i/oxms) {
                push @singleoctet, CORE::uc $c, CORE::lc $c;
            }
            else {
                push @singleoctet, $c;
            }
            $i += 1;
        }

        # single character
        elsif ($char[$i] =~ m/\A (?: [\x00-\xFF] | \\d | \\h | \\s | \\v | \\w )  \z/oxms) {
            push @singleoctet, $char[$i];
            $i += 1;
        }
        else {
            push @charlist, $char[$i];
            $i += 1;
        }
    }
    if ((scalar(@char) >= 2) and ($char[-2] ne '...')) {
        if ($char[-1] =~ m/\A [\x00-\xFF] \z/oxms) {
            push @singleoctet, $char[-1];
        }
        else {
            push @charlist, $char[-1];
        }
    }

    # quote metachar
    for (@singleoctet) {
        if (m/\A \n \z/oxms) {
            $_ = '\n';
        }
        elsif (m/\A \r \z/oxms) {
            $_ = '\r';
        }
        elsif (m/\A ([\x00-\x21\x7F-\xA0\xE0-\xFF]) \z/oxms) {
            $_ = sprintf(q{\\x%02X}, ord $1);
        }
        elsif (m/\A ([\x00-\xFF]) \z/oxms) {
            $_ = quotemeta $_;
        }
    }
    for (@charlist) {
        if (m/\A ([\x81-\xFE]) ([\x00-\xFF]) \z/oxms) {
            $_ = $1 . quotemeta $2;
        }
    }

    # return character list
    if (scalar(@charlist) >= 1) {
        if (scalar(@singleoctet) >= 1) {
            return '(?!' . join('|', @charlist) . ')(?:[\x81-\xFE][\x00-\xFF]|[^'. join('', @singleoctet) . '])';
        }
        else {
            return '(?!' . join('|', @charlist) . ')(?:[\x81-\xFE][\x00-\xFF])';
        }
    }
    else {
        if (scalar(@singleoctet) >= 1) {
            return                                 '(?:[\x81-\xFE][\x00-\xFF]|[^'. join('', @singleoctet) . '])';
        }
        else {
            return                                 '(?:[\x81-\xFE][\x00-\xFF])';
        }
    }
}

# pop warning
$^W = $_warning;

1;

__END__

=pod

=head1 NAME

Euhc - Run-time routines for euhc.pl

=head1 SYNOPSIS

  use Euhc;

    Euhc::split(...);
    Euhc::tr(...);
    Euhc::chop(...);
    Euhc::index(...);
    Euhc::rindex(...);
    Euhc::lc(...);
    Euhc::uc(...);
    Euhc::ignorecase(...);

  # "no Euhc;" not supported

=head1 ABSTRACT

It output "use Euhc;" automatically when euhc.pl converts your script.
So you need not use this module directly.

=head1 BUGS AND LIMITATIONS

Please patches and report problems to author are welcome.

=head1 HISTORY

This Euhc module first appeared in ActivePerl Build 522 Built under
MSWin32 Compiled at Nov 2 1999 09:52:28

=head1 AUTHOR

INABA Hitoshi E<lt>ina@cpan.orgE<gt>

This project was originated by INABA Hitoshi.
For any questions, use E<lt>ina@cpan.orgE<gt> so we can share
this file.

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=head1 EXAMPLES

=over 4

=item Split string

  @split = Euhc::split(/fs/,$string,$limit);
  @split = Euhc::split(/fs/,$string);
  @split = Euhc::split(/fs/);
  @split = Euhc::split('',$string,$limit);
  @split = Euhc::split('',$string);
  @split = Euhc::split('');
  @split = Euhc::split;

=item Transliteration

  $tr = Euhc::tr($string,$searchlist,$replacementlist,$option);
  $tr = Euhc::tr($string,$searchlist,$replacementlist);

=item Chop string

  $chop = Euhc::chop(@list);
  $chop = Euhc::chop();

=item Index string

  $pos = Euhc::index($string,$substr,$position);
  $pos = Euhc::index($string,$substr);

=item Reverse index string

  $pos = Euhc::rindex($string,$substr,$position);
  $pos = Euhc::rindex($string,$substr);

=item Lower case string

  $lc = Euhc::lc($string);
  $lc = Euhc::lc();
  $lc = Euhc::lc;

=item Upper case string

  $uc = Euhc::uc($string);
  $uc = Euhc::uc();
  $uc = Euhc::uc;

=item Make ignore case string

  @ignorecase = Euhc::ignorecase(@string);

  This function is internal use to m/ /i, s/ / /i and qr/ /i.

=back

=cut

