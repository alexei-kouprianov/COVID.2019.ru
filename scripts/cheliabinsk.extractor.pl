#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;

unlink '../downloads/cheliabinsk.COUNT.txt', '../downloads/cheliabinsk.COUNT1.txt', '../downloads/cheliabinsk.NAME.txt', '../downloads/cheliabinsk.AGE.txt', '../downloads/cheliabinsk.CONDITION.txt', '../downloads/cheliabinsk.SOURCE.txt', '../downloads/cheliabinsk.RECOVERED.txt';

my $filename = 'cheliabinsk.raw.txt';
my $filetime = (stat ($filename))[9];
my $datetime = scalar(CORE::localtime($filetime));

my $name = "";
my $count = "";
my $age = "";
my $condition = "";
my $source = "";
my $recovered = "";

open (SRC01, '<cheliabinsk.raw.txt') or die $!;
open (TGT01, '>../downloads/cheliabinsk.nospace.txt') or die $!;
open (TGT011, '>>../downloads/cheliabinsk.nospace.archive.txt') or die $!;
	print TGT011 "\n",$datetime,"\t";
while(<SRC01>){
	s/\s*\<br \/\>/\<br \/\>/g;
	s/\s*\<\/td\>/<\/td\>/g;
	s/\s*\<td /\<td /g;
	s/\s*\<\/tr\>/<\/tr\>/g;
	s/\s*\<tr/\<tr/g;
	s/\n|\r//g;
	my $printout = $_;
	print TGT01 $printout;
	print TGT011 $printout;
}
close(TGT011);
close(TGT01);
close(SRC01);

open (SRC02, '<../downloads/cheliabinsk.nospace.txt') or die $!;
open (TGT02, '>../downloads/cheliabinsk.newlines.txt') or die $!;
while(<SRC02>){
	s/\<td /\n\<td /g;
	s/\<tr/\n\<tr/g;
	s/\<br \/\>\<\/td\>/\<\/td\>/g;
	s/\<br \/\>\<br \/\>/\<br \/\>NA\<br \/\>/g;
	print TGT02 $_;
}
close(TGT02);
close(SRC02);

open (SRC03, '<../downloads/cheliabinsk.newlines.txt') or die $!;
open (COUNT, '>>../downloads/cheliabinsk.COUNT.txt') or die $!;
open (COUNT1, '>>../downloads/cheliabinsk.COUNT1.txt') or die $!;
open (NAME, '>>../downloads/cheliabinsk.NAME.txt') or die $!;
open (AGE, '>>../downloads/cheliabinsk.AGE.txt') or die $!;
open (CONDITION, '>>../downloads/cheliabinsk.CONDITION.txt') or die $!;
open (SOURCE, '>>../downloads/cheliabinsk.SOURCE.txt') or die $!;
open (RECOVERED, '>>../downloads/cheliabinsk.RECOVERED.txt') or die $!;
while(<SRC03>){

	if ($_ =~ m/field-name\"\>(.*)\<\/td\>/){
		$name = $1;
	}

	elsif ($_ =~ m/field-count\"\>(.*)\<\/td\>/){
		$count = $1;
			print COUNT "$count\n";
	}

	elsif ($_ =~ m/field-age\"\>(.*)\<\/td\>/){
		$age = $1;
		$age =~ s/\<br \/\>/\n/g;
		my $count1 = scalar(split('\n',$age));
			print AGE "$age\n";
			print COUNT1 "$count1\n";
				for(my $i=1; $i <= $count1; $i++){
				print NAME "$datetime\t$name\t$count\t$count1\n";
				}
	}

	elsif ($_ =~ m/field-condition\"\>(.*)\<\/td\>/){
		$condition = $1;
		$condition =~ s/\<br \/\>/\n/g;
			print CONDITION "$condition\n";
	}

	elsif ($_ =~ m/field-source\"\>(.*)\<\/td\>/){
		$source = $1;
		$source =~ s/\<br \/\>/\n/g;
			print SOURCE "$source\n";
	}

	elsif ($_ =~ m/field-recovered\"\>(.*)\<\/td\>/){
		$recovered = $1;
		$recovered =~ s/\<br \/\>/\n/g;
			print RECOVERED "$recovered\n";
	}

}
close RECOVERED;
close SOURCE;
close CONDITION;
close AGE;
close NAME;
close COUNT1;
close COUNT;
close SRC03;

# <td headers="view-name-table-column" class="views-field views-field-name">Агаповский муниципальный район</td>
# <td headers="view-field-count-table-column" class="views-field views-field-field-count">32</td>
# <td headers="view-field-age-table-column" class="views-field views-field-field-age">21<br />59<br />30<br />1<br />57<br />69<br />69<br />57<br />55<br />49<br />52<br />20<br />34<br />78<br />32<br />47<br />57<br />67<br />64<br />70<br />42<br />38<br />54<br />80<br />90<br />69<br />64<br />43<br />48<br />45<br />3<br />56</td>
# <td headers="view-field-condition-table-column" class="views-field views-field-field-condition">клиники нет<br />средняя<br />средняя<br />средняя<br />легкая<br />средняя<br />средняя<br />средняя<br />средняя<br />средняя<br />клиники нет<br />клиники нет<br />легкая<br />средняя<br />клиники нет<br />средняя<br />средняя<br />легкая<br />клиники нет<br />клиники нет<br />средняя<br />клиники нет<br />средняя<br />клиники нет<br />клиники нет<br />средняя<br />клиники нет<br />Уточняется<br />Уточняется<br />средняя<br />клиники нет<br />средняя</td>
# <td headers="view-field-source-table-column" class="views-field views-field-field-source">Москва<br />Москва<br />Контакт с больным<br />Контакт с больным<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Контакт с больным<br />Москва<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Контакт с больным<br />Контакт с больным<br />Не контактный, не выезжал<br />Контакт с больным<br />Контакт с больным<br />Не контактный, не выезжал<br />Контакт с больным<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Не контактный, не выезжал<br />Контакт с больным<br />Не контактный, не выезжал</td>
# <td headers="view-field-recovered-table-column" class="views-field views-field-field-recovered">Выписан<br />Выписан<br />Выписан<br />Выписан<br />Выписан<br />Выписан<br />Выписан<br />Выписан<br />Выписан<br />Продолжает лечение<br />Выписан<br />Выписан<br />Выписан<br />Выписан<br />Продолжает лечение<br />Выписан<br />Выписан<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение<br />Выписан<br />Уточняется<br />Продолжает лечение<br />Продолжает лечение<br />Продолжает лечение</td></tr>
