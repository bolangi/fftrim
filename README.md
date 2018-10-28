# fftrim - concatenate, trim and compress video files 

## Description

fftrim processes raw videos from a camcorder by
concatenating, trimming and compressing them
according to arguments you supply on the 
command line, or in a CONTROL file. 

## Synopsis
  
### Processing a single file

    fftrim --in 000001.MTS --out output.mp4 --start 15.5 --end 44:13

### Handling concatenated sources

    fftrim --in "000001.MTS 00002.MTS" --out output.mp4 --start 45:13 -- 1+1:12

The expression 1+1:12 means a position in the concatenated
file that includes the full length of the first clip and
1:12 minutes of the second clip. Similarly, 1+2+65 and
1+2+1:05 mean a position of 1:05 into the third clip.
Patches accepted for better syntax.

### Batch mode

    fftrim --source-dir raw --target-dir final

### CONTROL file format

The CONTROL file is used for batch processing
and appears in the same directory as the source
video files. It contains multiple lines
of the following format:


    # source file(s)    output file   start  end
    # ---------------   -----------   -----  ----
    000001.MTS        : part1.mp4   : 15.5 : 44:13 

Arguments are separated by a colon character
flanked by whitespace. Commented lines are ignored.

The following line creates part2.mp4 from source files
000001.MTS and 000002.MTS:

    000001.MTS 000002.MTS : part2.mp4 :  44:13 : 1+24:55 

The extracted video starts 44:13 into the first source file.
and ends at 24:55 into the second file.

### Help 

    fftrim [-cmn] [long options...]
            --source-dir STR  source directory for video clips
            --target-dir STR  target directory for completed files
            --profile STR     use profile in $HOME/.fftrim, otherwise "default"
            --in STR          input file  - single file mode
            --out STR         output file - single file mode
            --start STR       start time  - single file mode
            --end STR         end time    - single file mode
            -n                simulate: show output commands but do not run them
            -m                simulate: show output commands omitting file checks
            -c                conform to source file frame rate
            --help            print usage message and exit

