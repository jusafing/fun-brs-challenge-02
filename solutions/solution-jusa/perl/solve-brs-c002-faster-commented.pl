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
## Function to Pre-process ALL the data within the file. It stores in a HASH
## all the sets of strings with THREE fixed characters and increases its
## counter on each ocurrence. Later on this number is the filter used to find
## potential keys. In order to make unique keys, it adds an index at the
## beggining of each key with the position of the dynamic key character, and
## a dot "." to use a regex afterwards.

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
## This funtion processes the potential candidates. For each of them it looks
## line by line and processes the parts according with the counter and index
## FASTER: The difference with "solve-brs-c002-all" script is that this
##         funtion does NOT lok for "all" potentil candidates. It assumes that
##         there is only ONE candidate with the filters on the regex, so that
##         on each processed line of the file only look ONE regex. Note the
##         absence of the foeach within the loop that read the file
##         ( while(<FILE>) )

sub processCandidates  {
    my %keysok      = ();
    my $keyfound    ;
    foreach my $key ( keys%{counter} ) {
        if ( $counter{$key} >= $THRESHOLD) {
            print "  |--- Found KEY Candidate: [$key] - [$counter{$key}] \n";
            # It assumes only ONE key with at least 40 hits
            $keyfound = $key;
        }
    }
    open(FILE,$ARGV[0]) || die "ERROR unable to read the file\n";
    while(<FILE>) {
        # It Only uses ONE reges line by line
        my $reg = $keyfound =~ m/^(.)-(.)(.)(.)(.)/;
        my $regexkey = "$2$3$4$5";
        my $pat = $_ =~ m/$regexkey([0-9]*)\|(.*)/;
        if ($pat && $DEBUG) {
            print "  |   \\--- Part [$1]-> [$2]\n" ;
        }
        $keysok{$regexkey}{$1} = $2 if ($pat);
    }
    close(FILE);
    # Show the results
    foreach my $key (keys%{keysok}) {
        print "  |\n  |   \\--- Message from key [$key] : ";
        foreach my $part (sort {$a<=>$b} keys%{$keysok{$key}}) {
            print "$keysok{$key}{$part}";
        }
        print "\n";
    }
}
