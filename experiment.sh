

list=" lists/dev_list.txt"
aux_folder="out"
in_folder="dev"
out_folder="dev_aug"

# PAS 1: CANVI PITCH 0.9
./DA_program_V1.sh $list pitch $aux_folder 0.9       

# PAS 2: CANVI PITCH 1.1
./DA_program_V1.sh $list pitch $aux_folder 1.1  

# PAS 3: Còpia de la carpeta original 
cp -R $in_folder $aux_folder

# PAS 4: Llista de la carpeta out_folder
find $aux_folder -type f > experiment_list.txt

# PAS 5: Data augmentation de "experiment_list.txt"
./DA_program_V1.sh experiment_list.txt rand $out_folder $aux_folder