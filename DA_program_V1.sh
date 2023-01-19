. ./program/functions
. ./program/error_control
. ./program/system_functions.sh

source ./configuration_experiment.sh
#source ./configuration.sh

DIR="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )"
root=$DIR
#CHECK CONFIGURATION
check_configuration


folder_name='DATA_AUGMENTATION' 
create_folder $DIR $folder_name
DIR=$DIR/DATA_AUGMENTATION


cd $root
if [ ! -d $root/temp ]; then
    mkdir temp
fi  

cd $root

#echo "ARGUMENTS: " $1 $2 $3 $4

out_dir=$3



if [ "$1" = '-h' ] || [ "$1" = '-help' ] || [ "$1" = 'help' ] || [ "$1" = '' ]; then
    ./program/usage.sh
    exit
fi

n=$1

if [ -z $1 ]; then
    ./program/usage.sh
elif [[ -f $1 ]] && [[ "${n##*.}" != 'txt' ]] ; then
    #echo "Working with a non txt"
    cd $root
    define_out_dir $out_dir
    #echo "DIR : " $DIR "FOLDER NAME: " $folder_name
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
    elif [ $2 = "pitch" ] || [[ $2 = "PITCH" ]] || [[ $2 = "Pitch" ]] ; then                           # APLICAR PITCH SHIFT I GUARDAR-HO EN UNA CARPETA
        cd $root
        echo "********* PITCH SHIFTING CONFIGURATION: ******** "
        sed -n '18,20p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR
        ID=$2
        check_time_limits $ID $file $shift_start $shift_end    
        pitch_shifting $file $out_dir                       #Per poder aplicar correctament el input de la funció
     
    elif [[ $2 = "time" ]] || [[ $2 = "TIME" ]] || [[ $2 = "Time" ]]  ;  then
        cd $root
        echo "********* TIME STRETCHING CONFIGURATION: ******** "
        sed -n '38,40p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR 
        ID=$2
        check_time_limits $ID $file $stretch_start $stretch_end    
        time_scretching $file
    
    elif [ $2 = "noise" ] || [[ $2 = "NOISE" ]] || [[ $2 = "Noise" ]] ; then
        cd $root
        echo "********* NOISE ADDING CONFIGURATION: ******** "
        sed -n '50,51p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        noise_adding $file

    elif [ $2 = "RIR" ] || [[ $2 = "rir" ]] || [[ $2 = "Rir" ]] ;then
        cd $root
        echo "********* RIR FILTER CONFIGURATION: ******** "
        sed -n '57,57p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        FIR_conv $file

    elif [ $2 = "masking" ] || [[ $2 = "MASKING" ]] || [[ $2 = "Masking" ]] ;then
        cd $root
        echo "********* FREQUENCY MASKING CONFIGURATION******** "
        sed -n '68,69p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        freq_masking $file
    else
        DA_method_error
    fi
    outfile=$DIR/$folder_name/$file

elif [[ -f $1 ]] && [[ "${n##*.}" == "txt" ]] ; then
    if [ -z $3 ]; then
        echo "LIST INPUT ONLY WORKS WITH OUTPUT FOLDER ($\3) SPECIFICATION"
        exit
    fi
    define_out_dir $out_dir
    cd $root
    if [ -z $2 ] && [ $1 ]; then
        DA_method_error
    else
        : '
        if [ $2 = "pitch" ]; then
            cd $root
            echo "********* PITCH SHIFTING CONFIGURATION: ******** "
            sed -n '20,22p' ./configuration.sh
            echo "************************************************ "
        elif [ $2 = "time" ]; then
            cd $root
            echo "********* TIME STRETCHING CONFIGURATION: ******** "
            sed -n '40,42p' ./configuration.sh
            echo "************************************************* "
        elif [ $2 = "noise" ]; then
            cd $root
            echo "********* NOISE ADDING CONFIGURATION: ******** "
            sed -n '51,52p' ./configuration.sh
            echo "************************************************* "
        elif [ $2 = "RIR" ]; then
            cd $root
            echo "********* RIR FILTER CONFIGURATION: ******** "
            sed -n '56,56p' ./configuration.sh
            echo "************************************************* "
        elif [ $2 = "masking" ]; then
            cd $root
            echo "********* FREQUENCY MASKING CONFIGURATION******** "
            sed -n '65,66p' ./configuration.sh
            echo "************************************************* "
        fi
        '
    
        auxDIR=$DIR                             #còpia del directori i carpeta de la reassignació de sortida
        aux_folder_name=$folder_name

        while read line; do
            #echo $line
            file=$(basename $line)
            workingDIR="$(dirname -- $line)"
            #echo "FILE: " $file
            #echo "DIR: " $workingDIR
            
            ref_DIR="veussd/DATABASES/VoxCeleb/VoxCeleb1/dev" # l'estructura anterior a això no es replica

            #ref_DIR="PROVAR/dev"

            sub_DIR=`echo ${line##*\$ref_DIR}`
            #echo $sub_DIR
            
            DIR=$DIR/$folder_name
            cd $DIR

            str=$workingDIR
            IFS='/' read -ra path <<< "$sub_DIR"    # treiem les barres

            #for i in ${path[@]} ; do
            #    echo $i
            #done

            unset path[-1]                         # ens carreguem el fitxer de la cadena
            folder_name=${path[-1]}                 # carpeta final
            #echo "FINAL folder:" $folder_name
            unset path[-1]

            out_path=("${path[@]}")
            if [ $2 ==  "pitch" ]; then
                if [ $4 == 0.9 ];then 
                    pitch_factor=0.9
                    out_path[1]=${path[1]}"_0.9"
                elif [ $4 == 1.1 ];then
                    pitch_factor=1.1
                    out_path[1]=${path[1]}"_1.1"
                fi
            fi

            #for i in ${out_path[@]}; do
            #    echo $i
            #done
 
            for i in "${out_path[@]}"; do
                if [ ! -d $DIR/$i ] ; then
                    #echo $i
                    cd $DIR
                    mkdir $i
                fi
                DIR=$DIR"/"$i
            done

            if [ ! -d $DIR/$folder_name ] ; then
                cd $DIR
                mkdir $folder_name
            fi   
            
            if [ $2 == "rand" ];then
                #echo "RANDOM METHOD"
                items=( "time" "noise" "RIR" "masking" "none")             #NO PITCH ITEM
                # Obtener un valor random del array
                size=${#items[@]}
                randomindex=$(($RANDOM % $size))
                rand_method=${items[$randomindex]}
            else
                rand_method=$2
            fi    
            #echo $rand_method     
            
            if [ $rand_method = "pitch" ] || [[ $rand_method = "PITCH" ]] || [[ $rand_method = "Pitch" ]] ; then
                cd $root/$workingDIR
                ID=$rand_method
                check_time_limits $ID $file $shift_start $shift_end   
                pitch_shifting $file
            elif [ $rand_method = "time" ] || [[ $rand_method = "TIME" ]] || [[ $rand_method = "Time" ]] ; then
                cd $root/$workingDIR 
                ID=$rand_method
                check_time_limits $ID $file $stretch_start $stretch_end    
                time_scretching $file
            elif [ $rand_method = "noise" ] || [[ $rand_method = "NOISE" ]] || [[ $rand_method = "Noise" ]] ; then
                cd $root/$workingDIR
                noise_adding $file
            elif [ $rand_method = "RIR" ] || [[ $rand_method = "rir" ]] || [[ $rand_method = "Rir" ]] ; then
                cd $root/$workingDIR
                FIR_conv $file
            elif [ $rand_method = "masking" ] || [[ $rand_method = "MASKING" ]] || [[ $rand_method = "Masking" ]] ; then
                cd $root/$workingDIR
                freq_masking $file
            elif [ $rand_method = "none" ]; then
                cd $root/$workingDIR
                none_method $file
           
            else
                DA_method_error
            fi
            DIR=$auxDIR
            folder_name=$aux_folder_name
            
        done < $n

    fi
 
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
    elif [ $2 = "pitch" ] || [[ $2 = "PITCH" ]] || [[ $2 = "Pitch" ]] ; then
        cd $root
        echo "********* PITCH SHIFTING CONFIGURATION: ******** "
        sed -n '18,20p' ./configuration.sh
        echo "************************************************ "
        cd $root/$workingDIR
        ID=$2
        for file in *.wav; do
            check_time_limits $ID $file $shift_start $shift_end   
            pitch_shifting $file
        done

    elif [ $2 = "time" ] || [[ $2 = "TIME" ]] || [[ $2 = "Time" ]] ; then
        cd $root
        echo "********* TIME STRETCHING CONFIGURATION: ******** "
        sed -n '38,40p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        ID=$2
        for file in *.wav; do
            check_time_limits $ID $file $strech_start $stretch_end   
            time_scretching $file
        done

    elif [ $2 = "noise" ] || [[ $2 = "NOISE" ]] || [[ $2 = "Noise" ]] ; then
        cd $root
        echo "********* NOISE ADDING CONFIGURATION: ******** "
        sed -n '50,51p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            noise_adding $file
        done
    elif [ $2 = "RIR" ] || [[ $2 = "rir" ]] || [[ $2 = "Rir" ]] ;then
        cd $root
        echo "********* RIR FILTER CONFIGURATION: ************* "
        sed -n '57,57p' ./configuration.sh
        echo "************************************************* "
        cd $root/$workingDIR
        for file in *.wav; do
            FIR_conv $file
        done

    elif [ $2 = "masking" ] || [[ $2 = "MASKING" ]] || [[ $2 = "Masking" ]] ; then
        cd $root
        echo "********* FREQUENCY MASKING CONFIGURATION******** "
        sed -n '68,69p' ./configuration.sh
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

: '
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
'
