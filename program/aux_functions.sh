
root="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )"

#echo "ROOT: " $root

function convert_all_SR(){
    cd $root/program_samples/sound-bible
    show_Directori
    for filename in $(ls $1); do
        echo $filename
        sox $1/$filename -r 44100 -b 16 -c 1 $1/temp/$filename
    done

}

function create_list_old(){
    echo "WE ARE GOING TO CREATE A LIST"
    if [ ! -d $DIR/$folder_name ]; then
        cd $root
        mkdir lists
    fi  

    cd $root/lists
    echo "DOLAR 1: " $1
    echo "DOLAR 2: " $2
    list_name=$(basename $1)
    dir="$(dirname -- $1)"


    if [ ! -f $root/lists/$list_name.txt ]; then
        echo "HERE"
        touch $list_name.txt
    fi  

    cd $root/$2

    : > $root/lists/$list_name.txt

    cd $root/$2

    
    auxDir="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )"

    echo "auxDir: " $auxDir

    find $root/$2 -name \*.mp3 >> $root/lists/$list_name.txt
    f


 : '
    echo "HERE" > $root/lists/$list_name.txt
    for filename in $(ls $root/$2); do
        echo "HERE"
        echo "HERE" > $root/lists/$list_name.txt
    done
    '
}


function create_list(){

    if [ -z $1 ]; then
        echo "$\1 --> directori d'on vols treure la llista"
        echo "$\2 --> nom de la llista. Es guarda a root"
    fi
    cd $root
    find $1 -type f >> $2.txt

}

"$@"