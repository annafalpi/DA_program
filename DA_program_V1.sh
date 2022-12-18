. ./program/functions
. ./program/error_control
. ./program/system_functions.sh

source ./configuration.sh

DIR="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )"
root=$DIR
#CHECK CONFIGURATION
check_configuration $2


folder_name='DATA_AUGMENTATION' 
create_folder $DIR $folder_name
DIR=$DIR/DATA_AUGMENTATION


cd $root
if [ ! -d $root/temp ]; then
    mkdir temp
fi  

cd $root

echo "ARGUMENTS: " $1 $2 $3 $4

out_dir=$3
aux=$1


if [ "$1" = '-h' ] || [ "$1" = '-help' ] || [ "$1" = 'help' ] || [ "$1" = '' ]; then
    ./program/usage.sh
    exit
fi

if [ -z $1 ]; then
    ./program/usage.sh
elif [ -f $1 ]; then
    cd $root
    define_out_dir $out_dir
    echo "DIR : " $DIR "FOLDER NAME: " $folder_name
    
    n=$1
    if [ "${n##*.}" != 'wav' ]; then
        echo "Input is not .wav file. It must be converted"
        echo "CAUTION: ORIGINAL FILE WILL BE REMOVED!!"
        echo "Do you want to convert it? (y/n)"
        read permision
    fi
    workingDIR=${n%/*}                                              #directori d¡on entren les mostres                     
    n=$(basename $n)
    cd $root/$workingDIR                                        
    EXTENSION_2_WAV
    file="${n%.*}".wav

    if [ -z $2 ] && [ $1 ]; then
        DA_method_error
    elif [ $2 = "pitch" ]; then                           # APLICAR PITCH SHIFT I GUARDAR-HO EN UNA CARPETA
        cd $root
        echo "********* PITCH SHIFTING CONFIGURATION: ******** "
        sed -n '20,22p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR
        ID=$2
        check_time_limits $ID $file $shift_start $shift_end    
        pitch_shifting $file $out_dir                       #Per poder aplicar correctament el input de la funció
     
    elif [ $2 = "time" ]; then
        cd $root
        echo "********* TIME STRETCHING CONFIGURATION: ******** "
        sed -n '40,42p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR 
        ID=$2
        check_time_limits $ID $file $stretch_start $stretch_end    
        time_scretching $file
    
    elif [ $2 = "noise" ]; then
        cd $root
        echo "********* NOISE ADDING CONFIGURATION: ******** "
        sed -n '51,52p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        noise_adding $file

    elif [ $2 = "RIR" ];then
        cd $root
        echo "********* RIR FILTER CONFIGURATION: ******** "
        sed -n '56,56p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        FIR_conv $file

    elif [ $2 = "masking" ];then
        cd $root
        echo "********* FREQUENCY MASKING CONFIGURATION******** "
        sed -n '65,66p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        freq_masking $file
    else
        DA_method_error
    fi

    outfile=$DIR/$folder_name/$file


elif  [ -d $1 ]; then 
    define_out_dir $out_dir

    cd $root/$1
    workingDIR=$1
    counter=0
    for n in *; do
        if [ "${n##*.}" != 'wav' ]; then
           let counter=counter+1
        fi
    done
    if [ $counter -gt 0 ]; then
            echo "Some input files in " $workingDIR "are not .wav file. They must be converted"
            echo "CAUTION: ORIGINAL FILE WILL BE REMOVED!!"
            echo "Do you want to convert them? (y/n)"
            read permision
    fi
    for n in *; do
        EXTENSION_2_WAV
    done
    
    if [ -z $2 ] && [ $1 ]; then
        DA_method_error
    elif [ $2 = "pitch" ]; then
        cd $root
        echo "********* PITCH SHIFTING CONFIGURATION: ******** "
        sed -n '20,22p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR
        ID=$2
        for file in *.wav; do
            check_time_limits $ID $file $shift_start $shift_end   
            pitch_shifting $file
        done

    elif [ $2 = "time" ]; then
        cd $root
        echo "********* TIME STRETCHING CONFIGURATION: ******** "
        sed -n '40,42p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        ID=$2
        for file in *.wav; do
            check_time_limits $ID $file $strech_start $stretch_end   
            time_scretching $file
        done

    elif [ $2 = "noise" ]; then
        cd $root
        echo "********* NOISE ADDING CONFIGURATION: ******** "
        sed -n '51,52p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            noise_adding $file
        done
    elif [ $2 = "RIR" ];then
        cd $root
        echo "********* RIR FILTER CONFIGURATION: ************* "
        sed -n '56,56p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            FIR_conv $file
        done

    elif [ $2 = "masking" ];then
        cd $root
        echo "********* FREQUENCY MASKING CONFIGURATION******** "
        sed -n '65,66p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            freq_masking $file
        done
    else
        DA_method_error
    fi
    outfile=$DIR/$folder_name/$file
else
    IN_FILE_error
fi


if [ $4 ]; then   
    if [ $4 =  "wave" ] || [ $4 =  "spectrogram" ]; then
        python3 $root/program/spectrogram.py $outfile $4
        #echo "NOT YET"
    elif [ $4 = "pley" ]; then
        cd $DIR/$folder_name
        pley $(basename $outfile)
    else
    IN_OPTION_error
    fi
fi
