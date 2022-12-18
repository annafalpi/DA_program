: ' 

DATA AUGMENTATION SOFTWARE FAIL : incorrect [INPUT FILE] argument

DATA AUGMENTATION SOFTWARE FAIL : incorrect [METHOD] argument

DATA AUGMENTATION SOFTWARE FAIL : incorrect [optional] argument

'
cat << EOF

DATA AUGMENTATION SOFTWARE FAIL : Not enough input arguments

usage summary: [INPUT FILE] [METHOD] [optional]

OPTIONS:

    - [INPUT FILE]: --> file.wav or file.mp3 to apply [METHOD]
                    --> folder to apply [METHOD] for each file.wav or file.mp3

    - [METHOD]:     --> pitch  : pitch shifting
                    --> time   : time stretching
                    --> RIR   : RIR generation
                    --> noise  : noise adding
                    --> masking  : frequency masking
                    --> chorus : chorus efect
                    --> delay  : delay efect
                    --> reverb : reverb efect


    - [optional]:   --> pley            : play generated sample
                    --> wave            : display generated sample wave
                    --> spectrogram     : display generated sample spctrogram

EOF







