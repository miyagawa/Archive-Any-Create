# NAME

Archive::Any::Create - Abstract API to create archives (tar.gz and zip)

# SYNOPSIS

    use Archive::Any::Create;

    my $archive = Archive::Any::Create->new;

    $archive->container('foo');               # top-level directory
    $archive->add_file('bar.txt', $data);     # foo/bar.txt
    $archive->add_file('bar/baz.txt', $data); # foo/bar/baz.txt

    $archive->write_file('foo.tar.gz');
    $archive->write_file('foo.zip');

    $archive->write_filehandle(\*STDOUT, 'tar.gz');

# DESCRIPTION

Archive::Any::Create is a wrapper module to create tar/tar.gz/zip
files with a single easy-to-use API.

# METHODS

- new

    Create new Archive::Any::Create object. No parameters.

- container($dir)

    Specify a top-level directory (or folder) to contain multiple
    files. Not necessary but recommended to create a good-manner archive
    file.

- add\_file($file, $data)

    Add a file that contains `$data` as its content. `$file` can be a
    file in the nested subdirectory.

- write\_file($filename)

    Write an archive file named `$filename`. This method is DWIMmy, in
    the sense that it automatically dispatches archiving module based on
    its filename. So, `$archive->write_file("foo.tar.gz")` will
    create a tarball and `$archive->write_file("foo.zip")` will
    create a zip file with the same contents.

- write\_filehandle($fh, $format)

    Write an archive data stream into filehandle. `$format` is either,
    _tar_, _tar.gz_ or _zip_.

# AUTHOR

Tatsuhiko Miyagawa &lt;miyagawa@bulknews.net>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Archive::Any](https://metacpan.org/pod/Archive::Any), [Archive::Tar](https://metacpan.org/pod/Archive::Tar), [Archive::Zip](https://metacpan.org/pod/Archive::Zip)
