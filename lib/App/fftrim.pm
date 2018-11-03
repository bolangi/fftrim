package fftrim;
use 5.006;
use strict;
use warnings;
use Path::Tiny;
use autodie ':all';
use feature 'say';
use Cwd;
our ($opt, $usage,
	$current_dir,
	$control,
	$control_file,
	$dotdir ,
	$profile,
	$fh,
	$encoding_params,
	%length,
	$framerate,
	$finaldir,
	@lines,
	$is_error,
);
sub process_lines { 
	my $do = shift;
	foreach my $line (@lines){
		$line =~ s/\s+$//;
		say STDERR "line: $line";
		my ($source_files, $target, $start, $end) = split /\s+[:|]\s+/, $line;
		my @source_files = map{ join_path($opt->{source_dir}, $_)} split " ", $source_files;
		$framerate = video_framerate($source_files[0]);
		for (@source_files){
		if ( ! defined $length{$_} )
			{
				my $len = video_length($_);
				$length{$_} = seconds($len);
			}
		}
		say STDERR qq(no target for source files "$source_files". Using source name.) if not $target;
		if ( ! $target ) { 
			$target = to_mp4($source_files[0]);
		}
		else {
			$target = mp4($target) unless $target =~ /\.[a-zA-Z]{3}$/ 
		}
		{
		no warnings 'uninitialized';
		say STDERR "source files: @source_files";
		say STDERR "target: $target";
		say STDERR "start time: $start";
		say STDERR "end time: $end";
		say(STDERR qq(no source files in line!! $line)), $is_error++, if not @source_files;
		my @missing = grep { ! -r } @source_files;
		say(STDERR qq(missing source files: @missing)), $is_error++, if @missing;
		}

		next unless $do;
		my $compression_source;
		if (@source_files > 1)
		{
			my $concat_target = to_mp4($source_files[0]);
			say STDERR "concat target: $concat_target";
			concatenate_video($concat_target, @source_files);
			$compression_source = $concat_target;
		} 
		else 
		{ 
			$compression_source = $source_files[0];
		}
			my $final = trim_target($target); 
			$start = decode_cutpoint($start, \@source_files);
			$end = decode_cutpoint($end, \@source_files);
			say STDERR "decoded start: $start, decoded end: $end";
			compress_and_trim_video(
				$compression_source,
				$final, 
				$start,
				$end
			);
	}
}
=head1 NAME

App::fftrim - The great new App::fftrim!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use App::fftrim;

    my $foo = App::fftrim->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Joel Roth, C<< <joelz at pobox.com > >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-fftrim at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-fftrim>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::fftrim


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=App-fftrim>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-fftrim>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/App-fftrim>

=item * Search CPAN

L<https://metacpan.org/release/App-fftrim>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Joel Roth.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of App::fftrim
