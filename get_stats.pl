#!/usr/bin/perl
use strict;

if ((scalar @ARGV) != 1){
    print("Please provide the <bamfile>\n");
    exit;
}
open(FILE, "samtools view $ARGV[0] |");

my ($all, $intra, $inter);
my ($intra_1, $intra_10, $intra_15, $intra_20);
while (my $line = <FILE>){
    chomp $line;
    my @liner = split('\t', $line);
    $all++;

    if ($liner[6] eq '='){
        $intra++;
        if (abs($liner[8]) >= 1000) {$intra_1++;}
        if (abs($liner[8]) >= 10000) {$intra_10++;}
        if (abs($liner[8]) >= 15000) {$intra_15++;}
        if (abs($liner[8]) >= 20000) {$intra_20++;}
    }
    else{
        $inter++;
    }
}
close(FILE);

$all      = $all/2;
$intra    = $intra/2;
$intra_1  = $intra_1/2;
$intra_10 = $intra_10/2;
$intra_15 = $intra_15/2;
$intra_20 = $intra_20/2;
$inter    = $inter/2;

print("All\t$all\n");
print("All intra\t$intra\n");
print("All intra 1kb\t$intra_1\n");
print("All intra 10kb\t$intra_10\n");
print("All intra 15kb\t$intra_15\n");
print("All intra 20kb\t$intra_20\n");
print("All inter\t$inter\n");
