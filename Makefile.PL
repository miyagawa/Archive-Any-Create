use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Archive::Any::Create',
    'VERSION_FROM' => 'lib/Archive/Any/Create.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
        Archive::Tar => 0,
        Archive::Zip => 0,
        PerlIO::gzip => 0,
        UNIVERSAL::require => 0,
        Exception::Class => 0,
    },
);
