#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;
use IO::Compress::Gzip qw(gzip $GzipError) ;

my $repeat = "";
my $string = "";
my $inputfile = '../data/momentary.da.txt';
my $outputfile = '../data/momentary.da.txt.gz';

if(-e '../data/momentary.da.txt'){
	unlink('../data/momentary.da.txt');
}

open(AGGR, '<../data/momentary.txt') or die $!;
open(DISAGGR, '>>../data/momentary.da.txt') or die $!;
	while(<AGGR>){
		$string = $_;
		if($_ =~ m/^(\"TIMESTAMP.*NUMBER\")/){
		print DISAGGR $1, "\n";
		}
		elsif($_ =~ m/^(\"[2][0].*?\t\"[dr].*?\t\"[A-Z].*?\t.*?\t.*?\t)(\d*?)\t.*/){
		$string = $1;
		$repeat = $2;
			for(my $i=1; $i <= $repeat; $i++){
			print DISAGGR $string, $repeat, "\n";
			}
		}
	}
close(DISAGGR);
close(AGGR);

my $status = gzip $inputfile => $outputfile
        or die "gzip failed: $GzipError\n";
