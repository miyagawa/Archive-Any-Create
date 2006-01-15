use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Archive::Any::Create',
    'VERSION_FROM' => 'lib/Archive/Any/Create.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
    },
);
