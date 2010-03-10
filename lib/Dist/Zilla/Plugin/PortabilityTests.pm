use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::PortabilityTests;
our $VERSION = '1.100690';
# ABSTRACT: release tests for portability
use Moose;
use Test::Portability::Files ();
extends 'Dist::Zilla::Plugin::InlineFiles';

__PACKAGE__->meta->make_immutable;
no Moose;
1;




=pod

=head1 NAME

Dist::Zilla::Plugin::PortabilityTests - release tests for portability

=head1 VERSION

version 1.100690

=head1 SYNOPSIS

In C<dist.ini>:

    [PortabilityTests]

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following files

  xt/release/portability.t - a standard Test::Portability::Files test

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AUTHOR

  Marcel Gruenauer <marcel@cpan.org>

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
plan skip_all => "Test::Kwalitee required for testing kwalitee"
  if $@;
run_tests();
