
my_file = open('vox_celeb_1_train_labels.txt', 'r')
data = [linea.rstrip() for linea in my_file]

for lin in my_file:
    data.append(lin)
    i=i+1
print(len(data))
mod_data = []
folder="DATABASES/VoxCeleb/VoxCeleb1/dev"

for n in data:
    split_data=n.split('.')
    mod_data.append(folder + split_data[0] + ".wav" )

#print(len(data))

#f = open('vox_celeb_1_train_labels2.txt', 'w')
#for n in mod_data:
#    f.write(n)
#    f.write('\n')

f = open('REDUCTED_vox_celeb_1_train_labels.txt', 'w')
for i in range(10):
    f.write(mod_data[i])
    f.write('\n')