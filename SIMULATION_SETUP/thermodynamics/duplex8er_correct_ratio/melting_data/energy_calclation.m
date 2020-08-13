dir_list = dir('crowder*');

close all;

dG_0_1 = [];
dG_1_6 = [];

temperature = 56;
mkdir('energy_profile');
for c1 = 1:length(dir_list)
    folder_name = dir_list(c1).name;
    
    hist_list = dir([folder_name,'/last_hist*']);
    energy_set = [];
    
    for c2 = 1:length(hist_list)
        filename = [folder_name,'/',hist_list(c2).name];
        [colum_data0,temperature_hist] = last_hist_dat_read(filename,1);

        index1 = find(temperature_hist==25);

            index = index1;


        disp(index);
        [colum_data,temperature_hist] = last_hist_dat_read(filename,index+3);
        energy_data = -log(colum_data);     
        dG_0_1 = energy_data(2)-energy_data(1);
        dG_1_6 = energy_data(7)- energy_data(2);
        energy_set(end+1,:) = [dG_0_1,dG_1_6];
        
    end
    
    save_comand = sprintf('save energy_profile/dG_01_16_%s.txt -ascii energy_set',folder_name);
    eval(save_comand);
    
end

file_list = dir('energy_profile/dG_01_16_*.txt');
cd energy_profile;
dG_01 = [];
dG_16 = [];

for c1 = 1:length(file_list)
    data = load(file_list(c1).name);
    dG_01(end+1,:) = [mean(data(:,1)),std(data(:,1))];
    dG_16(end+1,:) = [mean(data(:,2)),std(data(:,2))];  
end

f10_set_dG01 = dG_01(1:5,:);
f10_set_dG01_new = f10_set_dG01;
f10_set_dG01_new(1,:) = f10_set_dG01(2,:);
f10_set_dG01_new(2,:) = f10_set_dG01(1,:);

f20_set_dG01 = dG_01(6:10,:);
f20_set_dG01_new = f20_set_dG01;
f20_set_dG01_new(1,:) = f20_set_dG01(2,:);
f20_set_dG01_new(2,:) = f20_set_dG01(1,:);

f30_set_dG01 = dG_01(11:15,:);
f30_set_dG01_new = f30_set_dG01;
f30_set_dG01_new(1,:) = f30_set_dG01(2,:);
f30_set_dG01_new(2,:) = f30_set_dG01(1,:);

f40_set_dG01 = dG_01(16:20,:);
f40_set_dG01_new = f40_set_dG01;
f40_set_dG01_new(1,:) = f40_set_dG01(2,:);
f40_set_dG01_new(2,:) = f40_set_dG01(1,:);


f10_set_dG16 = dG_16(1:5,:);
f10_set_dG16_new = f10_set_dG16;
f10_set_dG16_new(1,:) = f10_set_dG16(2,:);
f10_set_dG16_new(2,:) = f10_set_dG16(1,:);

f20_set_dG16 = dG_16(6:10,:);
f20_set_dG16_new = f20_set_dG16;
f20_set_dG16_new(1,:) = f20_set_dG16(2,:);
f20_set_dG16_new(2,:) = f20_set_dG16(1,:);

f30_set_dG16 = dG_16(11:15,:);
f30_set_dG16_new = f30_set_dG16;
f30_set_dG16_new(1,:) = f30_set_dG16(2,:);
f30_set_dG16_new(2,:) = f30_set_dG16(1,:);

f40_set_dG16 = dG_16(16:20,:);
f40_set_dG16_new = f40_set_dG16;
f40_set_dG16_new(1,:) = f40_set_dG16(2,:);
f40_set_dG16_new(2,:) = f40_set_dG16(1,:);

radius = [1:0.5:3];
figure(2);
hold on;
errorbar(radius,f10_set_dG01_new(:,1),f10_set_dG01_new(:,2),'linewidth',2);
errorbar(radius,f20_set_dG01_new(:,1),f20_set_dG01_new(:,2),'linewidth',2);
errorbar(radius,f30_set_dG01_new(:,1),f30_set_dG01_new(:,2),'linewidth',2);
errorbar(radius,f40_set_dG01_new(:,1),f40_set_dG01_new(:,2),'linewidth',2);
legend('f10','f20','f30','Location','Southeast')
set(gca,'fontsize',24);
xlabel('crowder radius');
xlim([0.8 3.2])
ylabel('\Delta G_0_1 energy change')
title('\Delta G_0_1 change')
print(2,'-djpeg','-r600','dG_01.jpeg')

figure(3);
hold on;
errorbar(radius,f10_set_dG16_new(:,1),f10_set_dG16_new(:,2),'linewidth',2);
errorbar(radius,f20_set_dG16_new(:,1),f20_set_dG16_new(:,2),'linewidth',2);
errorbar(radius,f30_set_dG16_new(:,1),f30_set_dG16_new(:,2),'linewidth',2);
errorbar(radius,f40_set_dG16_new(:,1),f40_set_dG16_new(:,2),'linewidth',2);
legend('f10','f20','f30','Location','Southeast')
set(gca,'fontsize',24);
xlabel('crowder radius');
xlim([0.8 3.2])
ylabel('\Delta G_1_6 energy change')
title('\Delta G_1_6 change')
print(3,'-djpeg','-r600','dG_16.jpeg')
cd ..;















