# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;
print "1..15\n";

my $__FILE__ = __FILE__;

$text = '�h�n�D�r�x�r�F�Q�Q�T�T�T�W�F�X�T�|�P�O�|�O�R�F�|���|�����F����������������';

# 7.7 split���Z�q(���X�g�R���e�L�X�g)
@_ = split(/�F/, $text);
if (join('', map {"($_)"} @_) eq "(�h�n�D�r�x�r)(�Q�Q�T�T�T�W)(�X�T�|�P�O�|�O�R)(�|���|����)(����������������)") {
    print qq{ok - 1 \@_ = split(/�F/, \$text); $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 \@_ = split(/�F/, \$text); $^X $__FILE__\n};
}

# ����ȃ}�b�`�퉉�Z�q // ���g�����ꍇ
@_ = split(//, "�����������@��������");
if (join('', map {"($_)"} @_) eq "(��)(��)(��)(��)(��)(�@)(��)(��)(��)(��)") {
    print qq{ok - 2 \@_ = split(//, "�����������@��������") $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 \@_ = split(//, "�����������@��������") $^X $__FILE__\n};
}

# ����ȃ}�b�`�퉉�Z�q " "(�X�y�[�X1���̒ʏ�̕�����)���g�����ꍇ
@_ = split(" ", "   �� ����������   ��������   ");
if (join('', map {"($_)"} @_) eq "(��)(����������)(��������)") {
    print qq{ok - 3 \@_ = split(" ", "   �� ����������   ��������   ") $^X $__FILE__\n};
}
else {
    print qq{not ok - 3 \@_ = split(" ", "   �� ����������   ��������   ") $^X $__FILE__\n};
}

# �擪�̋󔒂��c�������ꍇ
@_ = split(m/\s+/, "   �� ����������   ��������   ");
if (join('', map {"($_)"} @_) eq "()(��)(����������)(��������)") {
    print qq{ok - 4 \@_ = split(m/\\s+/, "   �� ����������   ��������   ") $^X $__FILE__\n};
}
else {
    print qq{not ok - 4 \@_ = split(m/\\s+/, "   �� ����������   ��������   ") $^X $__FILE__\n};
}

# �����̋󔒂��c�������ꍇ
@_ = split(" ", "   �� ����������   ��������   ", -1);
if (join('', map {"($_)"} @_) eq "(��)(����������)(��������)()") {
    print qq{ok - 5 \@_ = split(" ", "   �� ����������   ��������   ", -1) $^X $__FILE__\n};
}
else {
    print qq{not ok - 5 \@_ = split(" ", "   �� ����������   ��������   ", -1) $^X $__FILE__\n};
}

# �}�b�`�퉉�Z�q���w�肳��Ă��Ȃ��ꍇ
$_ = "   �� ����������   ��������   ";
@_ = split;
if (join('', map {"($_)"} @_) eq "(��)(����������)(��������)") {
    print qq{ok - 6 \@_ = split $^X $__FILE__\n};
}
else {
    print qq{not ok - 6 \@_ = split $^X $__FILE__\n};
}

# 7.7.1.2 �^�[�Q�b�g�����񂪎w�肳��Ă��Ȃ��ꍇ
$_ = $text;
@_ = split(/�F/);
if (join('', map {"($_)"} @_) eq "(�h�n�D�r�x�r)(�Q�Q�T�T�T�W)(�X�T�|�P�O�|�O�R)(�|���|����)(����������������)") {
    print qq{ok - 7 \@_ = split(/�F/) $^X $__FILE__\n};
}
else {
    print qq{not ok - 7 \@_ = split(/�F/) $^X $__FILE__\n};
}

# 7.7.1.3 ������퉉�Z�q�̊�{
@_ = split(/�F/, $text, 3);
if (join('', map {"($_)"} @_) eq "(�h�n�D�r�x�r)(�Q�Q�T�T�T�W)(�X�T�|�P�O�|�O�R�F�|���|�����F����������������)") {
    print qq{ok - 8 \@_ = split(/�F/, \$text, 3) $^X $__FILE__\n};
}
else {
    print qq{not ok - 8 \@_ = split(/�F/, \$text, 3) $^X $__FILE__\n};
}

# 7.7.2 ��v�f
@_ = split(m/�F/, "�P�Q�F�R�S�F�F�V�W");
if (join('', map {"($_)"} @_) eq "(�P�Q)(�R�S)()(�V�W)") {
    print qq{ok - 9 \@_ = split(m/�F/, "�P�Q�F�R�S�F�F�V�W") $^X $__FILE__\n};
}
else {
    print qq{not ok - 9 \@_ = split(m/�F/, "�P�Q�F�R�S�F�F�V�W") $^X $__FILE__\n};
}

# 7.7.2.1 �����̋�v�f
@_ = split(m/�F/, "�P�Q�F�R�S�F�F�V�W�F�F�F");
if (join('', map {"($_)"} @_) eq "(�P�Q)(�R�S)()(�V�W)") {
    print qq{ok - 10 \@_ = split(m/�F/, "�P�Q�F�R�S�F�F�V�W�F�F�F") $^X $__FILE__\n};
}
else {
    print qq{not ok - 10 \@_ = split(m/�F/, "�P�Q�F�R�S�F�F�V�W�F�F�F") $^X $__FILE__\n};
}

# 7.7.2.3 ������̗��[�ł̓���ȃ}�b�`
@_ = split(m/�F/, "�F�P�Q�F�R�S�F�F�V�W");
if (join('', map {"($_)"} @_) eq "()(�P�Q)(�R�S)()(�V�W)") {
    print qq{ok - 11 \@_ = split(m/�F/, "�F�P�Q�F�R�S�F�F�V�W") $^X $__FILE__\n};
}
else {
    print qq{not ok - 11 \@_ = split(m/�F/, "�F�P�Q�F�R�S�F�F�V�W") $^X $__FILE__\n};
}

# �u^�v�Ƃ������K�\�����g�����ꍇ
$_ = "�`�`�`\n�a�a�a\n�b�b�b";
@_ = split(m/^/, $_);
if (join('', map {"($_)"} @_) eq "(�`�`�`\n)(�a�a�a\n)(�b�b�b)") {
    print qq{ok - 12 \@_ = split(m/^/, \$\_) $^X $__FILE__\n};
}
else {
    print qq{not ok - 12 \@_ = split(m/^/, \$\_) $^X $__FILE__\n};
}
@_ = split(m/^/m, $_);
if (join('', map {"($_)"} @_) eq "(�`�`�`\n)(�a�a�a\n)(�b�b�b)") {
    print qq{ok - 13 \@_ = split(m/^/m, \$\_) $^X $__FILE__\n};
}
else {
    print qq{not ok - 13 \@_ = split(m/^/m, \$\_) $^X $__FILE__\n};
}

# 7.7.4 �L���v�`���t�����ʂ��܂� split �̃}�b�`�퉉�Z�q
@_ = split(/(<[^>]*>)/, "�@�������@<�a>���������@<�e�n�m�s�@������������������>��������</�e�n�m�s>�@��������</B>�@������������");
if (join('', map {"($_)"} @_) eq "(�@�������@)(<�a>)(���������@)(<�e�n�m�s�@������������������>)(��������)(</�e�n�m�s>)(�@��������)(</B>)(�@������������)") {
    print qq{ok - 14 \@_ = split(/(<[^>]*>)/, "�@�������@<�a>���������@<�e�n�m�s�@������������������>��������</�e�n�m�s>�@��������</B>�@������������") $^X $__FILE__\n};
}
else {
    print qq{not ok - 14 \@_ = split(/(<[^>]*>)/, "�@�������@<�a>���������@<�e�n�m�s�@������������������>��������</�e�n�m�s>�@��������</B>�@������������") $^X $__FILE__\n};
}

# 7.7.3.1 split �ɂ͕���p���Ȃ����Ƃ̊m�F
$a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
$a =~ m/ABC(DEF)G(HI)/;
if (($1 eq "DEF") and ($2 eq "HI")) {
    $b = "123,45,6,78,,90";
    @_ = split(/,/,$b);
    if (($1 eq "DEF") and ($2 eq "HI")) {
        print qq{ok - 15 split �ɕ���p���Ȃ����Ƃ̊m�F ($1)($2) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 15 split �ɕ���p���Ȃ����Ƃ̊m�F ($1)($2) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 15 split �ɕ���p���Ȃ����Ƃ̊m�F ($1)($2) $^X $__FILE__\n};
}

__END__
