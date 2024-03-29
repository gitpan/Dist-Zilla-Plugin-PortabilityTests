use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::PortabilityTests;
BEGIN {
  $Dist::Zilla::Plugin::PortabilityTests::VERSION = '1.111840';
}
# ABSTRACT: Release tests for portability
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::FileMunger';

has options => (
  is      => 'ro',
  isa     => 'Str',
  default => '',
);

sub munge_file {
  my ($self, $file) = @_;
  return unless $file->name eq 'xt/release/portability.t';

  # 'name => val, name=val'
  my %options = split(/\W+/, $self->options);

  if ( keys %options ) {
    my $content = $file->content;

    my $optstr = join ', ', map { "$_ => $options{$_}" } sort keys %options;

    # insert options() above run_tests;
    $content =~ s/^(run_tests\(\);)$/options($optstr);\n$1/m;

    $file->content($content);
  }
  return;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;




=pod

=for test_synopsis 1;
__END__

=head1 NAME

Dist::Zilla::Plugin::PortabilityTests - Release tests for portability

=head1 VERSION

version 1.111840

=head1 SYNOPSIS

In C<dist.ini>:

    [PortabilityTests]
    ; you can optionally specify test options
    options = test_dos_length = 1, use_file_find = 0

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following file:

  xt/release/portability.t - a standard Test::Portability::Files test

You can set options for the tests in the 'options' attribute:
Specify C<< name = value >> separated by commas.

See L<Test::Portability::Files/options> for possible options.

=head1 METHODS

=head2 munge_file

Inserts the given options into the generated test file.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-Plugin-PortabilityTests>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/Dist-Zilla-Plugin-PortabilityTests/>.

The development version lives at L<http://github.com/hanekomu/Dist-Zilla-Plugin-PortabilityTests>
and may be cloned from L<git://github.com/hanekomu/Dist-Zilla-Plugin-PortabilityTests.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 AUTHORS

=over 4

=item *

Marcel Gruenauer <marcel@cpan.org>

=item *

Randy Stauner <rwstauner@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__DATA__
___[ xt/release/portability.t ]___
#!perl

use Test::More;

eval "use Test::Portability::Files";
plan skip_all => "Test::Portability::Files required for testing portability"
  if $@;
run_tests();
