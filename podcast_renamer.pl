#!/usr/bin/perl
#
# Podcast renamer by simon avery
# To rename MP3 files downloaded with podget into human readable format, and add a date to make them unique.
#

my $dir = "/tv/Stuff/";   # Directory where to downloaded files are. Ends with /
my $backup_dir = "/tv/Stuff/To_Archive/"; # Where to COPY the finished files once renamed
my $move_dir = "/data/books/"; # Where to MOVE the finished files once renamed and copied to backup

##############

use MP3::Tag;
use File::Copy;

my($day, $month, $year)=(localtime)[3,4,5];
$year += 1900;
my $datestr = "$day-$month-$year";

opendir(DH, $dir);
my @files = readdir(DH);
closedir(DH);

foreach my $file (@files) 	{
	 next if($file =~ /^\.$/);  # cwd
	next if($file =~ /^\.\.$/); # topdir
	next if($file !~ /.mp3$/i); # Not an mp3

	my $mp3 = MP3::Tag->new($dir . $file);
	my ($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();
	$mp3->get_tags(); # read tags

	my $newfilename = $title ."_" . $datestr . ".mp3";

	$newfilename =~ s/[^[:ascii:]]+//g;  # get rid of non-ASCII characters
	$newfilename =~ s/\ /_/g;  # replace spaces with -'s for easier filename handling
	$newfilename =~ s/[^A-Za-z0-9._-]//g; # Ascii, but not filenames

	# Copy to backup dir
	copy($dir . $file , $backup_dir . $newfilename) or die "Copy failed: $!";
	# Move to target dir
	move($dir . $file , $move_dir . $newfilename) or die "Copy failed: $!";

}
