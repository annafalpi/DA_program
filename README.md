# DA_program

IMPORTANT: heu de tenir baixada l'eina SOX al linux.

El programa funciona en dos fases:
- Primerament, s'ha de configurar els paràmetres de la DATA AUGMENTATION. Veureu que hi ha un script anomenat "configuration.sh" on s'indiquen quins paràmetres s'han de configurar per cada mètode. Per exemple:


    #    : ' ************************************ NOISE ADDING  *********************************** 
    #    NOISE_SAMPLE:
    #        -[""]        --> white noise sample synthetized
    #        -[file.wav] --> wav file included in the program_samples directory.
    #    ratio:
    #        - number    --> ratio between signal al noise. Ex. If ratio=3, Signal=3*Noise.
    #   '
    # NOISE_SAMPLE="sound-bible/noise-sound-bible-0014.wav"
    # ratio=3

En aquest cas es fa ús d'un soroll que es troba a la biblioteca de mostres del programa "program_samples".  Podeu variar la mostra de soroll indicant una de les que hi ha a la carpeta.

Hi ha una configuració ja feta, així que podeu començar a provar execucions sense patir.

- En segon lloc, s'ha d'executar el programa via terminal amb la comanda " ./DA_program_v1.sh" + dos arguments obligatoris:
$1: Fitxer o carpeta on vulgueu aplicar DA. Si els fitxers no son .wav el programa els convertirà.
$2: mètode de DA. 
Si executeu el programa sense arguments us saltarà l'ajuda per veure quins arguments posar.


    DATA AUGMENTATION SOFTWARE FAIL : Not enough input arguments

    usage summary: [INPUT FILE] [METHOD] [optional]

    OPTIONS:

    - [INPUT FILE]: --> file.wav or file.mp3 to apply [METHOD]
                    --> folder to apply [METHOD] for each file.wav or file.mp3

    - [METHOD]:     --> pitch  : pitch shifting
                    --> time   : time stretching
                    --> RIR   : RIR generation
                    --> noise  : noise adding
                    --> chorus : chorus efect
                    --> delay  : delay efect
                    --> reverb : reverb efect


    - [optional]:   --> pley            : play generated sample
                    --> wave            : display generated sample wave
                    --> spectrogram     : display generated sample spctrogram


Opcionalment, hi ha un tercer argument que permet escoltar o mostrar la forma d'ona o l'espectrograma del senyal generat. L'ona i l'espectrograma no funcionen encara en aquesta versió. Pot ser que, depèn de si utilitzeu linux pur o una màquina virtual, la comanda pley no funcioni i /o doni error. Podeu escoltar el resultat amb un reproductor convencional.

Us he deixat algunes mostres a la carpeta "original_samples" per si voleu provar-ho. Jo acostumo a copiar-les a "input_files" perquè el programa reemplaça tots els fitxers .mp3 i .raw a .wav. i així no perdo les mostres "originals".


PROGRAM SAMPLES:
- RIR - Originalment estaven en format .mat, les he convertit via Matlab a txt.
- Noise.

MÈTODES FUNCIONANT:
- Pitch shifting
- Time stretching
- Noise adding
- RIR filter
