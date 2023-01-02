function get_random_file(){
    #canviar el directori abans de invocar la funció
    random_file=`ls | shuf -n 1`

}


function create_folder(){
#Crea una carpeta si aquesta no existeix
    if [ ! -d $DIR/$folder_name ] 
    then
        cd $DIR
        mkdir $folder_name
    fi  
}


function show_Directori(){
    DIRact="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )"
    echo $DIRact
}


function define_out_dir(){
    #redefineix els paràmetres $folder_name i $DIR per adaparlo al indicat i que es canvï automàticament
    if [ "$out_dir" != "" ]; then                     # si s'especifica directori de sortida.
        DIR=$root
        #echo "Saving dir specificated: " $out_dir
        str=$out_dir
        IFS='/' read -ra path <<< "$str"
        
        for i in "${path[@]}"; do
            if [ ! -d $DIR/$i ] ; then
                cd $DIR
                mkdir $i
            fi
            DIR=$DIR"/"$i
        done 

        folder_name=${path[-1]}
        #echo "DIR 1: " $DIR "FOLDER NAME: " $folder_name
        #echo "ROOT: " $root

        IFS='/' read -ra path <<< "$DIR"
        unset path[-1]
        DIR=""
        for i in "${path[@]}"; do
            DIR=$DIR"/"$i
        done
    fi

    #echo "REDEFINED FOLDER: " $folder_name
    #echo "REDEFINED DIR: " $DIR
}


function linear_2_dB(){
    local aux=`echo " l($input)/l(10) " | bc -l`
    output=`echo " 20*$aux " | bc`
}

function dB_2_linear(){
    #Es converteix el ratio de dB a valor escalar.
    local aux=`echo " scale=4; $input/20 " | bc`
    output=`echo " e(l(10)*$aux) " | bc -l `
    #echo "RATIO in linear: " $ratio
}
