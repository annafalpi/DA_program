: ' 

DATA AUGMENTATION SOFTWARE FAIL : incorrect [INPUT FILE] argument

DATA AUGMENTATION SOFTWARE FAIL : incorrect [METHOD] argument

DATA AUGMENTATION SOFTWARE FAIL : incorrect [optional] argument

'
cat << EOF

DATA AUGMENTATION SOFTWARE FAIL : Not enough input arguments

usage summary: [INPUT FILE] [METHOD] [optional]

OPTIONS:

    - [INPUT]: --> path\file to apply [METHOD].
                --> path\folder to apply [METHOD] for each file.

    - [METHOD]: --> pitch, PITCH or Pitch   : pitch shifting
                --> time, TIME or Time      : time stretching
                --> RIR, rir or Rir,         : RIR generation
                --> noise, NOISE or Noise   : noise adding
                --> masking, MASKING or Masking  : frequency masking

    -[OUT DIR]: --> output dir - DEFAULT: DA_program/DATA_AUGMENTATION - 

    - [optional]:   --> pley            : play generated sample
                    --> wave            : display generated sample wave
                    --> spectrogram     : display generated sample spctrogram

EOF







