package Archive::Any::Create;

use strict;
our $VERSION = '0.01';

use Exception::Class 'Archive::Any::Create::Error';
use UNIVERSAL::require;

our %Type2Class = (
    'tar' => [ 'Archive::Any::Create::Tar' ],
    'tar.gz' => [ 'Archive::Any::Create::Tar', { comp => 1 } ],
    'zip' => [ 'Archive::Any::Create::Zip' ],
);

my $re = '(' . join('|', map quotemeta, keys %Type2Class) . ')$';

sub new {
    my $class = shift;
    bless [ ], $class;
}

sub container {
    my $self = shift;
    push @$self, [ 'container', @_ ];
}

sub add_file {
    my $self = shift;
    push @$self, [ 'add_file', @_ ];
}

sub write_file {
    my $self = shift;
    $self->proxy_methods($_[0])->write_file(@_);
}

sub write_filehandle {
    my $self = shift;
    $self->proxy_methods($_[1])->write_filehandle(@_);
}

sub proxy_methods {
    my $self = shift;
    my($file) = @_;

    my @methods = @$self;

    $file =~ /$re/ or throw Archive::Any::Create::Error(error => "Can't detect archive type via filename $file");
    my($subclass, $opt) = @{ $Type2Class{$1} };
    $subclass->require or die $@;
    $self = bless { }, $subclass;
    $self->init($opt);

    for my $m (@methods) {
        my($method, @args) = @$m;
        $self->$method(@args);
    }

    $self;
}

1;
__END__

=head1 NAME

Archive::Any::Create - Abstract API to create archives (tar.gz and zip)

=head1 SYNOPSIS

  use Archive::Any::Create;

  my $archive = Archive::Any::Create->new;

  $archive->container('foo');               # top-level directory
  $archive->add_file('bar.txt', $data);     # foo/bar.txt
  $archive->add_file('bar/baz.txt', $data); # foo/bar/baz.txt

  $archive->write_file('foo.tar.gz');
  $archive->write_file('foo.zip');

  $archive->write_filehandle(\*STDOUT, 'tar.gz');

=head1 DESCRIPTION

Archive::Any::Create is

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Archive::Any>, L<Archive::Tar>, L<Archive::Zip>

=cut
