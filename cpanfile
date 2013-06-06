requires 'Archive::Tar';
requires 'Archive::Zip';
requires 'Exception::Class';
requires 'PerlIO::gzip';
requires 'Test::More', '0.32';
requires 'UNIVERSAL::require';

on build => sub {
    requires 'ExtUtils::MakeMaker';
};
