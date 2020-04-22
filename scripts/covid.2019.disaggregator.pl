#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;

my $repeat = "";
my $string = "";

if(-e '../data/momentary.da.txt'){
	unlink('../data/momentary.da.txt');
}

open(AGGR, '<../data/momentary.txt') or die $!;
open(DISAGGR, '>>../data/momentary.da.txt') or die $!;
	while(<AGGR>){
		$string = $_;
		if($_ =~ m/^(TIMESTAMP.*NUMBER)/){
		print DISAGGR $1, "\n";
		}
		elsif($_ =~ m/^(\"[2][0].*?\t[dr].*?\t[A-Z].*?\t.*?\t.*?\t)(\d*?)\t.*/){
		$string = $1;
		$repeat = $2;
			for(my $i=1; $i <= $repeat; $i++){
			print DISAGGR $string, $repeat, "\n";
			}
		}
	}
close(DISAGGR);
close(AGGR);
