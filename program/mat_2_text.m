cd 'C:\Users\UX370\Downloads\rir\air_database_release_1_4\AIR_1_4'
files=dir('*.mat');

for i=1:length(files)
    cd 'C:\Users\UX370\Downloads\rir\air_database_release_1_4\AIR_1_4'
    %disp(files(i).name)
    load(files(i).name);
    h_air=h_air.';
    out_name = split(files(i).name,'.');
    out_name=strcat(out_name(1,1),".txt");
    %disp(out_name)
    cd 'C:\Users\UX370\Downloads\rir\air_database_release_1_4\AIR_1_4\txt_files'
    dlmwrite(out_name,h_air,'precision','%.20f');
end