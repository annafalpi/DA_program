


: ' ************************************* PITCH SHIFTING  *********************************** 
    pitch_factor
        - number            --> determined value
        - (number number)   --> random value betweeen a touple interval.
        - [""]              --> random value. ------  DEFAULT RANGE BETWEEN [-0.5, 2]  ----------
    shift_start
        - ini               --> start value at sample begining.
        - number            --> determined start value. 
        - (number number)   --> random start value betweeen a touple interval.
        - [""]              --> random start value.
    shift_end
        - end               --> end value at sample ending.
        - number            --> determined end value. 
        - (number number)   --> random end value betweeen a touple interval.
        - [""]              --> random end value.
'
pitch_factor=(0.9 1.1)
shift_start=ini
shift_end=end

: ' ************************************ TIME STRETCHING  *********************************** 
    speed_factor
        - number             --> determined factor value
        - (number number)    --> random factor value betweeen a touple interval.
        - [""]               --> random factor value. ------  DEFAULT RANGE BETWEEN [0.1, 5]  ----------
    stretch_start
        - ini               --> start value at sample begining
        - number            --> determined start value 
        - (number number)   --> random start value betweeen a touple interval.
        - [""]              --> random  start value
    stretch_end
        - end               --> end value at sample ending
        - number            --> determined end value 
        - (number number)   --> random end value betweeen a touple interval.
        - [""]              --> random end value.  
'
speed_factor=""
stretch_start=""
stretch_end=""

: ' ************************************ NOISE ADDING  *********************************** 
    NOISE_SAMPLE:
        -[""]        --> white noise sample synthetized
        -[file.wav] --> wav file included in the program_samples directory.
    ratio:
        - number    --> ratio between signal al noise. Ex. If ratio=3, Signal=3*Noise.
'
NOISE_SAMPLE=""
ratio_dB=-6

#"sound-bible-44100/noise-sound-bible-0014.wav"

: ' ************************************ RIR FILTER  *********************************** 
    RIR_file:
        -[file.txt]  --> txt file included in the program_samples directory.
'
RIR_file="../OUT_program_samples/RIR_files/air_binaural_meeting_1_0_4.txt"   
#air_binaural_meeting_1_0_4.txt

: ' ************************************ FREQUENCY MASKING*********************************** 
    f_centre:
        - number  --> filter centre frequency
    width:
        - number  --> filtre bandwidth
'
f_centre=1000
width=500

