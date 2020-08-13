dir_list = dir('crowder*');

count = 0;

for c1 = 1:length(dir_list)
    file_name = dir_list(c1).name;
    
    if isdir(file_name)
        disp(file_name);
        cd(file_name);
        for c2 = 1:5          
            melting_comand = sprintf('~/GitHub/crowderoxdna/UTILS/estimate_Tm.py last_hist_%d.dat',c2);
            system(melting_comand)
        end
        cd ..
    else
        
    end  
end

