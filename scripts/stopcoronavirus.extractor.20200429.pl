#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;
use IO::Compress::Gzip qw(gzip $GzipError) ;

# 20200429 in the filenames = the date when https://стопкоронавирус.рф/ changed their reporting format;

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
my $inputfile = '../downloads/stopcoronavirus.storage.cumulative.20200429.txt';
my $outputfile = '../downloads/stopcoronavirus.storage.cumulative.20200429.txt.gz';

open (SRC01, '<stopcoronavirus.rf.20200429.txt') or die $!;
open (TGT011, '>>../downloads/stopcoronavirus.storage.cumulative.20200429.txt') or die $!;
open (TGT012, '>../downloads/stopcoronavirus.storage.moment.20200429.json') or die $!;
open (TGT013, '>../downloads/stopcoronavirus.timestamp.moment.20200429.txt') or die $!;
while (<SRC01>) {
	if($_ =~ m/.*<small\>(\xd0\x9f\xd0\xbe\x20\xd1\x81\xd0\xbe\xd1\x81\xd1\x82\xd0\xbe\xd1\x8f\xd0\xbd\xd0\xb8.*) (\d*)\:(\d\d)\<\/small\>/a){
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
}
	print TGT011 $string, "\t", '"', $YYYY, "-", $MM, "-", $DD, " ", $hh, ':', $mm, ':00"', "\t", $JSON, "\n";
	print TGT012 $JSON, "\n";
	print TGT013 '"', $YYYY, "-", $MM, "-", $DD, " ", $hh, ':', $mm, ':00"', "\n";
close TGT013;
close TGT012;
close TGT011;
close SRC01;

my $status = gzip $inputfile => $outputfile
        or die "gzip failed: $GzipError\n";
