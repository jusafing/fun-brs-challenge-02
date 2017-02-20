#!/usr/bin/perl -w
###############################################################################
# Name      : solve-brs-c002-FASTEST.pl 
# Author    : Javier S.A. [jusafing@gmail.com] (February 2017)
# Summary   : This script solves the challenge [brs-challenge-002]
#             It read a file with random strings and finds ALL the potential
#             key candidates that match the characteristics in the README File
#             of the instructions of the challenge. It does everythhing in an
#             automated way.
#
# Syntax    : $ ./solve-brs-c002-fastest.pl DATA_FILE
###############################################################################
use strict;
###############################################################################
my $DEBUG       = 1;
###############################################################################

processCandidates();

###############################################################################
sub processCandidates  {
    my %keysok    = ();
    my $regexkey  = "x.-#";
    open(FILE,$ARGV[0]) || die "ERROR unable to read the file\n";
    while(<FILE>) {
        my $pat = $_ =~ m/$regexkey([0-9]*)\|(.*)/;
        if ($pat && $DEBUG) {
            print "  |   \\--- Part [$1]-> [$2]\n" ;
        }
        $keysok{$regexkey}{$1} = $2 if ($pat);
    }
    close(FILE);
    foreach my $key (keys%{keysok}) {
        print "  |\n  |   \\--- Message from key [$key] : ";
        foreach my $part (sort {$a<=>$b} keys%{$keysok{$key}}) {
            print "$keysok{$key}{$part}";
        }
        print "\n";
    }
}
