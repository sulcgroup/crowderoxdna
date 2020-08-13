%% plot melting temperature

f10 = load('melting_tm_width_data/f10_melt.txt');
f20 = load('melting_tm_width_data/f20_melt.txt');
f30 = load('melting_tm_width_data/f30_melt.txt');
f40 = load('melting_tm_width_data/f40_melt.txt');

close all;
figure(1);
hold on;
errorbar(f10(:,1)*0.85,f10(:,2),f10(:,3),'linewidth',2);
errorbar(f20(:,1)*0.85,f20(:,2),f20(:,3),'linewidth',2);
errorbar(f30(:,1)*0.85,f30(:,2),f30(:,3),'linewidth',2);
errorbar(f40(:,1)*0.85,f40(:,2),f40(:,3),'linewidth',2);

xlim([0.6 2.7]);
ylim([45 85]);
xlabel('Crowder Size (nm)','fontsize',28)
ylabel('Melting Temperature (^oC)','fontsize',28)
legend('excluded volume 13.3%','excluded volume 26.6%','excluded volume 39.9%','excluded volume 53.3%',...
        'position','Northeast');
legend boxoff
set(gca,'fontsize',24)
print(1,'-depsc','melting_tm_width_data/melting_overall.eps');
print(1,'-djpeg','-r300','melting_tm_width_data/melting_overall.jpeg');

%% plot width of melting curve

f10 = load('melting_tm_width_data/f10_width.txt');
f20 = load('melting_tm_width_data/f20_width.txt');
f30 = load('melting_tm_width_data/f30_width.txt');
f40 = load('melting_tm_width_data/f40_width.txt');

close all;
figure(1);
hold on;
errorbar(f10(:,1),f10(:,2),f10(:,3),'linewidth',2);
errorbar(f20(:,1),f20(:,2),f20(:,3),'linewidth',2);
errorbar(f30(:,1),f30(:,2),f30(:,3),'linewidth',2);
errorbar(f40(:,1),f40(:,2),f40(:,3),'linewidth',2);

xlim([0.5 3.5]);
xlabel('Crowder Size (nm)','fontsize',28)
ylabel('Melting Temperature (^oC)','fontsize',28)
legend('excluded volume 13.3%','excluded volume 26.6%','excluded volume 39.9%','excluded volume 53.3%',...
        'position','Northeast');
legend boxoff
set(gca,'fontsize',24)
print(1,'-depsc','melting_tm_width_data/width_overall.eps');
print(1,'-djpeg','-r300','melting_tm_width_data/width_overall.jpeg');
    