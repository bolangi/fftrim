# fftrim - trim and compress video files 

## Synopsis
  
### Single file mode

    fftrim --in 000001.MTS --out output.mp4 --start 15.5 --end 44:13

### Batch mode

fftrim --source-dir raw --target-dir=done

CONTROL file in raw/

    000001.MTS 000002.MTS : output : 15.5 : 44:13 

This line creates output.mp4 in the target directory
from source files 000001.MTS and 000002.MTS.
