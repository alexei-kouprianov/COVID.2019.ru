#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;

# Fetcher block;

open (TGT00, '>stopcoronavirus.rf.20200429.txt') or die $!;
print TGT00 get('https://стопкоронавирус.рф/information/');
close TGT00;

# Parser block #1;

my $string = "";
my $hh = "";
my $mm = "";
my $DD = "";
my $MM = "";
my $YYYY = "";
my $JSON = "";

open (SRC01, '<stopcoronavirus.rf.20200429.txt') or die $!;
open (TGT011, '>>../downloads/countries/Russia/stopcoronavirus.storage.cumulative.20200429.txt') or die $!;
open (TGT012, '>../downloads/countries/Russia/stopcoronavirus.storage.moment.20200429.json') or die $!;
open (TGT013, '>../downloads/countries/Russia/stopcoronavirus.timestamp.moment.20200429.txt') or die $!;
while (<SRC01>) {
	if($_ =~ m/\<h1 class\=\"cv\-section__title\"\>.*? \<br\>\<small\>(.*? )(\d*)\:(\d\d)\<\/small\>/a){
		$string = $1;
		$hh = $2;
		$mm = $3;
	}
	elsif($_ =~ m/^.*?\<cv\-stats\-virus \:stats\-data\=\'.*\:charts\-data\=\'\[\{\"date\"\:\"(\d*)\.(\d*)\.(202\d)"/a){
		$DD = $1;
		$MM = $2;
		$YYYY = $3;
	}
	elsif($_ =~ m/^.*?\<cv\-spread\-overview \:spread\-data\=\'(\[.*\])/a){
		$JSON = $1;
	}
	print TGT011 $_, "\n";
	print TGT012 $_;
	
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

^.*?\<cv\-stats\-virus \:stats\-data\=\'.*\:charts\-data\=\'\[\{\"date\"\:\"(\d\d)\.(\d\d)\.(\d\d\d\d)\"
^.*?\<cv\-spread\-overview \:spread\-data\=\'(\[.*\])

