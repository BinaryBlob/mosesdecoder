#!/usr/bin/perl 

use strict;
use File::Basename;

sub Beautify($);

Beautify("/home/hieu/workspace/github/hh");

sub Beautify($)
{
	my $path = shift;
	opendir(DIR, $path) or die "Can't open the current directory: $!\n";

	# read file/directory names in that directory into @names 
	my @names = readdir(DIR) or die "Unable to read current dir:$!\n";

	foreach my $name (@names) {
		 next if ($name eq ".");
		 next if ($name eq "..");
		 next if ($name eq "boost");
		 next if ($name eq "contrib");
		 next if ($name eq "jam-files");
		 next if ($name eq ".git");
		 next if ($name eq "util");
		 next if ($name eq "lm");
		 next if ($name eq "search");

		 $name = $path ."/" .$name;
		 if (-d $name) {
		    print STDERR "Into: $name \n";
		    Beautify($name);
		 }
		 else {            # is this a directory?
		    (my $nameOnly, my $pathOnly,my $suffix) = fileparse($name,qr"\..[^.]*$");
		    if ($suffix eq ".cpp" || $suffix eq ".h") {
		      my $cmd = "astyle --style='k&r' -s2 -v $name";
		      #print STDERR "Executing: $cmd \n";
		      `$cmd`;
		    }
		 }
	}

	closedir(DIR);
}

