-   [NAME](#NAME)
-   [VERSION](#VERSION)
-   [SYNOPSIS](#SYNOPSIS)
-   [DESCRIPTION](#DESCRIPTION)
-   [Trimming a single file](#Trimming-a-single-file)
-   [Concatenating multiple source
    files](#Concatenating-multiple-source-files)
-   [Batch mode](#Batch-mode)
-   [CONTROL file format](#CONTROL-file-format)
-   [Profiles](#Profiles)
-   [AUTHOR](#AUTHOR)
-   [BUGS](#BUGS)
-   [SUPPORT](#SUPPORT)
-   [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)
-   [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

NAME {#NAME}
====

**fftrim** - a wrapper for trimming and compressing video files using
ffmpeg

VERSION {#VERSION}
=======

Version 0.04

SYNOPSIS {#SYNOPSIS}
========

      # single output file
      
      fftrim --in 00001.MTS --out part1.mp4 --start 15.5 --end 44:13
      
      fftrim --in "00001.MTS 00002.MTS" --out part2.mp4 --start 44:13 --end 2-24:55
      
      # batch mode
      
      fftrim --source-dir raw --target-dir final
      
      # the text file CONTROL in the source directory contains:
      
          00001.MTS           : part1.mp4 :     15.5 :   44:13 
      
          00001.MTS 00002.MTS : part2.mp4 :  44:13   : 2-24:55 

DESCRIPTION {#DESCRIPTION}
===========

**fftrim** processes raw videos from a camcorder by concatenating,
trimming and compressing them according to arguments you supply on the
command line, or in a *CONTROL* file.

Concatenation is performed using ffmpeg's "concat protocol". This
file-level concatenation is suitable for MTS files generated by a Sony
or Pansonic camera.

Trimming a single file {#Trimming-a-single-file}
======================

`fftrim --in 00001.MTS --out part1.mp4 --start 15.5 --end 44:13`

Concatenating multiple source files {#Concatenating-multiple-source-files}
===================================

`fftrim --in "00001.MTS 00002.MTS 00003.MTS" --out part2.mp4 --start 44:13 --end 2-24:55`

`fftrim --in "00001.MTS 00002.MTS 00003.MTS" --out part3.mp4 --start 2-24:55 --end 3-1:05`

The expression `2-24:55` means a position in the concatenated file that
includes the full length of the first clip and 24:55 of the second clip.
Similarly, `3-65` or `3-1:05` would mean a position of 1:05 into the
third clip.

The source files are concatenated into an intermediate file using the
name of the first source file appended with .mp4.

Batch mode {#Batch-mode}
==========

`fftrim --source-dir raw --target-dir final`

It's probably better to try with the -n or -m flag first.

`fftrim -n --source-dir raw --target-dir final`

There is also some simple error checking, and fftrim will abort if
errors are found in the CONTROL file.

CONTROL file format {#CONTROL-file-format}
===================

The CONTROL file used for batch processing appears in the same directory
as the source video files. It contains multiple lines of the following
format:

        # source file(s)    output file   start  end
        # ---------------   -----------   -----  ----
          00001.MTS       : part1.mp4   : 15.5 : 44:13 

Arguments are separated by a colon character flanked by whitespace.
Commented lines are ignored.

The following line creates *part2.mp4* from source files *00001.MTS* and
*00002.MTS*:

        00001.MTS 00002.MTS : part2.mp4 :  44:13 : 2-24:55 

Profiles {#Profiles}
========

*\$HOME/.fftrim* is the directory for profiles, which are text files
containing ffmpeg options.

Adding `--profile highres` to the command line will merge options from
the file *\$HOME/.fftrim/highres* if it exists.

Be sure to look at *\$HOME/.fftrim/default*. These options are are
merged by default, that is when `--profile` is not supplied. Please
change them to suit yourself.

AUTHOR {#AUTHOR}
======

Joel Roth, `<joelz at pobox.com >`

BUGS {#BUGS}
====

Please report any bugs or feature requests to
`bug-app-fftrim at rt.cpan.org`, or through the web interface at
<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-fftrim>. I will be
notified, and then you'll automatically be notified of progress on your
bug as I make changes.

SUPPORT {#SUPPORT}
=======

You can find documentation for this module with the perldoc command.

        perldoc fftrim

You can also look for information at:

-   RT: CPAN's request tracker (report bugs here)

    <https://rt.cpan.org/NoAuth/Bugs.html?Dist=App-fftrim>

-   AnnoCPAN: Annotated CPAN documentation

    <http://annocpan.org/dist/App-fftrim>

-   CPAN Ratings

    <https://cpanratings.perl.org/d/App-fftrim>

-   Search CPAN

    <https://metacpan.org/release/App-fftrim>

ACKNOWLEDGEMENTS {#ACKNOWLEDGEMENTS}
================

Thanks to ffmpeg developers and the community.

LICENSE AND COPYRIGHT {#LICENSE-AND-COPYRIGHT}
=====================

Copyright 2018 Joel Roth.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a copy
of the full license at:

<http://www.perlfoundation.org/artistic_license_2_0>

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
