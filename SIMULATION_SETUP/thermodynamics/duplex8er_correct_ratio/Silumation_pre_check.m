dir_list = dir('*');

file_name = 'check_melting.sh';
submission_file = fopen(file_name,'w');


count = 0;

simulation_folder_set = {};

folder_name_list = {};
for c1 = 1:length(dir_list)
    file_name = dir_list(c1).name;
    
    if strfind(file_name,'crowder') & isdir(file_name);
        %disp(file_name);
        folder_name_list{end+1} = file_name;
    else
        
    end  
end

data_folder_name = 'melting_data';
mkdir(data_folder_name)

file_name = 'melting_download.sh';
fid = fopen(file_name,'w');

for c1 = 1:length(folder_name_list)
    file_name = folder_name_list{c1};
    
    if isdir(file_name)
        mkdir(['melting_data/',file_name])
        mkdir_comand = sprintf('mkdir melting_data/%s \n',file_name);
        fprintf(fid,mkdir_comand);
        for c2 = 1:5
            
            get_data_command = sprintf('rsync fhong5@agave.asu.edu:/home/fhong5/submissions/crowder_melting_full_parameter/duplex8er/%s/RUN%d/last_hist.dat melting_data/%s/last_hist_%d.dat \n',file_name,c2,file_name,c2);
            fprintf(fid,get_data_command);
            system(get_data_command);
            fprintf('Download file %s %d \n',file_name,c2);
            system('sleep 5');
        end
     disp(c1);
    else
        
    end  
 end

