#!/usr/bin/perl
#Data: 28.06.2015
#Struktura pliku to: WP_20150606_14_55_00_Pro.jpg lub 20130623_113501.jpg lub 20130719_190154.mp4

use strict;
use warnings;

my $src_dir = "*****";
my $dst_dir = "****";
log_to_file("\n\n");

opendir(DIR, $src_dir) || die "can't opendir $src_dir: $!";
foreach ( readdir(DIR) ) {
#	if( $_ =~ m#WP_((\d{8})_\d{2}_\d{2}_\d{2})_Pro.jpg# ) {
	if( $_ =~ m#((\d{8})_\d{6})# ) {
		my $dir_path = join("",$dst_dir, $2); 
		print "$dir_path\n";
		mkdir $dir_path, 0705;
		if( system("cp $src_dir/$_ $dir_path") == 0 ) {
			log_to_file("Successfully copy $dir_path/$_");
			system("rm -f $src_dir/$_");
		} else {
			log_to_file("Error copy $dir_path/$_");
		}
	}
}
closedir(DIR);


sub log_to_file {
	my $log_file = "/var/log/SCRIPT_LOGS/copy_photos.txt";
	open( LOG_FILE, '>>', $log_file) || die "Could not open file '$log_file' $!";
	print LOG_FILE "@_\n";
	close LOG_FILE;
}
