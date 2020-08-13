radius = '1.5';

data_f10r1 = load(sprintf('energy_profile/energy_crowder_f10.0_r%s.txt',radius));
data_f20r1 = load(sprintf('energy_profile/energy_crowder_f20.0_r%s.txt',radius));
data_f30r1 = load(sprintf('energy_profile/energy_crowder_f30.0_r%s.txt',radius));
data_f40r1 = load(sprintf('energy_profile/energy_crowder_f40.0_r%s.txt',radius));
data_f0 = load('energy_profile/energy_crowder_no_crowder.txt');

bond = [0:1:8];

close all;
figure(1);
hold on;
errorbar(bond,data_f10r1(1,:),data_f10r1(2,:),'linewidth',2);
errorbar(bond,data_f20r1(1,:),data_f20r1(2,:),'linewidth',2);
errorbar(bond,data_f30r1(1,:),data_f30r1(2,:),'linewidth',2);
errorbar(bond,data_f40r1(1,:),data_f40r1(2,:),'linewidth',2);
errorbar(bond,data_f0(1,:),data_f0(2,:),'linewidth',2);
legend('fraction 10%','fraction 20%','fraction 30%','fraction 40%','no crowder','Location','Northeast')
legend boxoff;
set(gca,'fontsize',24)
set(gca,'XTick',[0:1:8]);
xlabel('native base pairs');
ylabel('Free energy/k_BT')
print(1,'-depsc','energy_profile_comp.eps')