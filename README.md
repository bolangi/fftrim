# fftrim - concatenate, trim and compress video files 

## Description

fftrim processes raw videos (as from a camcorder) by
concatenating, trimming and compressing them. 

## Synopsis
  
### Single file mode

    fftrim --in 000001.MTS --out output.mp4 --start 15.5 --end 44:13

### Batch mode

    fftrim --source-dir raw --target-dir done

CONTROL file in raw/

    000001.MTS 000002.MTS : middle.mp4 : 15.5 : 44:13 

This line creates middle.mp4 in the target directory
from source files 000001.MTS and 000002.MTS.

    000001.MTS 000002.MTS : end.mp4 :  1+10:13 

Output file end.mp4 is created starting at a position 10:13
into the second sourcefile.

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

