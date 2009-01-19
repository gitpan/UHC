package Euhc;
######################################################################
#
# Euhc - Run-time routines for UHC.pm
#
# Copyright (c) 2008, 2009 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION $_warning);

$VERSION = sprintf '%d.%02d', q$Revision: 0.30 $ =~ m/(\d+)/xmsg;

use Carp qw(carp croak confess cluck verbose);
use Fcntl;
use Symbol;

local $SIG{__WARN__} = sub { cluck @_ };
$_warning = $^W; # push warning, warning on
local $^W = 1;

BEGIN {
    if ($^X =~ m/ jperl /oxmsi) {
        croak "$0 need perl(not jperl) 5.00503 or later. (\$^X==$^X)";
    }
}

sub import() {}
sub unimport() {}

#
# Prototypes of subroutines
#
sub Euhc::split(;$$$);
sub Euhc::tr($$$;$);
sub Euhc::chop(@);
sub Euhc::index($$;$);
sub Euhc::rindex($$;$);
sub Euhc::lc($);
sub Euhc::lc_();
sub Euhc::uc($);
sub Euhc::uc_();
sub Euhc::shift_matched_var();
sub Euhc::ignorecase(@);
sub Euhc::chr($);
sub Euhc::chr_();
sub Euhc::ord($);
sub Euhc::ord_();
sub Euhc::reverse(@);
sub Euhc::r(;*@);
sub Euhc::w(;*@);
sub Euhc::x(;*@);
sub Euhc::o(;*@);
sub Euhc::R(;*@);
sub Euhc::W(;*@);
sub Euhc::X(;*@);
sub Euhc::O(;*@);
sub Euhc::e(;*@);
sub Euhc::z(;*@);
sub Euhc::s(;*@);
sub Euhc::f(;*@);
sub Euhc::d(;*@);
sub Euhc::l(;*@);
sub Euhc::p(;*@);
sub Euhc::S(;*@);
sub Euhc::b(;*@);
sub Euhc::c(;*@);
sub Euhc::t(;*@);
sub Euhc::u(;*@);
sub Euhc::g(;*@);
sub Euhc::k(;*@);
sub Euhc::T(;*@);
sub Euhc::B(;*@);
sub Euhc::M(;*@);
sub Euhc::A(;*@);
sub Euhc::C(;*@);
sub Euhc::r_();
sub Euhc::w_();
sub Euhc::x_();
sub Euhc::o_();
sub Euhc::R_();
sub Euhc::W_();
sub Euhc::X_();
sub Euhc::O_();
sub Euhc::e_();
sub Euhc::z_();
sub Euhc::s_();
sub Euhc::f_();
sub Euhc::d_();
sub Euhc::l_();
sub Euhc::p_();
sub Euhc::S_();
sub Euhc::b_();
sub Euhc::c_();
sub Euhc::t_();
sub Euhc::u_();
sub Euhc::g_();
sub Euhc::k_();
sub Euhc::T_();
sub Euhc::B_();
sub Euhc::M_();
sub Euhc::A_();
sub Euhc::C_();
sub Euhc::glob($);
sub Euhc::glob_();
sub Euhc::lstat(*);
sub Euhc::lstat_();
sub Euhc::opendir(*$);
sub Euhc::stat(*);
sub Euhc::stat_();
sub Euhc::unlink(@);

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
    my $modifier        = $_[3] || '';

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
            elsif ($modifier =~ m/d/oxms) {
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
    if ($modifier =~ m/c/oxms) {
        while (defined(my $char = shift @char)) {
            if (not exists $tr{$char}) {
                if (defined $replacementlist[0]) {
                    $_[0] .= $replacementlist[0];
                }
                $tr++;
                if ($modifier =~ m/s/oxms) {
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
                if ($modifier =~ m/s/oxms) {
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
sub Euhc::chop(@) {

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
# UHC lower case (with parameter)
#
sub Euhc::lc($) {

    my %lc = ();
    @lc{qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)} =
        qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);

    local $^W = 0;

    return join('', map {$lc{$_}||$_} $_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg);
}

#
# UHC lower case (without parameter)
#
sub Euhc::lc_() {

    my %lc = ();
    @lc{qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)} =
        qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);

    local $^W = 0;

    return join('', map {$lc{$_}||$_} m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF])/oxmsg);
}

#
# UHC upper case (with parameter)
#
sub Euhc::uc($) {

    my %uc = ();
    @uc{qw(a b c d e f g h i j k l m n o p q r s t u v w x y z)} =
        qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);

    local $^W = 0;

    return join('', map {$uc{$_}||$_} $_[0] =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg);
}

#
# UHC upper case (without parameter)
#
sub Euhc::uc_() {

    my %uc = ();
    @uc{qw(a b c d e f g h i j k l m n o p q r s t u v w x y z)} =
        qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);

    local $^W = 0;

    return join('', map {$uc{$_}||$_} m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg);
}

#
# UHC shift matched variables
#
sub Euhc::shift_matched_var() {

    # $1 --> return
    # $2 --> $1
    # $3 --> $2
    # $4 --> $3
    my $dollar1 = $1;

    for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
        eval sprintf '*%d = *%d', $digit, $digit+1;
    }

    return $dollar1;
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
            $char[$i] = CORE::chr(oct $1);
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{2}) \z/oxms) {
            $char[$i] = CORE::chr(hex $1);
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = CORE::chr(CORE::ord($1) & 0x1F);
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
            $char[$i] = CORE::chr oct $1;
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{2}) \z/oxms) {
            $char[$i] = CORE::chr hex $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{1,2}) \} \z/oxms) {
            $char[$i] = pack 'H2', $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{3,4}) \} \z/oxms) {
            $char[$i] = pack 'H4', $1;
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = CORE::chr(CORE::ord($1) & 0x1F);
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
                            $range{CORE::ord CORE::uc CORE::chr $c} = 1;
                            $range{CORE::ord CORE::lc CORE::chr $c} = 1;
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
            $_ = sprintf(q{\\x%02X}, CORE::ord $1);
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
    elsif (scalar(@singleoctet) >= 2) {
        push @charlist, '[' . join('',@singleoctet) . ']';
    }
    elsif ($singleoctet[0] =~ m/ . - . /oxms) {
        push @charlist, '[' . $singleoctet[0] . ']';
    }
    else {
        push @charlist, $singleoctet[0];
    }
    if (scalar(@charlist) >= 2) {
        return '(?:' . join('|', @charlist) . ')';
    }
    else {
        return $charlist[0];
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
            $char[$i] = CORE::chr oct $1;
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{2}) \z/oxms) {
            $char[$i] = CORE::chr hex $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{1,2}) \} \z/oxms) {
            $char[$i] = pack 'H2', $1;
        }
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]{3,4}) \} \z/oxms) {
            $char[$i] = pack 'H4', $1;
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = CORE::chr(CORE::ord($1) & 0x1F);
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
                            $range{CORE::ord CORE::uc CORE::chr $c} = 1;
                            $range{CORE::ord CORE::lc CORE::chr $c} = 1;
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
            $_ = sprintf(q{\\x%02X}, CORE::ord $1);
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

#
# UHC order to character (with parameter)
#
sub Euhc::chr($) {
    if ($_[0] > 0xFF) {
        return pack 'CC', int($_[0] / 0x100), $_[0] % 0x100;
    }
    else {
        return CORE::chr $_[0];
    }
}

#
# UHC order to character (without parameter)
#
sub Euhc::chr_() {
    if ($_ > 0xFF) {
        return pack 'CC', int($_ / 0x100), $_ % 0x100;
    }
    else {
        return CORE::chr $_;
    }
}

#
# UHC character to order (with parameter)
#
sub Euhc::ord($) {
    if ($_[0] =~ m/\A [\x81-\xFE] /oxms) {
        my($ord1,$ord2) = unpack 'CC', $_[0];
        return $ord1 * 0x100 + $ord2;
    }
    else {
        return CORE::ord $_[0];
    }
}

#
# UHC character to order (without parameter)
#
sub Euhc::ord_() {
    if (m/\A [\x81-\xFE] /oxms) {
        my($ord1,$ord2) = unpack 'CC', $_;
        return $ord1 * 0x100 + $ord2;
    }
    else {
        return CORE::ord $_;
    }
}

#
# UHC reverse
#
sub Euhc::reverse(@) {

    if (wantarray) {
        return CORE::reverse @_;
    }
    else {
        return join '', CORE::reverse(join('',@_) =~ m/\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg);
    }
}

#
# UHC file test -r expr
#
sub Euhc::r(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -r (Euhc::r)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-r _,@_) : -r _;
    }

    # P.908 Symbol
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.
    # (and so on)

    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-r $fh,@_) : -r $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-r _,@_) : -r _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-r _,@_) : -r _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $r = -r $fh;
                close $fh;
                return wantarray ? ($r,@_) : $r;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -w expr
#
sub Euhc::w(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -w (Euhc::w)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-w _,@_) : -w _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-w $fh,@_) : -w $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-w _,@_) : -w _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-w _,@_) : -w _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_WRONLY|O_APPEND) {
                my $w = -w $fh;
                close $fh;
                return wantarray ? ($w,@_) : $w;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -x expr
#
sub Euhc::x(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -x (Euhc::x)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-x _,@_) : -x _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-x $fh,@_) : -x $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-x _,@_) : -x _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-x _,@_) : -x _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $dummy_for_underline_cache = -x $fh;
                close $fh;
            }

            # filename is not .COM .EXE .BAT .CMD
            return wantarray ? ('',@_) : '';
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -o expr
#
sub Euhc::o(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -o (Euhc::o)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-o _,@_) : -o _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-o $fh,@_) : -o $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-o _,@_) : -o _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-o _,@_) : -o _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $o = -o $fh;
                close $fh;
                return wantarray ? ($o,@_) : $o;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -R expr
#
sub Euhc::R(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -R (Euhc::R)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-R _,@_) : -R _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-R $fh,@_) : -R $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-R _,@_) : -R _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-R _,@_) : -R _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $R = -R $fh;
                close $fh;
                return wantarray ? ($R,@_) : $R;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -W expr
#
sub Euhc::W(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -W (Euhc::W)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-W _,@_) : -W _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-W $fh,@_) : -W $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-W _,@_) : -W _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-W _,@_) : -W _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_WRONLY|O_APPEND) {
                my $W = -W $fh;
                close $fh;
                return wantarray ? ($W,@_) : $W;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -X expr
#
sub Euhc::X(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -X (Euhc::X)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-X _,@_) : -X _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-X $fh,@_) : -X $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-X _,@_) : -X _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-X _,@_) : -X _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $dummy_for_underline_cache = -X $fh;
                close $fh;
            }

            # filename is not .COM .EXE .BAT .CMD
            return wantarray ? ('',@_) : '';
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -O expr
#
sub Euhc::O(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -O (Euhc::O)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-O _,@_) : -O _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-O $fh,@_) : -O $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-O _,@_) : -O _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-O _,@_) : -O _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $O = -O $fh;
                close $fh;
                return wantarray ? ($O,@_) : $O;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -e expr
#
sub Euhc::e(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -e (Euhc::e)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-e _,@_) : -e _;
    }

    # return false if directory handle
    elsif (defined telldir(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? ('',@_) : '';
    }

    # return true if file handle
    elsif (fileno $fh) {
        return wantarray ? (1,@_) : 1;
    }

    elsif (-e $_) {
        return wantarray ? (1,@_) : 1;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (1,@_) : 1;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $e = -e $fh;
                close $fh;
                return wantarray ? ($e,@_) : $e;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -z expr
#
sub Euhc::z(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -z (Euhc::z)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-z _,@_) : -z _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-z $fh,@_) : -z $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-z _,@_) : -z _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-z _,@_) : -z _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $z = -z $fh;
                close $fh;
                return wantarray ? ($z,@_) : $z;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -s expr
#
sub Euhc::s(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -s (Euhc::s)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-s _,@_) : -s _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-s $fh,@_) : -s $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-s _,@_) : -s _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-s _,@_) : -s _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $s = -s $fh;
                close $fh;
                return wantarray ? ($s,@_) : $s;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -f expr
#
sub Euhc::f(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -f (Euhc::f)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-f _,@_) : -f _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-f $fh,@_) : -f $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-f _,@_) : -f _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? ('',@_) : '';
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $f = -f $fh;
                close $fh;
                return wantarray ? ($f,@_) : $f;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -d expr
#
sub Euhc::d(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -d (Euhc::d)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-d _,@_) : -d _;
    }

    # return false if file handle or directory handle
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? ('',@_) : '';
    }
    elsif (-e $_) {
        return wantarray ? (-d _,@_) : -d _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        return wantarray ? (-d "$_/",@_) : -d "$_/";
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -l expr
#
sub Euhc::l(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -l (Euhc::l)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-l _,@_) : -l _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-l $fh,@_) : -l $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-l _,@_) : -l _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-l _,@_) : -l _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $l = -l $fh;
                close $fh;
                return wantarray ? ($l,@_) : $l;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -p expr
#
sub Euhc::p(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -p (Euhc::p)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-p _,@_) : -p _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-p $fh,@_) : -p $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-p _,@_) : -p _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-p _,@_) : -p _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $p = -p $fh;
                close $fh;
                return wantarray ? ($p,@_) : $p;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -S expr
#
sub Euhc::S(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -S (Euhc::S)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-S _,@_) : -S _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-S $fh,@_) : -S $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-S _,@_) : -S _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-S _,@_) : -S _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $S = -S $fh;
                close $fh;
                return wantarray ? ($S,@_) : $S;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -b expr
#
sub Euhc::b(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -b (Euhc::b)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-b _,@_) : -b _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-b $fh,@_) : -b $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-b _,@_) : -b _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-b _,@_) : -b _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $b = -b $fh;
                close $fh;
                return wantarray ? ($b,@_) : $b;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -c expr
#
sub Euhc::c(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -c (Euhc::c)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-c _,@_) : -c _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-c $fh,@_) : -c $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-c _,@_) : -c _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-c _,@_) : -c _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $c = -c $fh;
                close $fh;
                return wantarray ? ($c,@_) : $c;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -t expr
#
sub Euhc::t(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -t (Euhc::t)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-t _,@_) : -t _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-t $fh,@_) : -t $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-t _,@_) : -t _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? ('',@_) : '';
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                close $fh;
                my $t = -t $fh;
                return wantarray ? ($t,@_) : $t;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -u expr
#
sub Euhc::u(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -u (Euhc::u)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-u _,@_) : -u _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-u $fh,@_) : -u $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-u _,@_) : -u _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-u _,@_) : -u _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $u = -u $fh;
                close $fh;
                return wantarray ? ($u,@_) : $u;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -g expr
#
sub Euhc::g(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -g (Euhc::g)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-g _,@_) : -g _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-g $fh,@_) : -g $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-g _,@_) : -g _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-g _,@_) : -g _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $g = -g $fh;
                close $fh;
                return wantarray ? ($g,@_) : $g;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -k expr
#
sub Euhc::k(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -k (Euhc::k)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-k _,@_) : -k _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-k $fh,@_) : -k $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-k _,@_) : -k _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-k _,@_) : -k _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $k = -k $fh;
                close $fh;
                return wantarray ? ($k,@_) : $k;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -T expr
#
sub Euhc::T(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -T (Euhc::T)' if @_ and not wantarray;
    my $T = 1;

    my $fh = Symbol::qualify_to_ref $_;
    if (fileno $fh) {
        if (defined telldir $fh) {
            return wantarray ? (undef,@_) : undef;
        }

        # P.813 tell
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.
        # (and so on)

        my $systell = sysseek $fh, 0, 1;

        if (sysread $fh, my $block, 512) {

            # P.163 Binary file check in Little Perl Parlor 16
            # of Book No. T1008901080816 ZASSHI 08901-8 UNIX MAGAZINE 1993 Aug VOL8#8
            # (and so on)

            if ($block =~ /[\000\377]/oxms) {
                $T = '';
            }
            elsif (($block =~ tr/\000-\007\013\016-\032\034-\037\377//) * 10 > length $block) {
                $T = '';
            }
        }

        # 0 byte or eof
        else {
            $T = 1;
        }

        sysseek $fh, $systell, 0;
    }
    else {
        if (-d $_ or -d "$_/") {
            return wantarray ? (undef,@_) : undef;
        }

        $fh = Symbol::gensym();
        unless (sysopen $fh, $_, O_RDONLY) {
            return wantarray ? (undef,@_) : undef;
        }
        if (sysread $fh, my $block, 512) {
            if ($block =~ /[\000\377]/oxms) {
                $T = '';
            }
            elsif (($block =~ tr/\000-\007\013\016-\032\034-\037\377//) * 10 > length $block) {
                $T = '';
            }
        }

        # 0 byte or eof
        else {
            $T = 1;
        }
        close $fh;
    }

    my $dummy_for_underline_cache = -T $fh;
    return wantarray ? ($T,@_) : $T;
}

#
# UHC file test -B expr
#
sub Euhc::B(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -B (Euhc::B)' if @_ and not wantarray;
    my $B = '';

    my $fh = Symbol::qualify_to_ref $_;
    if (fileno $fh) {
        if (defined telldir $fh) {
            return wantarray ? (undef,@_) : undef;
        }

        my $systell = sysseek $fh, 0, 1;

        if (sysread $fh, my $block, 512) {
            if ($block =~ /[\000\377]/oxms) {
                $B = 1;
            }
            elsif (($block =~ tr/\000-\007\013\016-\032\034-\037\377//) * 10 > length $block) {
                $B = 1;
            }
        }

        # 0 byte or eof
        else {
            $B = 1;
        }

        sysseek $fh, $systell, 0;
    }
    else {
        if (-d $_ or -d "$_/") {
            return wantarray ? (undef,@_) : undef;
        }

        $fh = Symbol::gensym();
        unless (sysopen $fh, $_, O_RDONLY) {
            return wantarray ? (undef,@_) : undef;
        }
        if (sysread $fh, my $block, 512) {
            if ($block =~ /[\000\377]/oxms) {
                $B = 1;
            }
            elsif (($block =~ tr/\000-\007\013\016-\032\034-\037\377//) * 10 > length $block) {
                $B = 1;
            }
        }

        # 0 byte or eof
        else {
            $B = 1;
        }
        close $fh;
    }

    my $dummy_for_underline_cache = -B $fh;
    return wantarray ? ($B,@_) : $B;
}

#
# UHC file test -M expr
#
sub Euhc::M(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -M (Euhc::M)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-M _,@_) : -M _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-M $fh,@_) : -M $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-M _,@_) : -M _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-M _,@_) : -M _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = CORE::stat $fh;
                close $fh;
                my $M = ($^T - $mtime) / (24*60*60);
                return wantarray ? ($M,@_) : $M;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -A expr
#
sub Euhc::A(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -A (Euhc::A)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-A _,@_) : -A _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-A $fh,@_) : -A $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-A _,@_) : -A _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-A _,@_) : -A _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = CORE::stat $fh;
                close $fh;
                my $A = ($^T - $atime) / (24*60*60);
                return wantarray ? ($A,@_) : $A;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -C expr
#
sub Euhc::C(;*@) {
    local $_ = shift if @_;
    croak 'Too many arguments for -C (Euhc::C)' if @_ and not wantarray;

    if ($_ eq '_') {
        return wantarray ? (-C _,@_) : -C _;
    }
    elsif (fileno(my $fh = Symbol::qualify_to_ref $_)) {
        return wantarray ? (-C $fh,@_) : -C $fh;
    }
    elsif (-e $_) {
        return wantarray ? (-C _,@_) : -C _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return wantarray ? (-C _,@_) : -C _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = CORE::stat $fh;
                close $fh;
                my $C = ($^T - $ctime) / (24*60*60);
                return wantarray ? ($C,@_) : $C;
            }
        }
    }
    return wantarray ? (undef,@_) : undef;
}

#
# UHC file test -r $_
#
sub Euhc::r_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -r _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -r _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $r = -r $fh;
                close $fh;
                return $r ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -w $_
#
sub Euhc::w_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -w _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -w _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_WRONLY|O_APPEND) {
                my $w = -w $fh;
                close $fh;
                return $w ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -x $_
#
sub Euhc::x_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -x _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -x _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $dummy_for_underline_cache = -x $fh;
                close $fh;
            }

            # filename is not .COM .EXE .BAT .CMD
            return $false;
        }
    }
    return;
}

#
# UHC file test -o $_
#
sub Euhc::o_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -o _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -o _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $o = -o $fh;
                close $fh;
                return $o ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -R $_
#
sub Euhc::R_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -R _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -R _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $R = -R $fh;
                close $fh;
                return $R ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -W $_
#
sub Euhc::W_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -W _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -W _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_WRONLY|O_APPEND) {
                my $W = -W $fh;
                close $fh;
                return $W ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -X $_
#
sub Euhc::X_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -X _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -X _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $dummy_for_underline_cache = -X $fh;
                close $fh;
            }

            # filename is not .COM .EXE .BAT .CMD
            return $false;
        }
    }
    return;
}

#
# UHC file test -O $_
#
sub Euhc::O_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -O _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -O _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $O = -O $fh;
                close $fh;
                return $O ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -e $_
#
sub Euhc::e_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return $true;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return $true;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $e = -e $fh;
                close $fh;
                return $e ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -z $_
#
sub Euhc::z_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -z _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -z _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $z = -z $fh;
                close $fh;
                return $z ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -s $_
#
sub Euhc::s_() {
    if (-e $_) {
        return -s _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -s _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $s = -s $fh;
                close $fh;
                return $s;
            }
        }
    }
    return;
}

#
# UHC file test -f $_
#
sub Euhc::f_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -f _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $f = -f $fh;
                close $fh;
                return $f ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -d $_
#
sub Euhc::d_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -d _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        return -d "$_/" ? $true : $false;
    }
    return;
}

#
# UHC file test -l $_
#
sub Euhc::l_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -l _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -l _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $l = -l $fh;
                close $fh;
                return $l ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -p $_
#
sub Euhc::p_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -p _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -p _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $p = -p $fh;
                close $fh;
                return $p ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -S $_
#
sub Euhc::S_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -S _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -S _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $S = -S $fh;
                close $fh;
                return $S ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -b $_
#
sub Euhc::b_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -b _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -b _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $b = -b $fh;
                close $fh;
                return $b ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -c $_
#
sub Euhc::c_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -c _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -c _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $c = -c $fh;
                close $fh;
                return $c ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -t $_
#
sub Euhc::t_() {
    my $true  = 1;
    my $false = '';

    return -t STDIN ? $true : $false;
}

#
# UHC file test -u $_
#
sub Euhc::u_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -u _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -u _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $u = -u $fh;
                close $fh;
                return $u ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -g $_
#
sub Euhc::g_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -g _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -g _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $g = -g $fh;
                close $fh;
                return $g ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -k $_
#
sub Euhc::k_() {
    my $true  = 1;
    my $false = '';

    if (-e $_) {
        return -k _ ? $true : $false;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -k _ ? $true : $false;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my $k = -k $fh;
                close $fh;
                return $k ? $true : $false;
            }
        }
    }
    return;
}

#
# UHC file test -T $_
#
sub Euhc::T_() {
    my $true  = 1;
    my $false = '';
    my $T     = $true;

    if (-d $_ or -d "$_/") {
        return;
    }
    my $fh = Symbol::gensym();
    unless (sysopen $fh, $_, O_RDONLY) {
        return;
    }

    if (sysread $fh, my $block, 512) {
        if ($block =~ /[\000\377]/oxms) {
            $T = $false;
        }
        elsif (($block =~ tr/\000-\007\013\016-\032\034-\037\377//) * 10 > length $block) {
            $T = $false;
        }
    }

    # 0 byte or eof
    else {
        $T = $true;
    }
    close $fh;

    my $dummy_for_underline_cache = -T $fh;
    return $T;
}

#
# UHC file test -B $_
#
sub Euhc::B_() {
    my $true  = 1;
    my $false = '';
    my $B     = $false;

    if (-d $_ or -d "$_/") {
        return;
    }
    my $fh = Symbol::gensym();
    unless (sysopen $fh, $_, O_RDONLY) {
        return;
    }

    if (sysread $fh, my $block, 512) {
        if ($block =~ /[\000\377]/oxms) {
            $B = $true;
        }
        elsif (($block =~ tr/\000-\007\013\016-\032\034-\037\377//) * 10 > length $block) {
            $B = $true;
        }
    }

    # 0 byte or eof
    else {
        $B = $true;
    }
    close $fh;

    my $dummy_for_underline_cache = -B $fh;
    return $B;
}

#
# UHC file test -M $_
#
sub Euhc::M_() {
    if (-e $_) {
        return -M _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -M _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = CORE::stat $fh;
                close $fh;
                my $M = ($^T - $mtime) / (24*60*60);
                return $M;
            }
        }
    }
    return;
}

#
# UHC file test -A $_
#
sub Euhc::A_() {
    if (-e $_) {
        return -A _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -A _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = CORE::stat $fh;
                close $fh;
                my $A = ($^T - $atime) / (24*60*60);
                return $A;
            }
        }
    }
    return;
}

#
# UHC file test -C $_
#
sub Euhc::C_() {
    if (-e $_) {
        return -C _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        if (-d "$_/") {
            return -C _;
        }
        else {
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                my($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks) = CORE::stat $fh;
                close $fh;
                my $C = ($^T - $ctime) / (24*60*60);
                return $C;
            }
        }
    }
    return;
}

#
# UHC path globbing (with parameter)
#
sub Euhc::glob($) {
    if ($^O =~ /\A (?:MSWin32|NetWare|symbian|dos) \z/oxms) {
        return _dosglob(@_);
    }
    else {
        return glob @_;
    }
}

#
# UHC path globbing (without parameter)
#
sub Euhc::glob_() {
    if ($^O =~ /\A (?:MSWin32|NetWare|symbian|dos) \z/oxms) {
        return _dosglob();
    }
    else {
        return glob;
    }
}

#
# UHC path globbing from File::DosGlob module
#
my %iter;
my %entries;
sub _dosglob {

    # context (keyed by second cxix argument provided by core)
    my($expr,$cxix) = @_;

    # glob without args defaults to $_
    $expr = $_ if not defined $expr;

    # represents the current user's home directory
    #
    # 7.3. Expanding Tildes in Filenames
    # in Chapter 7. File Access
    # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.
    #
    # and File::HomeDir::Windows module

    $expr =~ s{ \A ~ (?= [^/\\] ) }
              { $ENV{'HOME'} || $ENV{'USERPROFILE'} || "$ENV{'HOMEDRIVE'}$ENV{'HOMEPATH'}" }oxmse;

    # assume global context if not provided one
    $cxix = '_G_' if not defined $cxix;
    $iter{$cxix} = 0 if not exists $iter{$cxix};

    # if we're just beginning, do it all first
    if ($iter{$cxix} == 0) {
        $entries{$cxix} = [ _do_glob(1, _parse_line($expr)) ];
    }

    # chuck it all out, quick or slow
    if (wantarray) {
        delete $iter{$cxix};
        return @{delete $entries{$cxix}};
    }
    else {
        if ($iter{$cxix} = scalar @{$entries{$cxix}}) {
            return shift @{$entries{$cxix}};
        }
        else {
            # return undef for EOL
            delete $iter{$cxix};
            delete $entries{$cxix};
            return undef;
        }
    }
}

#
# UHC path globbing subroutine
#
sub _do_glob {
    my($cond,@expr) = @_;
    my @glob = ();

OUTER:
    for my $expr (@expr) {
        next OUTER if not defined $expr;
        next OUTER if $expr eq '';

        my @matched = ();
        my @globdir = ();
        my $head    = '.';
        my $pathsep = '/';
        my $tail;

        # if argument is within quotes strip em and do no globbing
        if ($expr =~ m/\A " (.*) " \z/oxms) {
            $expr = $1;
            if ($cond eq 'd') {
                if (Euhc::d $expr) {
                    push @glob, $expr;
                }
            }
            else {
                if (Euhc::e $expr) {
                    push @glob, $expr;
                }
            }
            next OUTER;
        }

        # wildcards with a drive prefix such as h:*.pm must be changed
        # to h:./*.pm to expand correctly
        $expr =~ s# \A ([A-Za-z]:) ([\x81-\xFE][\x00-\xFF]|[^/\\]) #$1./$2#oxms;

        if (($head, $tail) = _parse_path($expr,$pathsep)) {
            if ($tail eq '') {
                push @glob, $expr;
                next OUTER;
            }
            if ($head =~ m/ \A (?:[\x81-\xFE][\x00-\xFF]|[\x00-\xFF])*? [*?] /oxms) {
                if (@globdir = _do_glob('d', $head)) {
                    push @glob, _do_glob($cond, map {"$_$pathsep$tail"} @globdir);
                    next OUTER;
                }
            }
            if ($head eq '' or $head =~ m/\A [A-Za-z]: \z/oxms) {
                $head .= $pathsep;
            }
            $expr = $tail;
        }

        # If file component has no wildcards, we can avoid opendir
        if ($expr !~ m/ \A (?:[\x81-\xFE][\x00-\xFF]|[\x00-\xFF])*? [*?] /oxms) {
            if ($head eq '.') {
                $head = '';
            }
            if ($head ne '' and ($head =~ m/ \G ([\x81-\xFE][\x00-\xFF]|[\x00-\xFF]) /oxmsg)[-1] ne $pathsep) {
                $head .= $pathsep;
            }
            $head .= $expr;
            if ($cond eq 'd') {
                if (Euhc::d $head) {
                    push @glob, $head;
                }
            }
            else {
                if (Euhc::e $head) {
                    push @glob, $head;
                }
            }
            next OUTER;
        }
        Euhc::opendir(*DIR, $head) or next OUTER;
        my @leaf = readdir DIR;
        closedir DIR;

        if ($head eq '.') {
            $head = '';
        }
        if ($head ne '' and ($head =~ m/ \G ([\x81-\xFE][\x00-\xFF]|[\x00-\xFF]) /oxmsg)[-1] ne $pathsep) {
            $head .= $pathsep;
        }

        my $pattern = '';
        while ($expr =~ m/ \G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxgc) {
            $pattern .= {
                '*' => '(?:[\x81-\xFE][\x00-\xFF]|[\x00-\xFF])*',
            ### '?' => '(?:[\x81-\xFE][\x00-\xFF]|[\x00-\xFF])',   # UNIX style
                '?' => '(?:[\x81-\xFE][\x00-\xFF]|[\x00-\xFF])?',  # DOS style
                'a' => 'A',
                'b' => 'B',
                'c' => 'C',
                'd' => 'D',
                'e' => 'E',
                'f' => 'F',
                'g' => 'G',
                'h' => 'H',
                'i' => 'I',
                'j' => 'J',
                'k' => 'K',
                'l' => 'L',
                'm' => 'M',
                'n' => 'N',
                'o' => 'O',
                'p' => 'P',
                'q' => 'Q',
                'r' => 'R',
                's' => 'S',
                't' => 'T',
                'u' => 'U',
                'v' => 'V',
                'w' => 'W',
                'x' => 'X',
                'y' => 'Y',
                'z' => 'Z',
            }->{$1} || quotemeta $1;
        }

        my $matchsub = sub { Euhc::uc($_[0]) =~ m{\A $pattern \z}xms };
#       if ($@) {
#           print STDERR "$0: $@\n";
#           next OUTER;
#       }

INNER:
        for my $leaf (@leaf) {
            if ($leaf eq '.' or $leaf eq '..') {
                next INNER;
            }
            if ($cond eq 'd' and not Euhc::d "$head$leaf") {
                next INNER;
            }

            if (&$matchsub($leaf)) {
                push @matched, "$head$leaf";
                next INNER;
            }

            # [DOS compatibility special case]
            # Failed, add a trailing dot and try again, but only...

            if (Euhc::index($leaf,'.') == -1 and   # if name does not have a dot in it *and*
                length($leaf) <= 8 and              # name is shorter than or equal to 8 chars *and*
                Euhc::index($pattern,'\\.') != -1  # pattern has a dot.
            ) {
                if (&$matchsub("$leaf.")) {
                    push @matched, "$head$leaf";
                    next INNER;
                }
            }
        }
        if (@matched) {
            push @glob, @matched;
        }
    }
    return @glob;
}

#
# UHC parse line
#
sub _parse_line {
    my($line) = @_;

    $line .= ' ';
    my @piece = ();
    while ($line =~ m{
        " ( (?: [\x81-\xFE][\x00-\xFF] | [^"]   )*  ) " \s+ |
          ( (?: [\x81-\xFE][\x00-\xFF] | [^"\s] )*  )   \s+
        }oxmsg
    ) {
        push @piece, defined($1) ? $1 : $2;
    }
    return @piece;
}

#
# UHC parse path
#
sub _parse_path {
    my($path,$pathsep) = @_;

    $path .= '/';
    my @subpath = ();
    while ($path =~ m{
        ((?: [\x81-\xFE][\x00-\xFF] | [^/\\] )+?) [/\\] }oxmsg
    ) {
        push @subpath, $1;
    }
    my $tail = pop @subpath;
    my $head = join $pathsep, @subpath;
    return $head, $tail;
}

#
# UHC file lstat (with parameter)
#
sub Euhc::lstat(*) {
    my $fh = Symbol::qualify_to_ref $_[0];
    if (fileno $fh) {
        return CORE::lstat $fh;
    }
    elsif (-e $_[0]) {
        return CORE::lstat _;
    }
    elsif (_MSWin32_5Cended_path($_[0])) {
        my $fh = Symbol::gensym();
        if (sysopen $fh, $_[0], O_RDONLY) {
            my @lstat = CORE::lstat $fh;
            close $fh;
            return @lstat;
        }
    }
    return;
}

#
# UHC file lstat (without parameter)
#
sub Euhc::lstat_() {
    my $fh = Symbol::qualify_to_ref $_;
    if (fileno $fh) {
        return CORE::lstat $fh;
    }
    elsif (-e $_) {
        return CORE::lstat _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        my $fh = Symbol::gensym();
        if (sysopen $fh, $_, O_RDONLY) {
            my @lstat = CORE::lstat $fh;
            close $fh;
            return @lstat;
        }
    }
    return;
}

#
# UHC path opendir
#
sub Euhc::opendir(*$) {

    # 7.6. Writing a Subroutine That Takes Filehandles as Built-ins Do
    # in Chapter 7. File Access
    # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.

    my $dh = Symbol::qualify_to_ref $_[0];
    if (CORE::opendir $dh, $_[1]) {
        return 1;
    }
    elsif (_MSWin32_5Cended_path($_[1])) {
        if (CORE::opendir $dh, "$_[1]/") {
            return 1;
        }
    }
    return;
}

#
# UHC file stat (with parameter)
#
sub Euhc::stat(*) {
    my $fh = Symbol::qualify_to_ref $_[0];
    if (fileno $fh) {
        return CORE::stat $fh;
    }
    elsif (-e $_[0]) {
        return CORE::stat _;
    }
    elsif (_MSWin32_5Cended_path($_[0])) {
        my $fh = Symbol::gensym();
        if (sysopen $fh, $_[0], O_RDONLY) {
            my @stat = CORE::stat $fh;
            close $fh;
            return @stat;
        }
    }
    return;
}

#
# UHC file stat (without parameter)
#
sub Euhc::stat_() {
    my $fh = Symbol::qualify_to_ref $_;
    if (fileno $fh) {
        return CORE::stat $fh;
    }
    elsif (-e $_) {
        return CORE::stat _;
    }
    elsif (_MSWin32_5Cended_path($_)) {
        my $fh = Symbol::gensym();
        if (sysopen $fh, $_, O_RDONLY) {
            my @stat = CORE::stat $fh;
            close $fh;
            return @stat;
        }
    }
    return;
}

#
# UHC path unlink
#
sub Euhc::unlink(@) {
    if (@_ == 0) {
        if (CORE::unlink) {
            return 1;
        }
        elsif (_MSWin32_5Cended_path($_)) {
            my @char = /\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg;
            my $file = join '', map {{'/' => '\\'}->{$_} || $_} @char;
            if ($file =~ m/ \A (?:[\x81-\xFE][\x00-\xFF]|[^\x81-\xFE])*? [ ] /oxms) {
                $file = qq{"$file"};
            }
            system(qq{del $file >NUL 2>NUL});
            my $fh = Symbol::gensym();
            if (sysopen $fh, $_, O_RDONLY) {
                close $fh;
            }
            else {
                return 1;
            }
        }
        return 0;
    }
    else {
        my $unlink = 0;
        for (@_) {
            if (CORE::unlink) {
                $unlink++;
            }
            elsif (_MSWin32_5Cended_path($_)) {
                my @char = /\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg;
                my $file = join '', map {{'/' => '\\'}->{$_} || $_} @char;
                if ($file =~ m/ \A (?:[\x81-\xFE][\x00-\xFF]|[^\x81-\xFE])*? [ ] /oxms) {
                    $file = qq{"$file"};
                }
                system(qq{del $file >NUL 2>NUL});
                my $fh = Symbol::gensym();
                if (sysopen $fh, $_, O_RDONLY) {
                    close $fh;
                }
                else {
                    $unlink++;
                }
            }
        }
        return $unlink;
    }
}

#
# UHC chr(0x5C) ended path on MSWin32
#
sub _MSWin32_5Cended_path {
    if ((@_ >= 1) and ($_[0] ne '')) {
        if ($^O =~ /\A (?:MSWin32|NetWare|symbian|dos) \z/oxms) {
            my @char = $_[0] =~ /\G ([\x81-\xFE][\x00-\xFF] | [\x00-\xFF]) /oxmsg;
            if ($char[-1] =~ m/\A [\x81-\xFE][\x5C] \z/oxms) {
                return 1;
            }
        }
    }
    return;
}

# pop warning
$^W = $_warning;

1;

__END__

=pod

=head1 NAME

Euhc - Run-time routines for UHC.pm

=head1 SYNOPSIS

  use Euhc;

    Euhc::split(...);
    Euhc::tr(...);
    Euhc::chop(...);
    Euhc::index(...);
    Euhc::rindex(...);
    Euhc::lc(...);
    Euhc::lc_;
    Euhc::uc(...);
    Euhc::uc_;
    Euhc::shift_matched_var();
    Euhc::ignorecase(...);
    Euhc::chr(...);
    Euhc::chr_;
    Euhc::ord(...);
    Euhc::ord_;
    Euhc::reverse(...);
    Euhc::X ...;
    Euhc::X_;
    Euhc::glob(...);
    Euhc::glob_;
    Euhc::lstat(...);
    Euhc::lstat_;
    Euhc::opendir(...);
    Euhc::stat(...);
    Euhc::stat_;
    Euhc::unlink(...);

  # "no Euhc;" not supported

=head1 ABSTRACT

It output "use Euhc;" automatically when UHC.pm converts your script.
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

  @split = Euhc::split(/pattern/,$string,$limit);
  @split = Euhc::split(/pattern/,$string);
  @split = Euhc::split(/pattern/);
  @split = Euhc::split('',$string,$limit);
  @split = Euhc::split('',$string);
  @split = Euhc::split('');
  @split = Euhc::split();
  @split = Euhc::split;

  Scans a UHC $string for delimiters that match pattern and splits the UHC
  $string into a list of substrings, returning the resulting list value in list
  context, or the count of substrings in scalar context. The delimiters are
  determined by repeated pattern matching, using the regular expression given in
  pattern, so the delimiters may be of any size and need not be the same UHC
  $string on every match. If the pattern doesn't match at all, Euhc::split returns
  the original UHC $string as a single substring. If it matches once, you get
  two substrings, and so on.
  If $limit is specified and is not negative, the function splits into no more than
  that many fields. If $limit is negative, it is treated as if an arbitrarily large
  $limit has been specified. If $limit is omitted, trailing null fields are stripped
  from the result (which potential users of pop would do well to remember).
  If UHC $string is omitted, the function splits the $_ UHC string.
  If $patten is also omitted, the function splits on whitespace, /\s+/, after
  skipping any leading whitespace.
  If the pattern contains parentheses, then the substring matched by each pair of
  parentheses is included in the resulting list, interspersed with the fields that
  are ordinarily returned.

=item Transliteration

  $tr = Euhc::tr($string,$searchlist,$replacementlist,$modifier);
  $tr = Euhc::tr($string,$searchlist,$replacementlist);

  This function scans a UHC string character by character and replaces all
  occurrences of the characters found in $searchlist with the corresponding character
  in $replacementlist. It returns the number of characters replaced or deleted.
  If no UHC string is specified via =~ operator, the $_ string is translated.
  $modifier are:

  Modifier   Meaning
  ------------------------------------------------------
  c          Complement $searchlist
  d          Delete found but unreplaced characters
  s          Squash duplicate replaced characters
  ------------------------------------------------------

=item Chop string

  $chop = Euhc::chop(@list);
  $chop = Euhc::chop();
  $chop = Euhc::chop;

  Chops off the last character of a UHC string contained in the variable (or
  UHC strings in each element of a @list) and returns the character chopped.
  The Euhc::chop operator is used primarily to remove the newline from the end of
  an input record but is more efficient than s/\n$//. If no argument is given, the
  function chops the $_ variable.

=item Index string

  $pos = Euhc::index($string,$substr,$position);
  $pos = Euhc::index($string,$substr);

  Returns the position of the first occurrence of $substr in UHC $string.
  The start, if specified, specifies the $position to start looking in the UHC
  $string. Positions are integer numbers based at 0. If the substring is not found,
  the index function returns -1.

=item Reverse index string

  $pos = Euhc::rindex($string,$substr,$position);
  $pos = Euhc::rindex($string,$substr);

  Works just like index except that it returns the position of the last occurence
  of $substr in UHC $string (a reverse index). The function returns -1 if not
  found. $position, if specified, is the rightmost position that may be returned,
  i.e., how far in the UHC string the function can search.

=item Lower case string

  $lc = Euhc::lc($string);
  $lc = Euhc::lc_;

  Returns a lowercase version of UHC string (or $_, if omitted). This is the
  internal function implementing the \L escape in double-quoted strings.

=item Upper case string

  $uc = Euhc::uc($string);
  $uc = Euhc::uc_;

  Returns an uppercased version of UHC string (or $_, if string is omitted).
  This is the internal function implementing the \U escape in double-quoted
  strings.

=item Shift matched variables

  $dollar1 = Euhc::shift_matched_var();

  This function is internal use to s/ / /.

=item Make ignore case string

  @ignorecase = Euhc::ignorecase(@string);

  This function is internal use to m/ /i, s/ / /i and qr/ /i.

=item Make character

  $chr = Euhc::chr($code);
  $chr = Euhc::chr_;

  This function returns the character represented by that $code in the character
  set. For example, chr(65) is "A" in either ASCII or UHC, and chr(0x82a0)
  is a UHC HIRAGANA LETTER A. For the reverse of chr, use ord.

=item Order of Character

  $ord = Euhc::ord($string);
  $ord = Euhc::ord_;

  This function returns the numeric value (ASCII or UHC) of the first character
  of $string. The return value is always unsigned.

=item Reverse list or string

  @reverse = Euhc::reverse(@list);
  $reverse = Euhc::reverse(@list);

  In list context, this function returns a list value consisting of the elements of
  @list in the opposite order. The function can be used to create descending sequences:

  for (reverse 1 .. 10) { ... }

  Because of the way hashes flatten into lists when passed as a @list, reverse can also
  be used to invert a hash, presuming the values are unique:

  %barfoo = reverse %foobar;

  In scalar context, the function concatenates all the elements of LIST and then returns
  the reverse of that resulting string, character by character.

=item File test operator -X

  A file test operator is an unary operator that tests a pathname or a filehandle.
  If $string is omitted, it uses $_ by function Euhc::r_.
  The following functions function when the pathname ends with chr(0x5C) on MSWin32.

  $test = Euhc::r $string;
  $test = Euhc::r_;

  Returns 1 when true case or '' when false case.
  Returns undef unless successful.

  Function and Prototype     Meaning
  ------------------------------------------------------------------------------
  Euhc::r(*), Euhc::r_()   File is readable by effective uid/gid
  Euhc::w(*), Euhc::w_()   File is writable by effective uid/gid
  Euhc::x(*), Euhc::x_()   File is executable by effective uid/gid
  Euhc::o(*), Euhc::o_()   File is owned by effective uid
  Euhc::R(*), Euhc::R_()   File is readable by real uid/gid
  Euhc::W(*), Euhc::W_()   File is writable by real uid/gid
  Euhc::X(*), Euhc::X_()   File is executable by real uid/gid
  Euhc::O(*), Euhc::O_()   File is owned by real uid
  Euhc::e(*), Euhc::e_()   File exists
  Euhc::z(*), Euhc::z_()   File has zero size
  Euhc::f(*), Euhc::f_()   File is a plain file
  Euhc::d(*), Euhc::d_()   File is a directory
  Euhc::l(*), Euhc::l_()   File is a symbolic link
  Euhc::p(*), Euhc::p_()   File is a named pipe (FIFO)
  Euhc::S(*), Euhc::S_()   File is a socket
  Euhc::b(*), Euhc::b_()   File is a block special file
  Euhc::c(*), Euhc::c_()   File is a character special file
  Euhc::t(*), Euhc::t_()   Filehandle is opened to a tty
  Euhc::u(*), Euhc::u_()   File has setuid bit set
  Euhc::g(*), Euhc::g_()   File has setgid bit set
  Euhc::k(*), Euhc::k_()   File has sticky bit set
  ------------------------------------------------------------------------------

  Returns 1 when true case or '' when false case.
  Returns undef unless successful.

  The Euhc::T, Euhc::T_, Euhc::B and Euhc::B_ work as follows. The first block
  or so of the file is examined for strange chatracters such as
  [\000-\007\013\016-\032\034-\037\377] (that don't look like UHC). If more
  than 10% of the bytes appear to be strange, it's a *maybe* binary file;
  otherwise, it's a *maybe* text file. Also, any file containing ASCII NUL(\0) or
  \377 in the first block is considered a binary file. If Euhc::T or Euhc::B is
  used on a filehandle, the current input (standard I/O or "stdio") buffer is
  examined rather than the first block of the file. Both Euhc::T and Euhc::B
  return 1 as true on an empty file, or on a file at EOF (end-of-file) when testing
  a filehandle. Both Euhc::T and Euhc::B deosn't work when given the special
  filehandle consisting of a solitary underline.

  Function and Prototype     Meaning
  ------------------------------------------------------------------------------
  Euhc::T(*), Euhc::T_()   File is a text file
  Euhc::B(*), Euhc::B_()   File is a binary file (opposite of -T)
  ------------------------------------------------------------------------------

  Returns useful value if successful, or undef unless successful.

  $value = Euhc::s $string;
  $value = Euhc::s_;

  Function and Prototype     Meaning
  ------------------------------------------------------------------------------
  Euhc::s(*), Euhc::s_()   File has nonzero size (returns size)
  Euhc::M(*), Euhc::M_()   Age of file (at startup) in days since modification
  Euhc::A(*), Euhc::A_()   Age of file (at startup) in days since last access
  Euhc::C(*), Euhc::C_()   Age of file (at startup) in days since inode change
  ------------------------------------------------------------------------------

=item Filename expansion (globbing)

  @glob = Euhc::glob($string);
  @glob = Euhc::glob_;

  Performs filename expansion (DOS-like globbing) on $string, returning the next
  successive name on each call. If $string is omitted, $_ is globbed instead.
  This function function when the pathname ends with chr(0x5C) on MSWin32.

  For example, C<<..\\l*b\\file/*glob.p?>> will work as expected (in that it will
  find something like '..\lib\File/DosGlob.pm' alright). Note that all path
  components are case-insensitive, and that backslashes and forward slashes are
  both accepted, and preserved. You may have to double the backslashes if you are
  putting them in literally, due to double-quotish parsing of the pattern by perl.
  A tilde ("~") expands to the current user's home directory.

  Spaces in the argument delimit distinct patterns, so C<glob('*.exe *.dll')> globs
  all filenames that end in C<.exe> or C<.dll>. If you want to put in literal spaces
  in the glob pattern, you can escape them with either double quotes.
  e.g. C<glob('c:/"Program Files"/*/*.dll')>.

=item Statistics about link

  @lstat = Euhc::lstat($file);
  @lstat = Euhc::lstat_;

  Like stat, returns information on file, except that if file is a symbolic link,
  lstat returns information about the link; stat returns information about the
  file pointed to by the link. (If symbolic links are unimplemented on your
  system, a normal stat is done instead.) If file is omitted, returns information
  on file given in $_.
  This function function when the filename ends with chr(0x5C) on MSWin32.

=item Open directory handle

  $rc = Euhc::opendir(DIR,$dir);

  Opens a directory for processing by readdir, telldir, seekdir, rewinddir and
  closedir. The function returns true if successful.
  This function function when the directory name ends with chr(0x5C) on MSWin32.

=item Statistics about file

  @stat = Euhc::stat($file);
  @stat = Euhc::stat_;

  Returns a 13-element list giving the statistics for a file, indicated by either
  a filehandle or an expression that gives its name. It's typically used as
  follows:

  ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
      $atime,$mtime,$ctime,$blksize,$blocks) = Euhc::stat($file);

  Not all fields are supported on all filesystem types. Here are the meanings of
  the fields:

  Field     Meaning
  -----------------------------------------------------------------
  dev       Device number of filesystem
  ino       Inode number
  mode      File mode (type and permissions)
  nlink     Nunmer of (hard) links to the file
  uid       Numeric user ID of file's owner
  gid       Numeric group ID of file's owner
  rdev      The device identifier (special files only)
  size      Total size of file, in bytes
  atime     Last access time since the epoch
  mtime     Last modification time since the epoch
  ctime     Inode change time (not creation time!) since the epoch
  blksize   Preferred blocksize for file system I/O
  blocks    Actual number of blocks allocated
  -----------------------------------------------------------------

  $dev and $ino, token together, uniquely identify a file. The $blksize and
  $blocks are likely defined only on BSD-derived filesystem. The $blocks field
  (if defined) is reported in 512-byte blocks.
  If stat is passed the special filehandle consisting of an underline, no
  actual stat is done, but the current contents of the stat structure from the
  last stat or stat-based file test (the -x operators) is returned.
  If file is omitted, returns information on file given in $_.
  This function function when the filename ends with chr(0x5C) on MSWin32.

=item Deletes a list of files.

  $unlink = Euhc::unlink(@list);
  $unlink = Euhc::unlink($file);
  $unlink = Euhc::unlink;

  Delete a list of files. (Under Unix, it will remove a link to a file, but the
  file may still exist if another link references it.) If list is omitted, it
  unlinks the file given in $_. The function returns the number of files
  successfully deleted.
  This function function when the filename ends with chr(0x5C) on MSWin32.

=back

=cut

