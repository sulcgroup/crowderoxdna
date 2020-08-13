exclude_fraction_set = {'10','20','30','40'};
all_data_set = zeros(5,3);


mkdir('melting_tm_width_data');
for c3 = 1:length(exclude_fraction_set)
    exclude_fraction = exclude_fraction_set{c3};
    fratcion_data_list = dir(sprintf('crowder_f%s*',exclude_fraction));
    fraction = [1:0.5:3];
    melting_data = [];
    melting_all_data = [];

    width_data = [];
    width_all_data = [];
    
    for c1 = 1:length(fratcion_data_list)
        folder_name = fratcion_data_list(c1).name;
        melting_data_set = [];
        width_data_set = [];
        for c2 = 1:3
            data = load(sprintf('%s/melting_curve_last_hist_%d.txt',folder_name,c2));
            melting_data_set(end+1) = data(end,1);
            width_data_set(end+1) = data(end,3);
        end

        melting_data(end+1,:) = [mean(melting_data_set),std(melting_data_set)];
        width_data(end+1,:) = [mean(width_data_set),std(width_data_set)];
    end
    melting_all_data = [fraction',melting_data(:,1),melting_data(:,2)];
    width_all_data = [fraction',width_data(:,1),width_data(:,2)];
    
    melting_save_cmd = sprintf('save melting_tm_width_data/f%s_melt.txt melting_all_data -ascii',exclude_fraction);
    eval(melting_save_cmd);
    width_save_cmd = sprintf('save melting_tm_width_data/f%s_width.txt width_all_data -ascii',exclude_fraction);
    eval(width_save_cmd);
    
    figure(1);
    all_data_set(:,c3) = melting_data(:,1);
    errorbar(fraction,melting_data(:,1),melting_data(:,2),'linewidth',2);
    xlabel('Crowder Size (nm)','fontsize',28)
    ylabel('Melting Temperature (^oC)','fontsize',28)
    title(['Excluded Volume',exclude_fraction,'%']);
    set(gca,'fontsize',28)
    print(1,'-djpeg','-r300',['melting_tm_width_data/melting_f',exclude_fraction,'.jpeg']);
    
    figure(2);
    all_data_set(:,c3) = melting_data(:,1);
    errorbar(fraction,width_data(:,1),width_data(:,2),'linewidth',2);
    xlabel('Crowder Size (nm)','fontsize',28)
    ylabel('Melting Temperature (^oC)','fontsize',28)
    title(['Excluded Volume',exclude_fraction,'%']);
    set(gca,'fontsize',28)
    print(2,'-djpeg','-r300',['melting_tm_width_data/with_f',exclude_fraction,'.jpeg']);
    
end

figure(2);
imagesc(all_data_set);
colorbar;
xlabel('excluded volume fraction','fontsize',28);
ylabel('crowder Size (nm)','fontsize',28)
 set(gca,'fontsize',24)
 print(2,'-djpeg','-r300','heat_map.jpeg');

% %%
% 
% exclude_fraction = '10';
% 
% fratcion_data_list = dir('*r1*');
% fraction = [0.1:0.1:0.3];
% melting_data = []
% 
% for c1 = 2:length(fratcion_data_list)
%     folder_name = fratcion_data_list(c1).name;
%     data_set = [];
%     for c2 = 1:5
%         data = load(sprintf('%s/melting_curve_last_hist_%d.txt',folder_name,c2));
%         data_set(end+1) = data(end,1);
%     end
%     
%     melting_data(end+1,:) = [mean(data_set),std(data_set)];
%      
% end
% 
% figure(1);
% errorbar(fraction,melting_data(:,1),melting_data(:,2),'linewidth',2);
% xlabel('Crowder Size','fontsize',28)
% ylabel('Melting Temperature','fontsize',28)
% title(['Excluded Volume',exclude_fraction,'%']);
% set(gca,'fontsize',28)
% print(1,'-djpeg','-r300',['excluded_volume_f',exclude_fraction,'.jpeg']);






