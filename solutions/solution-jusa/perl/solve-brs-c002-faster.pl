#!/usr/bin/perl -w
###############################################################################
# Name      : solve-brs-c002-faster.pl 
# Author    : Javier S.A. [jusafing@gmail.com] (February 2017)
# Summary   : This script solves the challenge [brs-challenge-002]
#             It read a file with random strings and finds ALL the potential
#             key candidates that match the characteristics in the README File
#             of the instructions of the challenge. It does everythhing in an
#             automated way.
#
# Syntax    : $ ./solve-brs-c002-faster.pl DATA_FILE
###############################################################################
use strict;
###############################################################################
my $THRESHOLD   = 40;
my $DEBUG       = 1;
my %counter     ;
my $tmp         = 1;
###############################################################################

preProcessData();
processCandidates();

###############################################################################
sub preProcessData  {
    print "\nSTART\n  |\n  | Processing data. Searching candidate KEYS ... \n";
    open(FILE,$ARGV[0]) || die "ERROR unable to read the file\n";
    while(<FILE>) {
        my $p = $_ =~ m/(.)(.)(.)(.)(.*)/;
        $counter{"4-$1$2$3."}++;
        $counter{"3-$1$2.$4"}++;
        $counter{"2-$1.$3$4"}++;
        $counter{"1-.$2$3$4"}++;
    }
    close(FILE);
}


###############################################################################
sub processCandidates  {
    my %keysok      = ();
    my $keyfound    ;
    foreach my $key ( keys%{counter} ) {
        if ( $counter{$key} >= $THRESHOLD) {
            print "  |--- Found KEY Candidate: [$key] - [$counter{$key}] \n";
            $keyfound = $key;
        }
    }
    open(FILE,$ARGV[0]) || die "ERROR unable to read the file\n";
    while(<FILE>) {
        my $reg = $keyfound =~ m/^(.)-(.)(.)(.)(.)/;
        my $regexkey = "$2$3$4$5";
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
