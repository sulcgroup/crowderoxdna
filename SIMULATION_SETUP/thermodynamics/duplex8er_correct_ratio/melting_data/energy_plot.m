
fraction = '10';
dir_list = dir(sprintf('crowder_f%s*',fraction));

close all;
legend_list = {};
energy_data_all = [];

mkdir('energy_profile');

figure(1);
for c1 = 1:length(dir_list)
    disp(c1);
    folder_name = dir_list(c1).name;
    
    hist_list = dir([folder_name,'/last_hist*']);
        
    engergy_data_all = [];
        
    for c2 = 1:length(hist_list)
        filename = [folder_name,'/',hist_list(c2).name];
        bond = last_hist_dat_read(filename,1);
               
        [colum_data0,temperature_hist] = last_hist_dat_read(filename,1);

        index1 = find(temperature_hist==25);

            index = index1;

        disp(index);
        [colum_data,temperature_hist] = last_hist_dat_read(filename,index+3);
        
        log_engergy_data = -log(colum_data); 
            
        engergy_data_zero = log_engergy_data-log_engergy_data(1);
        engergy_data_all(:,c2) = engergy_data_zero;
    end
    disp(engergy_data_all);
    mean_energy = [];
    
    for c3 = 1:size(engergy_data_all,1)
        mean_energy(:,c3) = [mean(engergy_data_all(c3,:)),std(engergy_data_all(c3,:))];
        
    end
    
    save_comand = sprintf('save energy_profile/energy_%s.txt -ascii mean_energy',folder_name);
    eval(save_comand);
    
    hold on;
    errorbar(bond,mean_energy(1,:),mean_energy(2,:),'-*','linewidth',2);
    
    index = strfind(folder_name,'_');
    folder_name(index) = '-';
    legend_list{end+1} = folder_name;
    
end

title('Crowder Exclude Volume 13.3%');
legend('r = 0.85 nm','r = 1.27 nm','r = 1.70 nm','r = 2.12 nm','r = 2.55 nm')
set(gca,'linewidth',1,'fontsize',18);
xlabel('native base pairs');
ylabel('Free energy/k_BT')
box on;
xlim([0 8.5])

cd energy_profile
figure_name = sprintf('energy_profile_f%s.jpeg',num2str(str2num(fraction)*1.333));
print(1,'-djpeg','-r600',figure_name);
cd ..;



