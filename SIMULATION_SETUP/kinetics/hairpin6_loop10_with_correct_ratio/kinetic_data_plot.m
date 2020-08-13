kin_data = load('hairpin_kinetic_data.txt');
radius1 = kin_data(1:3,:);
radius2 = kin_data(4:6,:);

radius1_data = [];
radius2_data = [];
for c1 = 1:3
    radius1_data(end+1,:) = [mean(radius1(c1,:)),std(radius1(c1,:))];
    radius2_data(end+1,:) = [mean(radius2(c1,:)),std(radius2(c1,:))];
end

close all;

figure(1);
hold on;
fraction = [1:3]/10;
errorbar(fraction,radius1_data(:,1),radius1_data(:,2),'-*','linewidth',2);
errorbar(fraction,radius2_data(:,1),radius2_data(:,2),'-*','linewidth',2);
set(gca,'fontsize',24)
xlim([0.08 0.35]);
xlabel('excluded volume fraction');
ylabel('relative hybridization rate');
legend('radius 1.0','radius 3.0','Location','Northwest');
legend boxoff;
print (1,'-depsc','kinetic_rate.eps');
print (1,'-djpeg','-r600','kinetic_rate.jpeg');