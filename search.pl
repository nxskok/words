use strict;
#use warnings;
use 5.010;
use Data::Dumper;

main(@ARGV);

sub main {
    my ($search,$extra)=@_;
    $search=uc $search;
    my $search_count=word_to_hash($search);
    my $search_length=length $search;
    my $count=0;
    open my $in, "<", "words.txt";
    while (<$in>) {
	chomp;
	my $thisword=$_;
	next unless length($thisword)==$search_length+$extra;
	my $word_count=word_to_hash($thisword);
	my $ok=1;
	my $extras="";
	for my $i (keys %{$search_count}) {
	    $ok=0 if $word_count->{$i}<$search_count->{$i};
	}
        next unless $ok;
	for my $i (keys %{$word_count}) {
	    my $extra_count=$word_count->{$i}-$search_count->{$i};
	    $extras.=($i x $extra_count) if $extra_count>0;
	}
	say "$thisword ($extras)";
    }
}

sub word_to_hash {
    my ($word)=@_;
    my @schars=split "", $word;
    my %cc;
    for my $i (@schars) {
	$cc{$i}++;
    }
    return \%cc;
}
