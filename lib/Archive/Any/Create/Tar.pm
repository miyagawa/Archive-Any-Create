package Archive::Any::Create::Tar;
use strict;

use PerlIO::gzip;
use Archive::Tar;

sub init {
    my $self = shift;
    my($opt) = @_;
    $self->{tar}  = Archive::Tar->new;
    $self->{comp} = $opt->{comp};
}

sub container {
    my $self = shift;
    my($dir) = @_;
    $self->{container} = $dir;
}

sub add_file {
    my $self = shift;
    my($file, $data) = @_;
    $self->{tar}->add_data($file, $data);
}

sub write_file {
    my $self = shift;
    my($file) = @_;
    $self->{tar}->write($file, $self->{comp}, $self->{container})
        or throw Archive::Any::Create::Error(error => $self->{tar}->error);
    1;
}

sub write_filehandle {
    my $self = shift;
    my($fh)  = @_;
    if ($self->{comp}) {
        binmode $fh, ":gzip";
    }
    $self->{tar}->write($fh, 0, $self->{container})
        or throw Archive::Any::Create::Error(error => $self->{tar}->error);
    1;
}

1;
