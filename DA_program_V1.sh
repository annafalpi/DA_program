. ./program/functions

source ./configuration.sh

DIR="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )"
root=$DIR
#CHECK CONFIGURATION
check_configuration


aux=`echo "l($pitch_factor)/l(2)" | bc -l`
cents=`echo "1200*$aux" | bc` 


folder_name='DATA_AUGMENTATION' 
create_folder $DIR $folder_name
DIR=$DIR/DATA_AUGMENTATION

folder_name='temp'
create_folder $DIR $folder_name

cd $root

#echo "ARGUMENTS: " $1 $2 $3

if [ "$1" = '-h' ] || [ "$1" = '-help' ] || [ "$1" = 'help' ] || [ "$1" = '' ]; then
    ./program/usage.sh
    exit
fi

if [ -z $1 ]; then
    ./program/usage.sh
elif [ -f $1 ]; then
    cd $root
    
    n=$1
    if [ "${n##*.}" != 'wav' ]; then
        echo "Input is not .wav file. It must be converted"
        echo "CAUTION: ORIGINAL FILE WILL BE REMOVED!!"
        echo "Do you want to convert it? (y/n)"
        read permision
    fi
    workingDIR=${n%/*}
    n=$(basename $n)
    cd $root/$workingDIR
    EXTENSION_2_WAV
    file="${n%.*}".wav
    echo $file

    if [ -z $2 ] && [ $1 ]; then
        DA_method_error
    elif [ $2 = "pitch" ]; then                           # APLICAR PITCH SHIFT I GUARDAR-HO EN UNA CARPETA
        cd $root
        echo "********* PITCH SHIFTING CONFIGURATION: ******** "
        sed -n '17,20p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR
        pitch_shifting $file                        #Per poder aplicar correctament el input de la funció
     
    elif [ $2 = "time" ]; then
        cd $root
        echo "********* TIME STRETCHING CONFIGURATION: ******** "
        sed -n '35,38p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR       
        time_scretching $file
    
    elif [ $2 = "noise" ]; then
        cd $root
        echo "********* NOISE ADDING CONFIGURATION: ******** "
        sed -n '45,46p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        noise_adding $file

    elif [ $2 = "RIR" ];then
        cd $root
        echo "********* RIR FILTER CONFIGURATION: ******** "
        sed -n '53,53p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        FIR_conv $file

    elif [ $2 = "chorus" ];then
        echo "NOT YET"
        #chorus_efect $file

    elif [ $2 = "delay" ];then
        echo "NOT YET"
        #delay_effect $file

    elif [ $2 = "reverb" ];then
        echo "NOT YET"
        #reverb_effect $file
    else
        DA_method_error
    fi
    outfile=$DIR/$folder_name/$file

elif  [ -d $1 ]; then 
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
        sed -n '17,20p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR
        for file in *.wav; do
            pitch_shifting $file
        done

    elif [ $2 = "time" ]; then
        cd $root
        echo "********* TIME STRETCHING CONFIGURATION: ******** "
        sed -n '35,38p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            time_scretching $file
        done

    elif [ $2 = "noise" ]; then
        cd $root
        echo "********* NOISE ADDING CONFIGURATION: ******** "
        sed -n '45,46p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            noise_adding $file
        done
    elif [ $2 = "RIR" ];then
        cd $root
        echo "********* RIR FILTER CONFIGURATION: ************* "
        sed -n '53,53p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            FIR_conv $file
        done

    elif [ $2 = "chorus" ];then
        echo "NOT YET"
        #for file in *.wav; do
        #    chorus_efect $file
        #done

    elif [ $2 = "delay" ];then
        echo "NOT YET"
        #for file in *.wav; do
        #    delay_effect $file
        #done

    elif [ $2 = "reverb" ];then
        echo "NOT YET"
        #for file in *.wav; do
        #    reverb_effect $file
        #done

    else
        DA_method_error
    fi
    outfile=$DIR/$folder_name/$file
else  
    IN_FILE_error
fi


if [ $3 ]; then   
    if [ $3 =  "wave" ] || [ $3 =  "spectrogram" ]; then
        #python3 $root/program/spectrogram.py $file $3
        echo "NOT YET"
    elif [ $3 = "pley" ]; then
        pley $outfile
    else
    IN_OPTION_error
    fi
fi
