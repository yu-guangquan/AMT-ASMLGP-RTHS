clear
clc;
uqlab;
rng(0,'twister');
addpath('RTHS_sim')
%%
dt=0.01;
t=0:dt:10;
time=t';
Earthquake_record_X = zeros(length(time),2); %Stochastic Ground Motion
Earthquake_record_X(:,1)=time;
X_mm1=[0.1,	1.25];
X_mm2=[0.06, 1.0];
X_mm3=[0.1,1.25];
iuu=1;
GM = pulse_groundmotion(X_mm1(iuu,1),X_mm1(iuu,2));
    Earthquake_record_X(:,2) = GM*1000;
run Model_Input_equa_m1.m;
run RT_F2D_Bld;
sim('Virtual_RTHS_CR_sca')
xcm11=xc1;
fmm11=fm1;
xcm21=xc2;
fmm21=fm2;
iuu=1;
GM = pulse_groundmotion(X_mm2(iuu,1),X_mm2(iuu,2));
    Earthquake_record_X(:,2) = GM*1000;
run Model_Input_equa_m1.m;
run RT_F2D_Bld;
sim('Virtual_RTHS_CR_sca')
xcm12=xc1;
fmm12=fm1;
xcm22=xc2;
fmm22=fm2;
iuu=1;
GM = pulse_groundmotion(X_mm3(iuu,1),X_mm3(iuu,2));
    Earthquake_record_X(:,2) = GM*1000;
run Model_Input_equa.m;
run RT_F2D_Bld;
sim('Virtual_RTHS_CR_sca')
xcm13=xc1;
fmm13=fm1;
xcm23=xc2;
fmm23=fm2;

matname=strcat('adap_25\','test_20251013','1552','.mat');
load (matname)
xc1=bddata(:,1);
xc2=bddata(:,2);
xm1=bddata(:,3);
xm2=bddata(:,4);
fm1=bddata(:,5);
fm2=bddata(:,6);
tm=bddata(:,end);
xcmm1=xc1;
fmmm1=fm1;
xcmm2=xc2;
fmmm2=fm2;
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);

p1=plot(xcm11(1:1:end),fmm11(1:1:end)/1e3,'--','Color','#4A148C',LineWidth=1);
p2=plot(xcm12(1:1:end),fmm12(1:1:end)/1e3,':','Color','#1A237E',LineWidth=1);
p3=plot(xcm13(1:1:end),fmm13(1:1:end)/1e3,'-.','Color','#F57F17',LineWidth=1);
p4=plot(xcmm1(1:1:end),fmmm1(1:1:end),'-','Color','#B71C1C',LineWidth=1);
text_size=8;%内容字体大小
lgd = legend([p1 p2 p3 p4],{'Meta-task1','Meta-task2','Meta-task3','Target-task'},...
    'Location', 'northwest',...
    'FontSize',text_size,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
% xlim([-3 2])
% ylim([-10 12])
xlabel('Displacement (mm)','fontsize',text_size);
ylabel('Restoring force (KN)','fontsize',text_size);
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','Times New Roman','fontsize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/hys_curequa_steel_v3_m3.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/hys_curequa_steel_v3_m3.pdf','ContentType','vector',"Resolution",600);
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=8;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
time=0:30/30720:30;
p1=plot(time',xcm11,'--','Color','#4A148C',LineWidth=1);
p2=plot(time',xcm12,':','Color','#1A237E',LineWidth=1);
p3=plot(time',xcm13,'-.','Color','#F57F17',LineWidth=1);
p4=plot(tm,xcmm1,'-','Color','#B71C1C',LineWidth=1);
lgd = legend([p1 p2 p3 p4],{'Meta-task1','Meta-task2','Meta-task3','Target-task'},...
    'Location', 'northeast',...
    'FontSize',text_size,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
xlim([0 10])
 % ylim([-2 2])
text_size=8;%内容字体大小
xlabel('Time (s)');
ylabel('Displacement (mm)');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','Times New Roman','fontsize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/dis_te_steel_v3_m3.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/dis_te_steel_v3_m3.pdf','ContentType','vector',"Resolution",600);
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
p1=plot(xcm21(1:1:end),fmm21(1:1:end)/1e3,'--','Color','#4A148C',LineWidth=1);
p2=plot(xcm22(1:1:end),fmm22(1:1:end)/1e3,':','Color','#1A237E',LineWidth=1);
p3=plot(xcm23(1:1:end),fmm23(1:1:end)/1e3,'-.','Color','#F57F17',LineWidth=1);
p4=plot(xcmm2(1:1:end),fmmm2(1:1:end),'-','Color','#B71C1C',LineWidth=1);

% p1=plot(xcm2,fmm2/1e3,'-.b',LineWidth=1);
% p3=plot(xcmm2,fmmm2,'-r',LineWidth=1);
text_size=8;%内容字体大小
lgd = legend([p1 p2 p3 p4],{'Meta-task1','Meta-task2','Meta-task3','Target-task'},...
    'Location', 'northwest',...
    'FontSize',text_size,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
% xlim([-2 2])
% ylim([-10 10])
xlabel('Displacement (mm)','fontsize',text_size);
ylabel('Restoring force (KN)','fontsize',text_size);
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','Times New Roman','fontsize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/hys_curequa_steel_v3_2_m3.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/hys_curequa_steel_v3_2_m3.pdf','ContentType','vector',"Resolution",600);
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=8;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
time=0:30/30720:30;
p1=plot(time',xcm21,'--','Color','#4A148C',LineWidth=1);
p2=plot(time',xcm22,':','Color','#1A237E',LineWidth=1);
p3=plot(time',xcm23,'-.','Color','#F57F17',LineWidth=1);
p4=plot(tm,xcmm2,'-','Color','#B71C1C',LineWidth=1);

% p1=plot(time',xcm2,'-.b',LineWidth=1);
% p3=plot(tm,xcmm2,'-r',LineWidth=1);
lgd = legend([p1 p2 p3 p4],{'Meta-task1','Meta-task2','Meta-task3','Target-task'},...
    'Location', 'northeast',...
    'FontSize',text_size,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
xlim([0 10])
 % ylim([-2 2])
text_size=8;%内容字体大小
xlabel('Time (s)');
ylabel('Displacement (mm)');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','Times New Roman','fontsize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/dis_te_steel_v3_2_m3.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/dis_te_steel_v3_2_m3.pdf','ContentType','vector',"Resolution",600);
%%
ini_Xn=5;
N_max=20;
hh=1;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
load (matname,'Xs_mete1','Ys_mete1')
X_ll1=0.03;
X_hh1=0.38;
X_ll2=0.8;
X_hh2=3;

[m11,k11] = meshgrid(X_ll1:(X_hh1-X_ll1)/99:X_hh1, X_ll2:(X_hh2-X_ll2)/99:X_hh2);
m111=reshape(m11,1e4,1);
k111=reshape(k11,1e4,1);
ZM_k11(:,1)=m111;
ZM_k11(:,2)=k111;
main_data_dir = '.\main_tasks\';
    Xs_rese=Xs_mete1;
    Ys_rese=Ys_mete1;
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
X_ver=ZM_k11;
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_gp.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y111=reshape(Y_mlgp(:,1),100,100);
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=7.5;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
% surf(m11, k11, Y111,'FaceAlpha',0.2,'EdgeColor','none')
[M,c]=contour(m11, k11, Y111,20);
c.LineWidth =2;
colormap(hsv);
b = colorbar('eastoutside');
b.Label.String = 'Predicted maximum story displacement (mm)';
set(b,'FontSize',8,'Fontname', 'Times New Roman');
hold on
s1=scatter(Xs_mete1(1:ini_Xn,1),Xs_mete1(1:ini_Xn,2),'o', 'b', 'filled');
s2=scatter(Xs_mete1(ini_Xn+1:end,1),Xs_mete1(ini_Xn+1:end,2),'s', 'r', 'filled');
lgd = legend([s1 s2],{'Initial samples', 'Sequential samples'},...
    'Location', 'northeast',...
    'FontSize',8,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('$V_{p}$','fontsize',text_size,'interpreter','latex');
ylabel('$T_{p}$','fontsize',text_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/eq_m1_Asamples_gp.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/eq_m1_Asamples_gp.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
cn=0.02;
N_max=20;
N_max_N=18;
for hh=1:1
matname=strcat('result1\AMLGP_v3_25\','Amlgp_2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
load (matname,'RMSE_gp1')
end
p1=plot(1:N_max_N,RMSE_gp1(1:N_max_N),'-s','LineWidth', 2,'Color','#4A148C','MarkerEdgeColor','#4A148C', ...
    'MarkerFaceColor','#4A148C');
p2=plot(1:N_max_N,0.05*ones(1,N_max_N),'--', 'LineWidth', 2,'Color','r');
h1=legend({'$\it CC_{j}$','$\varepsilon_{r}$'});
set(h1,'Interpreter','latex','Location','best')
xlim([1 19])
grid on
text_size=8;
 xlabel('Number of sequential samples','interpreter','latex');
ylabel('$CC$','interpreter','latex');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','FontSize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/CC_v3_m1.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/CC_v3_m1.pdf','ContentType','vector',"Resolution",600);
%%
load result1\AMLGP_v3_25\pyAK_2story_2ue_v3_simm1_18.mat RMSEgp RRmlgp Y_gp Y_ver
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=8;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
N_maxg=18;
yyaxis left
p1=plot(1:N_maxg,RMSEgp(1:N_maxg),'-o', 'LineWidth', 2,'Color','#4A148C','MarkerEdgeColor','#4A148C', ...
    'MarkerFaceColor','#4A148C');
ylabel('RMSE','fontsize',axis_size,'interpreter','latex');
set(gca,'YColor','#4A148C');

% legend('boxoff')
yyaxis right
p2 = plot(1:N_maxg, RRmlgp(1:N_maxg), '-s', ...
    'LineWidth', 2, 'Color', '#4A148C', ...
    'MarkerEdgeColor', '#4A148C', 'MarkerFaceColor', '#B71C1C');
ylabel('R^2','fontsize',8);
set(gca,'YColor','#4A148C');   % 右轴颜色与曲线一致（可删）
xlim([0 19])

grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
xlabel('Number of sequential samples','fontsize',axis_size,'interpreter','latex');
legend([p1 p2], {'RMSE','R^2 '}, 'Location','northeast','Box','off');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5);
exportgraphics(gcf, './figure/RMSE_m1_sim.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/RMSE_m1_sim.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
p1=plot(Y_ver,Y_gp,'d','markersize',8,'MarkerFaceColor','#4A148C','MarkerEdgeColor','#4A148C');
R2g=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_gp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1g=strcat('R^2=',num2str(R2g,'%.2f'),'%');
plot(0:0.1:6,0:0.1:6,'LineWidth',2,'Color','#B71C1C')
xl = xlim; 
yl = ylim;
x_text = xl(1) + 0.05*(xl(2)-xl(1));   % 距左边5%
y_text = yl(2) - 0.08*(yl(2)-yl(1));   % 距上边8%

text(x_text, y_text, name1g, ...
    'FontSize', 8, 'FontName', 'Times New Roman', ...
    'Interpreter','tex', ...
    'BackgroundColor','w', 'Margin',2);
% legend('boxoff')
% xlim([0 20])
% ylim([0 0.15])
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
ylabel('Predicted response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
xlabel('Meta-task response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/equa_rr_simm1.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/equa_rr_simm1.pdf','ContentType','vector',"Resolution",600);

%%
ini_Xn=5;
N_max=20;
hh=1;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hh),'.mat');
load (matname,'Xs_mete1','Ys_mete1')

X_ll1=0.03;
X_hh1=0.19;
X_ll2=0.8;
X_hh2=2;

[m11,k11] = meshgrid(X_ll1:(X_hh1-X_ll1)/99:X_hh1, X_ll2:(X_hh2-X_ll2)/99:X_hh2);
m111=reshape(m11,1e4,1);
k111=reshape(k11,1e4,1);
ZM_k11(:,1)=m111;
ZM_k11(:,2)=k111;
main_data_dir = '.\main_tasks\';
    Xs_rese=Xs_mete1;
    Ys_rese=Ys_mete1;
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
X_ver=ZM_k11;
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_gp.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y111=reshape(Y_mlgp(:,1),100,100);
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=7.5;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
% surf(m11, k11, Y111,'FaceAlpha',0.2,'EdgeColor','none')
[M,c]=contour(m11, k11, Y111,20);
c.LineWidth =2;
colormap(hsv);
b = colorbar('eastoutside');
b.Label.String = 'Predicted maximum story displacement (mm)';
set(b,'FontSize',8,'Fontname', 'Times New Roman');
cl = caxis;               % [cmin cmax]
cmin = floor(cl(1));
cmax = ceil(cl(2));

% 2) 生成整数刻度（若范围很大，可按需改步长）
ticks = cmin:cmax;

% 3) 应用到 colorbar，并用整数显示
b.Ticks = ticks;
b.TickLabels = string(ticks);   % 或者 arrayfun(@(x)sprintf('%d',x),ticks,'uni',0)
hold on
s1=scatter(Xs_mete1(1:ini_Xn,1),Xs_mete1(1:ini_Xn,2),'o', 'b', 'filled');
s2=scatter(Xs_mete1(ini_Xn+1:end,1),Xs_mete1(ini_Xn+1:end,2),'s', 'r', 'filled');
lgd = legend([s1 s2],{'Initial samples', 'Sequential samples'},...
    'Location', 'northeast',...
    'FontSize',8,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('$V_{p}$','fontsize',text_size,'interpreter','latex');
ylabel('$T_{p}$','fontsize',text_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/eq_m2_Asamples_gp.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/eq_m2_Asamples_gp.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
cn=0.02;
N_max=20;
N_max_N=14;
for hh=1:1
matname=strcat('result1\AMLGP_v3_25\','Amlgp_2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hh),'.mat');
load (matname,'RMSE_gp1')
end
p1=plot(1:N_max_N,RMSE_gp1(1:N_max_N),'-s','LineWidth', 2,'Color','#1A237E','MarkerEdgeColor','#1A237E', ...
    'MarkerFaceColor','#1A237E');
p2=plot(1:N_max_N,0.05*ones(1,N_max_N),'--', 'LineWidth', 2,'Color','r');
h1=legend({'$\it CC_{j}$','$\varepsilon_{r}$'});
set(h1,'Interpreter','latex','Location','best')
xlim([1 18])
grid on
text_size=8;
 xlabel('Number of sequential samples','interpreter','latex');
ylabel('$CC$','interpreter','latex');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','FontSize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/CC_v3_m2.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/CC_v3_m2.pdf','ContentType','vector',"Resolution",600);
%%
load result1\AMLGP_v3_25\pyAK_2story_2ue_v3_simm2_14.mat RMSEgp RRmlgp Y_gp Y_ver
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=8;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
N_maxg=14;
yyaxis left
p1=plot(1:N_maxg,RMSEgp(1:N_maxg),'-o', 'LineWidth', 2,'Color','#1A237E','MarkerEdgeColor','#1A237E', ...
    'MarkerFaceColor','#1A237E');
ylabel('RMSE','fontsize',axis_size,'interpreter','latex');
set(gca,'YColor','#1A237E');

% legend('boxoff')
yyaxis right
p2 = plot(1:N_maxg, RRmlgp(1:N_maxg), '-s', ...
    'LineWidth', 2, 'Color', '#1A237E', ...
    'MarkerEdgeColor', '#1A237E', 'MarkerFaceColor', '#B71C1C');
ylabel('R^2','fontsize',8);
set(gca,'YColor','#1A237E');   % 右轴颜色与曲线一致（可删）
xlim([0 15])

grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
xlabel('Number of sequential samples','fontsize',axis_size,'interpreter','latex');
legend([p1 p2], {'RMSE','R^2 '}, 'Location','northeast','Box','off');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5);
exportgraphics(gcf, './figure/RMSE_m2_sim.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/RMSE_m2_sim.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
p1=plot(Y_ver,Y_gp,'d','markersize',8,'MarkerFaceColor','#1A237E','MarkerEdgeColor','#1A237E');
R2g=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_gp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1g=strcat('R^2=',num2str(R2g,'%.2f'),'%');
plot(0:0.1:4,0:0.1:4,'LineWidth',2,'Color','#B71C1C')
xl = xlim; 
yl = ylim;
x_text = xl(1) + 0.05*(xl(2)-xl(1));   % 距左边5%
y_text = yl(2) - 0.08*(yl(2)-yl(1));   % 距上边8%

text(x_text, y_text, name1g, ...
    'FontSize', 8, 'FontName', 'Times New Roman', ...
    'Interpreter','tex', ...
    'BackgroundColor','w', 'Margin',2);
% legend('boxoff')
% xlim([0 20])
% ylim([0 0.15])
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
ylabel('Predicted response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
xlabel('Meta-task response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/equa_rr_simm2.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/equa_rr_simm2.pdf','ContentType','vector',"Resolution",600);

%%
ini_Xn=5;
N_max=20;
hh=1;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hh),'.mat');
load (matname,'Xs_mete1','Ys_mete1')

X_ll1=0.03;
X_hh1=0.38;
X_ll2=0.8;
X_hh2=3;

% X_ll1=0.03;
% X_hh1=0.19;
% X_ll2=0.8;
% X_hh2=2;

[m11,k11] = meshgrid(X_ll1:(X_hh1-X_ll1)/99:X_hh1, X_ll2:(X_hh2-X_ll2)/99:X_hh2);
m111=reshape(m11,1e4,1);
k111=reshape(k11,1e4,1);
ZM_k11(:,1)=m111;
ZM_k11(:,2)=k111;
main_data_dir = '.\main_tasks\';
    Xs_rese=Xs_mete1;
    Ys_rese=Ys_mete1;
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
X_ver=ZM_k11;
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_gp.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y111=reshape(Y_mlgp(:,1),100,100);
%%
figure
hold on
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=7.5;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
% surf(m11, k11, Y111,'FaceAlpha',0.2,'EdgeColor','none')
[M,c]=contour(m11, k11, Y111,20);
c.LineWidth =2;
colormap(hsv);
b = colorbar('eastoutside');
b.Label.String = 'Predicted maximum story displacement (mm)';
set(b,'FontSize',8,'Fontname', 'Times New Roman');
cl = caxis;               % [cmin cmax]
cmin = floor(cl(1));
cmax = ceil(cl(2));

% 2) 生成整数刻度（若范围很大，可按需改步长）
ticks = cmin:4:cmax;

% 3) 应用到 colorbar，并用整数显示
b.Ticks = ticks;
b.TickLabels = string(ticks);   % 或者 arrayfun(@(x)sprintf('%d',x),ticks,'uni',0)
hold on
s1=scatter(Xs_mete1(1:ini_Xn,1),Xs_mete1(1:ini_Xn,2),'o', 'b', 'filled');
s2=scatter(Xs_mete1(ini_Xn+1:end,1),Xs_mete1(ini_Xn+1:end,2),'s', 'r', 'filled');
lgd = legend([s1 s2],{'Initial samples', 'Sequential samples'},...
    'Location', 'northeast',...
    'FontSize',8,...
    'Fontname', 'Times New Roman',...
    'NumColumns',1,...
    'Box','off');
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('$V_{p}$','fontsize',text_size,'interpreter','latex');
ylabel('$T_{p}$','fontsize',text_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/eq_m3_Asamples_gp.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/eq_m3_Asamples_gp.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
cn=0.02;
N_max=20;
N_max_N=18;
for hh=1:1
matname=strcat('result1\AMLGP_v3_25\','Amlgp_2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hh),'.mat');
load (matname,'RMSE_gp1')
end
p1=plot(1:N_max_N,RMSE_gp1(1:N_max_N),'-s','LineWidth', 2,'Color','#F57F17','MarkerEdgeColor','#F57F17', ...
    'MarkerFaceColor','#F57F17');
p2=plot(1:N_max_N,0.05*ones(1,N_max_N),'--', 'LineWidth', 2,'Color','r');
h1=legend({'$\it CC_{j}$','$\varepsilon_{r}$'});
set(h1,'Interpreter','latex','Location','best')
xlim([1 19])
grid on
text_size=8;
 xlabel('Number of sequential samples','interpreter','latex');
ylabel('$CC$','interpreter','latex');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','FontSize',text_size,'linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/CC_v3_m3.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/CC_v3_m3.pdf','ContentType','vector',"Resolution",600);
%%
load result1\AMLGP_v3_25\pyAK_2story_2ue_v3_simm3_18.mat RMSEgp RRmlgp Y_gp Y_ver
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=8;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
N_maxg=18;
yyaxis left
p1=plot(1:N_maxg,RMSEgp(1:N_maxg),'-o', 'LineWidth', 2,'Color','#F57F17','MarkerEdgeColor','#F57F17', ...
    'MarkerFaceColor','#F57F17');
ylabel('RMSE','fontsize',axis_size,'interpreter','latex');
set(gca,'YColor','#F57F17');

% legend('boxoff')
yyaxis right
p2 = plot(1:N_maxg, RRmlgp(1:N_maxg), '-s', ...
    'LineWidth', 2, 'Color', '#F57F17', ...
    'MarkerEdgeColor', '#F57F17', 'MarkerFaceColor', '#B71C1C');
ylabel('R^2','fontsize',8);
set(gca,'YColor','#F57F17');   % 右轴颜色与曲线一致（可删）
xlim([0 19])

grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
xlabel('Number of sequential samples','fontsize',axis_size,'interpreter','latex');
legend([p1 p2], {'RMSE','R^2 '}, 'Location','northeast','Box','off');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5);
exportgraphics(gcf, './figure/RMSE_m3_sim.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/RMSE_m3_sim.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;   %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
p1=plot(Y_ver,Y_gp,'d','markersize',8,'MarkerFaceColor','#F57F17','MarkerEdgeColor','#F57F17');
R2g=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_gp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1g=strcat('R^2=',num2str(R2g,'%.2f'),'%');
plot(0:0.1:20,0:0.1:20,'LineWidth',2,'Color','#B71C1C')
xl = xlim; 
yl = ylim;
x_text = xl(1) + 0.05*(xl(2)-xl(1));   % 距左边5%
y_text = yl(2) - 0.08*(yl(2)-yl(1));   % 距上边8%

text(x_text, y_text, name1g, ...
    'FontSize', 8, 'FontName', 'Times New Roman', ...
    'Interpreter','tex', ...
    'BackgroundColor','w', 'Margin',2);
% legend('boxoff')
% xlim([0 20])
% ylim([0 0.15])
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
ylabel('Predicted response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
xlabel('Meta-task response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/equa_rr_simm3.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/equa_rr_simm3.pdf','ContentType','vector',"Resolution",600);


