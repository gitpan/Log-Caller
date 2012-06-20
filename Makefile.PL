
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  ABSTRACT => "provides: log_(debug,warn,info,error,fatal) with warn() like caller context",
  AUTHOR => "Samuel Kaufman <sam\@socialflow.com>",
  BUILD_REQUIRES => {
    "Test::More" => 0
  },
  CONFIGURE_REQUIRES => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  PREREQ_PM => {
    parent => 0,
    'Sub::Exporter' => '0.982',
  },
  DISTNAME => "Log-Caller",
  EXE_FILES => [],
  LICENSE => "perl",
  NAME => "Log::Caller",
  VERSION_FROM => 'lib/Log/Caller.pm',
  test => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



