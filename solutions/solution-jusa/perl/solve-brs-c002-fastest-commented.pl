#!/usr/bin/perl -w
use strict;
###############################################################################
# Name      : solve-brs-c002-fastest.pl 
# Author    : Javier S.A. [jusafing@gmail.com] (February 2017)
# Summary   : This script solves the challenge [brs-challenge-002]
#             It read a file with random strings and finds ALL the potential
#             key candidates that match the characteristics in the README File
#             of the instructions of the challenge. It does everythhing in an
#             automated way.
#
# Syntax    : $ ./solve-brs-c002-fastest.pl DATA_FILE
###############################################################################
my $DEBUG       = 1;
###############################################################################

processCandidates();

###############################################################################
## This funtion processes the potential candidates. For each of them it looks
## line by line and processes the parts according with the counter and index.
## It uses the results of previous executions of funtion "preProcessData"
## included in the other scripts. This gives the knowledge of the KEY "x.-#".
## After this, it manually sets the regex used as key to filter out the chunks
## of the hidden messsage.

sub processCandidates  {
    my %keysok    = ();
    # Manually set the regex of the key
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
