


: ' ************************************* PITCH SHIFTING  *********************************** 
    shift_mode:
        - [random]  --> applies random values of    [pitch_factor] , [shift_start] and [shift_end]
        - [fixed]   --> applies values specified in [pitch_factor] , [shift_start] and [shift_end] 
    pitch_factor
        - number    --> pitch shifting value
    shift_start
        - number    --> pitch shifting start value 
        - [""]      --> pitch shifting start value at sample begining
    shift_end
        - number    --> pitch shifting end value 
        - [""]      --> pitch shifting end value at sample ending
'
shift_mode='fixed'
pitch_factor=1.5
shift_start=5
shift_end=9

: ' ************************************ TIME STRETCHING  *********************************** 
    stretch_mode:
        - [random]  --> applies random values of    [pitch_factor] , [shift_start] and [shift_end]
        - [fixed]   --> applies values specified in [pitch_factor] , [shift_start] and [shift_end] 
    speed_factor
        - number    --> pitch shifting value
    stretch_start
        - number    --> pitch shifting start value 
        - [""]      --> pitch shifting start value at sample begining
    stretch_end
        - number    --> pitch shifting end value 
        - [""]      --> pitch shifting end value at sample ending
'
stretch_mode='fixed'
speed_factor=0.7 
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
ratio=3


: ' ************************************ RIR FILTER  *********************************** 
    NOISE_SAMPLE:
        -[file.txt]  --> txt file included in the program_samples directory.
'
RIR_file="RIR_files/air_binaural_meeting_1_0_4.txt"

: ' ************************************ CHORUS EFFECT *********************************** 
    delay, decay, speeed, depth:
        - [""]        --> random delay value
        - [number]    --> fixed delay nymber
    wave_type:
        - [t]         --> modulation with triangular wave
        - [s]         --> modulation with sinusoidal wave
    '
delay=3
decay=""
speed="" 
depth=""
wave_type='t'


reverberance=""


# ******* ROOM SIMULATION ********

export s_x=2                # Source position [x y z] (m)
export s_y=3.5
export s_z=2    

export L_x=5                # Room dimensions [x y z] (m)
export L_y=4
export L_z=6
  
export r1_x=5                # Receiver position(s) [x y z] (m)
export r1_y=4
export r1_z=6 

export r2_x=2                # Receiver position(s) [x y z] (m)
export r2_y=1.5
export r2_z=2  

export reverberation_time=0.3
 
