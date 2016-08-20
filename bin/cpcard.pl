#!/usr/bin/perl -w

# use strict;

my %hash = ();

open (my $ref,"<", "../.cpcard") or die "Can't open the file: ";

while (my $line =<$ref>){

chomp ($line);

my ($key)=$line;

$hash{$key}=2;

print "add $key\n"

}
open (my $output, '>', '../.cpdest');
open (my $source,"<", "../.cpsource") or die "Can't open the file: ";

while (my $line =<$source>){

chomp ($line);

my ($key)=$line;


if( exists $hash{$key} ) {
print "$key exists in hash\n";
} else {
print $output "$key\n";
}

}

close $output;

# print "\n";

# while ( my ($key, $val) = each(%hash) ) {

# print "$key => $val\n";

#}
