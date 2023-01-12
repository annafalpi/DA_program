
: ' *********************** PITCH SHIFTING ***********************
pitch_factor
    - number            --> determined value
    - (number number)   --> random value between a tuple.
    - ""                --> random value. -- DEFAULT [-0.5, 2] --
shift_start
    - ini               --> start value at sample beginning.
    - number            --> determined start value. 
    - (number number)   --> random start value between a tuple.
    - ""                --> random start value.
shift_end
    - end               --> end value at sample ending.
    - number            --> determined end value. 
    - (number number)   --> random end value between a tuuple.
    - ""                --> random end value.
'
pitch_factor=(0.9 1)
shift_start=ini
shift_end=end

: ' *********************** TIME STRETCHING  *********************** 
    speed_factor
        - number            --> determined value.
        - (number number)   --> random value between a tuple.
        - ""                --> random value. -- DEFAULT [0.1, 5] --
    stretch_start
        - ini               --> value at sample begining.
        - number            --> determined start value.
        - (number number)   --> random start value between a tuple.
        - ""                --> random  start value.
    stretch_end
        - end               --> end value at sample ending.
        - number            --> determined end value .
        - (number number)   --> random end value between a tuple.
        - ""                --> random end value.  
'
speed_factor=(0.75 1.2)
stretch_start=ini
stretch_end=end

: ' *********************** NOISE ADDING  *********************** 
    NOISE_SAMPLE:
        - ""       --> white noise sample synthetized
        - file.wav --> wav file included in /program_samples.
    ratio:
        - number   --> SNR ratio
        - ""       --> random  value. -- DEFAULT [-6,6] --
'   
NOISE_SAMPLE=""
ratio_dB=""

: ' *********************** RIR FILTER  *********************** 
    RIR_file:
        -file.txt --> txt file included in /program_samples.
'
RIR_file="/program_samples/AIR_Database/"   


: ' *********************** FREQUENCY MASKING *********************** 
    f_centre:
        - number  --> filter centre frequency
        - ""      --> random  value.
    width:
        - number  --> filtre bandwidth
        - ""      --> random  value.
'
f_centre=1000
width=400
