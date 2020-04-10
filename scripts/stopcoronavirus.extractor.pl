#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;

# Fetcher block;

open (TGT00, '>stopcoronavirus.rf.txt') or die $!;
print TGT00 get('https://стопкоронавирус.рф/');
close TGT00;

# Parser block #1;

open (SRC01, '<stopcoronavirus.rf.txt') or die $!;
open (TGT011, '>>stopcoronavirus.storage.cumulative.txt') or die $!;
open (TGT012, '>stopcoronavirus.storage.moment.txt') or die $!;
while (<SRC01>) {
	if($_ =~ m/^.*\#map\_popup/a){
	print TGT011 $_, "\n";
	print TGT012 $_;
	}
}
close TGT011;
close TGT012;
close SRC01;

# Parser block #1;

open (SRC02, '<stopcoronavirus.storage.moment.txt') or die $!;
open (TGT021, '>stopcoronavirus.table.moment.txt') or die $!;
open (TGT022, '>>stopcoronavirus.table.cumulative.txt') or die $!;
while (<SRC02>) {
	if($_ =~ m/\<\/h[2]\>\<span\>.*? (\d\d.* ?\d\d)(\<\/span\>)/a){  # matches date-time;
	print TGT021 $1, "\n";
	print TGT022 $1, "\n";
	}
	s/(?<=\d) (?=\d)|\<\/th\>|\<div class\=\.cv-section__action.*d-map__list.\>\<table\>\<tr\>|\<\/td\>\<\/tr\>\<tr\>|\<\/td\>\<\/tr><\/table\>.*//g; # substitutes lots of things;
	s/\<td\>.*?\<\/span\>|\<\/td\>.*?\<\/span\>/\t/g; # inserts tabs;
	s/\<th\>/\n/g; # cuts into new lines;
	print TGT021 $_, "\n";
	print TGT022 $_, "\n";
}
close TGT021;
close TGT022;
close SRC02;

open (SRC03, '<stopcoronavirus.table.moment.txt') or die $!;
open (TGT03, '>stopcoronavirus.table.moment.sorted.txt') or die $!;
	print TGT03 sort <SRC03>; 
close TGT03;
close SRC03;

open (SRC03, '<stopcoronavirus.table.moment.sorted.txt') or die $!;
open (TGT03, '>stopcoronavirus.table.moment.expanded.txt') or die $!;
	while (<SRC03>) {
		if($_ =~ m/^(.*?)\t(\d*)\t(\d*)\t(\d*)/a){
		print TGT03 "detected\t$1\t$2\nrecovered\t$1\t$3\ndeceased\t$1\t$4\n"; 
		}
	}
close TGT03;
close SRC03;


