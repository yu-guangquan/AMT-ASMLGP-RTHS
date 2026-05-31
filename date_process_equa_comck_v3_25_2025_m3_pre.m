clear
clc;
uqlab;
rng(0,'twister');
addpath('RTHS_sim')
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=8;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
N_max=20;
N_ini1=5;
N_maxg=15;
N_maxcm1=16;
N_maxmm1=10;
N_maxcm2=13;
N_maxmm2=10;
N_maxcm3=14;
N_maxmm3=11;
N_maxmms1=13;
N_maxmms2=18;
N_maxmms3=13;
hh=1;
hhm=1;
matname=strcat('result1\AK_v3_exp\','pyAK_2story_2ue_v3_expr_',num2str(N_max),'.mat');
load (matname,'RMSE_gpm')
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_cgp3m1=RMSE_mlgp3m;
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_cgp3m2=RMSE_mlgp3m;
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_cgp3m3=RMSE_mlgp3m;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_mlgp3ms1=RMSE_mlgp3m;
hhm=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_mlgp3ms2=RMSE_mlgp3m;
hhm=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_mlgp3ms3=RMSE_mlgp3m;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_mlgp3m1=RMSE_mlgp3m;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_mlgp3m2=RMSE_mlgp3m;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSE_mlgp3m')
RMSE_mlgp3m3=RMSE_mlgp3m;
MarkerSize1=4;
p2=plot(N_ini1+1:N_maxg+N_ini1,RMSE_gpm(1:N_maxg),'-o', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#E65100','MarkerFaceColor','#006064');
p3=plot(N_ini1+1:N_maxcm1+N_ini1,RMSE_cgp3m1(1:N_maxcm1),'--^', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#0D47A1');
p4=plot(N_ini1+1:N_maxcm2+N_ini1,RMSE_cgp3m2(1:N_maxcm2),':v', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#4A148C');
p5=plot(N_ini1+1:N_maxcm3+N_ini1,RMSE_cgp3m3(1:N_maxcm3),'-.>', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#3E2723');
p9=plot(N_ini1+1:N_maxmms1+N_ini1,RMSE_mlgp3ms1(1:N_maxmms1),'--x', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#0D47A1');
p10=plot(N_ini1+1:N_maxmms2+N_ini1,RMSE_mlgp3ms2(1:N_maxmms2),':*', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#4A148C');
p11=plot(N_ini1+1:N_maxmms3+N_ini1,RMSE_mlgp3ms3(1:N_maxmms3),'-.+', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#3E2723');
p6=plot(N_ini1+1:N_maxmm1+N_ini1,RMSE_mlgp3m1(1:N_maxmm1),'--d', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#0D47A1');
p7=plot(N_ini1+1:N_maxmm2+N_ini1,RMSE_mlgp3m2(1:N_maxmm2),':s', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#4A148C');
p8=plot(N_ini1+1:N_maxmm3+N_ini1,RMSE_mlgp3m3(1:N_maxmm3),'-.h', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#3E2723');

legend([p2 p3 p4 p5 p9 p10 p11 p6 p7 p8],{'ASGP','AMT-ASCOGP(Meta-task 1)','AMT-ASCOGP(Meta-task 2)' ...
    ,'AMT-ASCOGP(Meta-task 3)','LMT-ASMLGP(Meta-task 1)','LMT-ASMLGP(Meta-task 2)','LMT-ASMLGP(Meta-task 3)','AMT-ASMLGP(Meta-task 1)','AMT-ASMLGP(Meta-task 2)','AMT-ASMLGP(Meta-task 3)'},'Location','northeast', ...
    'FontSize',7,'Fontname', 'Times New Roman','NumColumns',1);
% legend('boxoff')
xlim([5 18+5])
ylim([0 1.2])
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('Total number of target-task RTHS evaluations','fontsize',axis_size,'interpreter','latex');
ylabel('CC','fontsize',axis_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/CC_v3_25_m1_b.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/CC_v3_25_m1_b.pdf','ContentType','vector',"Resolution",600);

%% Selected Sample Points
N_max=20;
hhm=1;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname)
num_run=10;
X_ll1=0;
X_hh1=0.18;
X_ll2=0.7;
X_hh2=2;

[m11,k11] = meshgrid(X_ll1:(X_hh1-X_ll1)/99:X_hh1, X_ll2:(X_hh2-X_ll2)/99:X_hh2);
m111=reshape(m11,1e4,1);
k111=reshape(k11,1e4,1);
ZM_k11(:,1)=m111;
ZM_k11(:,2)=k111;
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
main_data_dir='.\main_tasks\rths_m1\';
    Xs_rese=Xs;
    Ys_rese=Ys;
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
X_ver=ZM_k11;
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y111=reshape(Y_mlgp(:,1),100,100);
%%
figure
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=9;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
text_size=8;%内容字体大小
hold on
surf(m11, k11, Y111,'FaceAlpha',0.2,'EdgeColor','none')
[M,c]=contour(m11, k11, Y111,10);
c.LineWidth =3;
colormap(hsv);
xlim([0 0.16]);
ylim([0.75 1.9]);
b = colorbar('westoutside');
b.Label.String = 'Predicted maximum story displacement (mm)';
set(b,'FontSize',text_size,'Fontname', 'Times New Roman');
hold on

s1=scatter(Xs(1:ini_Xn,1),Xs(1:ini_Xn,2),'k','filled');
c = linspace(30,80,length(Xs(ini_Xn+1:ini_Xn+num_run,1)));
cl = linspace(ini_Xn+1,num_run,num_run);
s2=scatter(Xs(ini_Xn+1:ini_Xn+num_run,1),Xs(ini_Xn+1:ini_Xn+num_run,2),c,'r','filled');
% for i=1:size(Xst(ini_Xn+1:end,1))
%     n=num2str(i+ini_Xn);
%     text(Xst(ini_Xn+i,1)+3,Xst(ini_Xn+i,2)+3,Yst(ini_Xn+i,1),n,'fontsize',10,'Fontname', 'Times New Roman')
% end
legend([s1 s2],{'Initial','Adaptive'},"Location","northeast",'FontSize',text_size);
legend('boxoff');
grid on;
 xlabel('$V_{p}$','fontsize',text_size,'interpreter','latex');
ylabel('$T_{p}$','fontsize',text_size,'interpreter','latex');
zlabel('Maximum story displacement','FontSize',text_size,'Fontname', 'Times New Roman');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca,'box', 'on','fontname','times','linewidth', 1,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, 'figure/Adapatingn_3.tiff','ContentType','image',"Resolution",600);
%%
figure
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=7;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
num_run=10;
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
text_size=8;%内容字体大小
hold on
p2=bar(Ys(1:num_run+ini_Xn,:));
p1=bar(Ys(1:ini_Xn,:));
legend([p1 p2],{'Initial','Adaptive'},"Location","northwest",'FontSize',text_size);
legend('boxoff')
grid on
xlabel('Number','fontsize',text_size,'interpreter','latex');
ylabel('Maximum displacement(mm)','fontsize',text_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca,'box', 'on','fontname','times','linewidth', 1,...
    'xcolor', 'k', 'ycolor', 'k');
set(gca, 'LooseInset', [0.01,0.01,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
exportgraphics(gcf, 'figure/Ys_all_m3.tiff','ContentType','image',"Resolution",600);

%%
rng(0,'twister');
ver_n=1e5;
X_m=[0.06, 1.0];
X_v=[0.015 0.1];
X1_m=X_m(1);
X1_v=X_v(1);
InputOpts.Marginals(1).Name = 'Vp'; 
InputOpts.Marginals(1).Type = 'Lognormal';
InputOpts.Marginals(1).Moments = [X1_m,X1_v];
% InputOpts.Marginals(1).Bounds = [X1_l,X1_u];
X2_m=X_m(2);
X2_v=X_v(2);
InputOpts.Marginals(2).Name = 'Tp';
InputOpts.Marginals(2).Type = 'Gumbel';    
InputOpts.Marginals(2).Moments = [X2_m,X2_v];
% InputOpts.Marginals(2).Bounds = [X2_l,X2_u];
myInput = uq_createInput(InputOpts);
X_ver_f=uq_getSample(myInput,ver_n,'LHS');
load ver_2story2_2ue_1e3_25_exp.mat
%%
figure
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=6;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
ax1=axes('Parent',gcf);hold(ax1,'on')
ax1.Position=[0.13,0.15,0.6,0.6];
s1=scatter(X_ver_f(:,1),X_ver_f(:,2),'.b');
s2=scatter(X_ver(:,1),X_ver(:,2),18,'r',"filled","o");
q = [0.01, 0.25, 0.5, 0.75, 0.99];
xq = quantile(X_ver_f(:,1), q);   % V_p 分位数位置
yq = quantile(X_ver_f(:,2), q);   % T_p 分位数位置
nSeg = numel(q) + 1;     % 6 段
C = lines(nSeg);         % 每段颜色（可换 parula/turbo）
alphaFill = 0.50;        % 填充透明度
legend([s2],{'Validation point'},'FontSize',7,'Fontname', 'Times New Roman','Box','on')

grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('$V_{p}$','fontsize',axis_size,'interpreter','latex');
ylabel('$T_{p}$','fontsize',axis_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
xlim([0.02 0.15]);
ylim([0.75 1.6]);
ax2=axes('Parent',gcf);hold(ax2,'on')
% grid on
[f1,xi1] = ksdensity(X_ver_f(:,1)); 
edgesX = [xi1(1), xq, xi1(end)];
for k = 1:(numel(edgesX)-1)
    a = edgesX(k);  b = edgesX(k+1);

    idx = (xi1 >= a) & (xi1 <= b);
    xseg = xi1(idx);

    if isempty(xseg); continue; end

    % 补齐端点，避免出现“缝”
    if xseg(1) > a, xseg = [a, xseg]; end
    if xseg(end) < b, xseg = [xseg, b]; end

    fseg = interp1(xi1, f1, xseg, 'linear');

    patch(ax2, [xseg, fliplr(xseg)], [fseg, zeros(size(fseg))], C(k,:), ...
        'FaceAlpha', 0.5, 'EdgeColor', 'none');
end

% 叠加 KDE 外轮廓线（可选，但通常更清晰）
plot(ax2, xi1, f1, 'k-', 'LineWidth', 0.6);

% fill([yi1,yi1(1)],[f1,0],[0 0 1],'FaceAlpha',...
%     0.5,'EdgeColor',[0 0 1],'LineWidth',0.5)
% 在 KDE 曲线上计算并标注分位数点
fxq = ksdensity(X_ver_f(:,1), xq);     % PDF at quantile locations
plot(ax2, xq, fxq, 'o', 'MarkerSize',4,'MarkerFaceColor','r','MarkerEdgeColor','r');

    text(ax2, xq(1)-0.01, fxq(1), sprintf('%.0f%%', q(1)*100), ...
        'FontSize',6, 'FontName','Times New Roman', ...
        'HorizontalAlignment','center', 'VerticalAlignment','bottom', ...
        'Color','k');
        text(ax2, xq(2)-0.01, fxq(2)-2, sprintf('%.0f%%', q(2)*100), ...
        'FontSize',6, 'FontName','Times New Roman', ...
        'HorizontalAlignment','center', 'VerticalAlignment','bottom', ...
        'Color','k');
            text(ax2, xq(3)+0.01, fxq(3)-2, sprintf('%.0f%%', q(3)*100), ...
        'FontSize',6, 'FontName','Times New Roman', ...
        'HorizontalAlignment','center', 'VerticalAlignment','bottom', ...
        'Color','k');
                text(ax2, xq(4)+0.01, fxq(4)-2, sprintf('%.0f%%', q(4)*100), ...
        'FontSize',6, 'FontName','Times New Roman', ...
        'HorizontalAlignment','center', 'VerticalAlignment','bottom', ...
        'Color','k');
    text(ax2, xq(5), fxq(5), sprintf('%.0f%%', q(5)*100), ...
        'FontSize',6, 'FontName','Times New Roman', ...
        'HorizontalAlignment','center', 'VerticalAlignment','bottom', ...
        'Color','k');


% h1=histfit(ax2,X1_cand,30);
ax2.Position=[0.13,0.78,0.6,0.15];
ax2.YColor='none';
ax2.XTickLabel='';
ax2.TickDir='out';
ax2.XLim=ax1.XLim;
% grid on
set(gca,'FontSize',8,'Fontname', 'Times New Roman');
xlim([0.02 0.15]);
ax3=axes('Parent',gcf);hold(ax3,'on')
% [f,yi]=ksdensity(X_ver_f(:,2));
% fill([f,0],[yi,yi(1)],[0 0 1],'FaceAlpha',...
%     0.5,'EdgeColor',[0 0 1],'LineWidth',0.5)
[f2,yi2] = ksdensity(X_ver_f(:,2));
yi2 = yi2(:)';          % 行向量
f2  = f2(:)';           % 行向量

edgesY = sort([yi2(1), yq(:)', yi2(end)]);

for k = 1:(numel(edgesY)-1)
    a = edgesY(k);  b = edgesY(k+1);

    yseg = yi2(yi2 >= a & yi2 <= b);
    yseg = sort(unique([a, yseg, b]));
    if numel(yseg) < 2, continue; end

    fseg = interp1(yi2, f2, yseg, 'linear', 'extrap');
    yseg = yseg(:)';     % 行向量
    fseg = fseg(:)';

    % 注意：ax3 横轴是 PDF(f)，纵轴是变量(y)
    Xpoly = [fseg, zeros(1, numel(fseg))];
    Ypoly = [yseg, fliplr(yseg)];

    patch(ax3, Xpoly, Ypoly, C(k,:), ...
        'FaceAlpha', alphaFill, 'EdgeColor', 'none');
end

% 叠加外轮廓线
plot(ax3, f2, yi2, 'k-', 'LineWidth', 0.6);
% 在 KDE 曲线上计算并标注分位数点（注意 ax3 横轴是 PDF 值，纵轴是变量值）
fyq = ksdensity(X_ver_f(:,2), yq);     % PDF at quantile locations
plot(ax3, fyq, yq, 'o','MarkerSize',4,'MarkerFaceColor','r','MarkerEdgeColor','r');

% 可选：标注分位数标签（百分比）
for i = 1:numel(q)
    text(ax3, fyq(i), yq(i), sprintf('%.0f%%', q(i)*100), ...
        'FontSize',6, 'FontName','Times New Roman', ...
        'HorizontalAlignment','left', 'VerticalAlignment','middle', ...
        'Color','k');
    % yline(ax3, yq(i), '--k', 'LineWidth',0.5)
end

ax3.Position=[0.75,0.15,0.15,0.6];
ax3.XColor='none';
ax3.YTickLabel='';
ax3.TickDir='out';
ax3.YLim=ax1.YLim;
ylim([0.75 1.6]);
% grid on
% set(gca,'FontSize',12,'Fontname', 'Times New Roman');
exportgraphics(gcf, './figure/ver_location.tiff','ContentType','image',"Resolution",500);
%%
N_init=5;
MarkerSize1=4;
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=7;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
N_max=20;
N_maxg=15;
N_maxcm1=16;
N_maxmm1=10;
N_maxcm2=13;
N_maxmm2=10;
N_maxcm3=14;
N_maxmm3=11;
N_maxmms1=13;
N_maxmms2=18;
N_maxmms3=13;
hh=1;
hhm=1;
matname=strcat('result1\AK_v3_exp\','pyAK_2story_2ue_v3_expr_',num2str(N_max),'.mat');
load (matname,'RMSEgp')
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEcgp')
RMSE_cgp3m1=RMSEcgp;
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEcgp')
RMSE_cgp3m2=RMSEcgp;
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEcgp')
RMSE_cgp3m3=RMSEcgp;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEmlgp')
RMSE_mlgp3ms1=RMSEmlgp;
hhm=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEmlgp')
hhm=1;
RMSE_mlgp3ms2=RMSEmlgp;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEmlgp')
RMSE_mlgp3ms3=RMSEmlgp;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEmlgp')
RMSE_mlgp3m1=RMSEmlgp;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEmlgp')
RMSE_mlgp3m2=RMSEmlgp;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RMSEmlgp')
RMSE_mlgp3m3=RMSEmlgp;

p2=plot(N_init +(1:N_maxg),RMSEgp(1:N_maxg),'-o', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#E65100','MarkerFaceColor','#006064');
p3=plot(N_init +(1:N_maxcm1),RMSE_cgp3m1(1:N_maxcm1),'--^', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#0D47A1');
p4=plot(N_init +(1:N_maxcm2),RMSE_cgp3m2(1:N_maxcm2),':v', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#4A148C');
p5=plot(N_init +(1:N_maxcm3),RMSE_cgp3m3(1:N_maxcm3),'-.>', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#3E2723');
p9=plot(N_init +(1:N_maxmms1),RMSE_mlgp3ms1(1:N_maxmms1),'--x', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#0D47A1');
p10=plot(N_init +(1:N_maxmms2),RMSE_mlgp3ms2(1:N_maxmms2),':*', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#4A148C');
p11=plot(N_init +(1:N_maxmms3),RMSE_mlgp3ms3(1:N_maxmms3),'-.+', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#3E2723');
p6=plot(N_init +(1:N_maxmm1),RMSE_mlgp3m1(1:N_maxmm1),'--d', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#0D47A1');
p7=plot(N_init +(1:N_maxmm2),RMSE_mlgp3m2(1:N_maxmm2),':s', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#4A148C');
p8=plot(N_init +(1:N_maxmm3),RMSE_mlgp3m3(1:N_maxmm3),'-.h', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#3E2723');
legend([p2 p3 p4 p5 p9 p10 p11 p6 p7 p8],{'ASGP','AMT-ASCOGP(Meta-task 1)','AMT-ASCOGP(Meta-task 2)' ...
    ,'AMT-ASCOGP(Meta-task 3)','LMT-ASMLGP(Meta-task 1)','LMT-ASMLGP(Meta-task 2)','LMT-ASMLGP(Meta-task 3)','AMT-ASMLGP(Meta-task 1)','AMT-ASMLGP(Meta-task 2)','AMT-ASMLGP(Meta-task 3)'},'Location','northeast', ...
    'FontSize',6,'Fontname', 'Times New Roman','NumColumns',1);
% legend('boxoff')
% legend([p2 p3 p4],{'ASGP','ASCOGP','ASMLGP'},'Location','northeast', ...
%     'FontSize',10,'Fontname', 'Times New Roman','NumColumns',1);
% legend('boxoff')
xlim([5 18+5])
ylim([0 0.3])
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('Total number of target-task RTHS evaluations','fontsize',axis_size,'interpreter','latex');
ylabel('RMSE','fontsize',axis_size,'interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/equa_rmsec_v3_25_m3_b.tiff','ContentType','image',"Resolution",600);
% exportgraphics(gcf, './figure/equa_rmsec_v3_25.pdf','ContentType','vector',"Resolution",600);
%%
figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=7;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
N_max=20;
hh=1;
N_max=20;
N_maxg=15;
N_maxcm1=16;
N_maxmm1=10;
N_maxcm2=13;
N_maxmm2=10;
N_maxcm3=14;
N_maxmm3=11;
N_maxmms1=13;
N_maxmms2=18;
N_maxmms3=13;
hh=1;
hhm=1;
matname=strcat('result1\AK_v3_exp\','pyAK_2story_2ue_v3_expr_',num2str(N_max),'.mat');
load (matname,'RRgp')
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRcgp')
RMSE_cgp3m1=RRcgp;
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRcgp')
RMSE_cgp3m2=RRcgp;
matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRcgp')
RMSE_cgp3m3=RRcgp;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRmlgp')
RMSE_mlgp3ms1=RRmlgp;
hhm=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRmlgp')
hhm=1;
RMSE_mlgp3ms2=RRmlgp;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRmlgp')
RMSE_mlgp3ms3=RRmlgp;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRmlgp')
RMSE_mlgp3m1=RRmlgp;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRmlgp')
RMSE_mlgp3m2=RRmlgp;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hhm),'.mat');
load (matname,'RRmlgp')
RMSE_mlgp3m3=RRmlgp;
MarkerSize1=4;
p2=plot(N_init +(1:N_maxg),RRgp(1:N_maxg),'-o', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#E65100','MarkerFaceColor','#006064');
p3=plot(N_init +(1:N_maxcm1),RMSE_cgp3m1(1:N_maxcm1),'--^', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#0D47A1');
p4=plot(N_init +(1:N_maxcm2),RMSE_cgp3m2(1:N_maxcm2),':v', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#4A148C');
p5=plot(N_init +(1:N_maxcm3),RMSE_cgp3m3(1:N_maxcm3),'-.>', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#1B5E20','MarkerFaceColor','#3E2723');
p9=plot(N_init +(1:N_maxmms1),RMSE_mlgp3ms1(1:N_maxmms1),'--x', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#0D47A1');
p10=plot(N_init +(1:N_maxmms2),RMSE_mlgp3ms2(1:N_maxmms2),':*', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#4A148C');
p11=plot(N_init +(1:N_maxmms3),RMSE_mlgp3ms3(1:N_maxmms3),'-.+', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#311B92','MarkerFaceColor','#3E2723');
p6=plot(N_init +(1:N_maxmm1),RMSE_mlgp3m1(1:N_maxmm1),'--d', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#0D47A1');
p7=plot(N_init +(1:N_maxmm2),RMSE_mlgp3m2(1:N_maxmm2),':s', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#4A148C');
p8=plot(N_init +(1:N_maxmm3),RMSE_mlgp3m3(1:N_maxmm3),'-.h', 'LineWidth', 1,'MarkerSize',MarkerSize1,'Color','#B71C1C','MarkerFaceColor','#3E2723');

legend([p2 p3 p4 p5 p9 p10 p11 p6 p7 p8],{'ASGP','AMT-ASCOGP(Meta-task 1)','AMT-ASCOGP(Meta-task 2)' ...
    ,'AMT-ASCOGP(Meta-task 3)','LMT-ASMLGP(Meta-task 1)','LMT-ASMLGP(Meta-task 2)','LMT-ASMLGP(Meta-task 3)','AMT-ASMLGP(Meta-task 1)','AMT-ASMLGP(Meta-task 2)','AMT-ASMLGP(Meta-task 3)'},'Location','southeast', ...
    'FontSize',6,'Fontname', 'Times New Roman','NumColumns',1);

% matname=strcat('result1\AK_v3_exp\','pyAK_2story_2ue_v3_expr_',num2str(N_max),'.mat');
% load (matname,'RRgp')
% matname=strcat('result1\AcK_v3_25\','Ack_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
% load (matname,'RRcgp')
% matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
% load (matname,'RRmlgp')
% 
% p2=plot(1:N_maxg,RRgp(1:N_maxg),'-s', 'LineWidth', 2,'Color','#006064','MarkerFaceColor','#006064');
% p3=plot(1:N_maxc,RRcgp(1:N_maxc),'-o', 'LineWidth', 2,'Color','#E65100','MarkerFaceColor','#E65100');
% p4=plot(1:N_maxm,RRmlgp(1:N_maxm),'-d', 'LineWidth', 2,'Color','#4A148C','MarkerFaceColor','#4A148C');
% 
% legend([p2 p3 p4],{'ASGP','ASCOGP','ASMLGP'},'Location','southeast', ...
%     'FontSize',10,'Fontname', 'Times New Roman','NumColumns',1);
% % legend('boxoff')
xlim([0+5 18+5])
% ylim([0 0.15])
grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
 xlabel('Total number of target-task RTHS evaluations','fontsize',axis_size);
ylabel('R^{2}','fontsize',axis_size);
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/equa_Ri_v3_25_m3_b.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/equa_Ri_v3_25_m3_b.pdf','ContentType','vector',"Resolution",600);

%%
clear
load ver_2story2_2ue_1e3_25_exp.mat

N_max=20;
hh=1;
matname=strcat('result1\AK_v3_exp\','pyAK_2story_2ue_v3_expr_',num2str(N_max),'.mat');
load (matname)
N_maxg=15;
N_maxc=16;
N_maxm=10;
N_maxmms1=13;
N_maxmms2=18;
N_maxmms3=13;
    Xs_rese=Xs(1:ini_Xn+N_maxg,:);
    Ys_rese=Ys(1:ini_Xn+N_maxg,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_gp.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_gp=Y11.mean;
    RRgp(nn,1) = (sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)-sum((Y_ver(:,1)-Y_gp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
    RRgp(nn,1)



matname=strcat('result1\Ack_v3_25\','Ack_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxc,:);
    Ys_rese=Ys(1:ini_Xn+N_maxc,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_ck.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y_cgpm1=Y_mlgp;
    RRcgpm1(nn,1) = (sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)-sum((Y_ver(:,1)-Y_mlgp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
    RRcgpm1(nn,1)
N_maxmm1=10;
N_maxcm2=13;
N_maxmm2=10;
N_maxcm3=14;
N_maxmm3=11;
matname=strcat('result1\Ack_v3_25\','Ack_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxcm2,:);
    Ys_rese=Ys(1:ini_Xn+N_maxcm2,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_ck.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y_cgpm2=Y_mlgp;
    RRcgpm2(nn,1) = (sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)-sum((Y_ver(:,1)-Y_mlgp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
    RRcgpm2(nn,1)

matname=strcat('result1\Ack_v3_25\','Ack_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxcm3,:);
    Ys_rese=Ys(1:ini_Xn+N_maxcm3,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_ck.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    Y_cgpm3=Y_mlgp;
    RRcgpm3(nn,1) = (sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)-sum((Y_ver(:,1)-Y_mlgp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
    RRcgpm3(nn,1)
hh=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxmms1,:);
    Ys_rese=Ys(1:ini_Xn+N_maxmms1,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgpms1=Y11.mean;

hh=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_0.05_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxmms2,:);
    Ys_rese=Ys(1:ini_Xn+N_maxmms2,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgpms2=Y11.mean;

hh=1;
matname=strcat('result1\AMLGP_v3_25\','ASmlgp_32_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxmms3,:);
    Ys_rese=Ys(1:ini_Xn+N_maxmms3,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgpms3=Y11.mean;

matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxmm1,:);
    Ys_rese=Ys(1:ini_Xn+N_maxmm1,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgpm1=Y11.mean;
hh=1;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxmm2,:);
    Ys_rese=Ys(1:ini_Xn+N_maxmm2,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgpm2=Y11.mean;

matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp_m2',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)
meta_data_dir = '.\meta_tasks\rths_m1\';
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
    Xs_rese=Xs(1:ini_Xn+N_maxmm3,:);
    Ys_rese=Ys(1:ini_Xn+N_maxmm3,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgpm3=Y11.mean;


%%

figure;
hold on;
canvasX=5;      %画布右下角点的X坐标
canvasY=5;      %画布右下角点的Y坐标
canvasL=10.5;      %画布宽，由之后命令定义此值的单位为厘米
canvasH=6;      %画布高
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
p1=plot(Y_ver,Y_gp,'o','markersize',5,'MarkerFaceColor','#E65100','MarkerEdgeColor','#006064');
p1.Color(4) = 0.9;
R2g=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_gp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1g=strcat('ASGP-R^2=',num2str(R2g,'%.2f'),'%');

p2=plot(Y_ver,Y_cgpm1,'^','markersize',5,'MarkerFaceColor','#1B5E20','MarkerEdgeColor','#0D47A1');
p2.Color(4) = 0.9;
R2c1=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_cgpm1(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1c1=strcat('AMT-ASCOGP(Meta-task 1)-R^2=',num2str(R2c1,'%.2f'),'%');

p3=plot(Y_ver,Y_cgpm2,'v','markersize',5,'MarkerFaceColor','#1B5E20','MarkerEdgeColor','#4A148C');
p3.Color(4) = 0.9;
R2c2=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_cgpm2(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1c2=strcat('AMT-ASCOGP(Meta-task 2)-R^2=',num2str(R2c2,'%.2f'),'%');

p4=plot(Y_ver,Y_cgpm3,'>','markersize',5,'MarkerFaceColor','#1B5E20','MarkerEdgeColor','#3E2723');
p4.Color(4) = 0.9;
R2c3=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_cgpm3(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1c3=strcat('AMT-ASCOGP(Meta-task 3)-R^2=',num2str(R2c3,'%.2f'),'%');

p8=plot(Y_ver,Y_mlgpms1,'x','markersize',5,'MarkerFaceColor','#311B92','MarkerEdgeColor','#0D47A1');
p8.Color(4) = 0.9;
R2mlgpms1=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_mlgpms1(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1msl=strcat('LMT-ASMLGP(Meta-task 1)-R^2=',num2str(R2mlgpms1,'%.2f'),'%');

p9=plot(Y_ver,Y_mlgpms2,'*','markersize',5,'MarkerFaceColor','#311B92','MarkerEdgeColor','#4A148C');
p9.Color(4) = 0.9;
R2mlgpms2=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_mlgpms2(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1ms2=strcat('LMT-ASMLGP(Meta-task 2)-R^2=',num2str(R2mlgpms2,'%.2f'),'%');

p10=plot(Y_ver,Y_mlgpms3,'+','markersize',5,'MarkerFaceColor','#311B92','MarkerEdgeColor','#3E2723');
p10.Color(4) = 0.9;
R2mlgpms3=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_mlgpms3(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1ms3=strcat('LMT-ASMLGP(Meta-task 3)-R^2=',num2str(R2mlgpms3,'%.2f'),'%');

p5=plot(Y_ver,Y_mlgpm1,'d','markersize',5,'MarkerFaceColor','#B71C1C','MarkerEdgeColor','#0D47A1');
p5.Color(4) = 0.9;
R2mlgpm1=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_mlgpm1(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1ml=strcat('AMT-ASMLGP(Meta-task 1)-R^2=',num2str(R2mlgpm1,'%.2f'),'%');

p6=plot(Y_ver,Y_mlgpm2,'s','markersize',5,'MarkerFaceColor','#B71C1C','MarkerEdgeColor','#4A148C');
p6.Color(4) = 0.9;
R2mlgpm2=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_mlgpm2(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1m2=strcat('AMT-ASMLGP(Meta-task 2)-R^2=',num2str(R2mlgpm2,'%.2f'),'%');

p7=plot(Y_ver,Y_mlgpm3,'h','markersize',5,'MarkerFaceColor','#B71C1C','MarkerEdgeColor','#3E2723');
p7.Color(4) = 0.9;
R2mlgpm3=(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)- ...
    sum((Y_ver(:,1)-Y_mlgpm3(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
name1m3=strcat('AMT-ASMLGP(Meta-task 3)-R^2=',num2str(R2mlgpm3,'%.2f'),'%');

plot(0:0.1:8,0:0.1:8,'LineWidth',2,'Color',[0.4660 0.6740 0.1880])
lgd = legend([p1 p2 p3 p4 p8 p9 p10 p5 p6 p7],{name1g,name1c1,name1c2,name1c3,name1msl,name1ms2,name1ms3,name1ml,name1m2,name1m3},'Location','northeastoutside', ...
    'FontSize',6,'Fontname', 'Times New Roman','NumColumns',1,'Box','off');

grid on
text_size=8;%内容字体大小
axis_size=8;%轴字体大小
tick_size=8;%刻度字体大小
ylabel('Predicted response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
xlabel('True response (mm)','FontSize',8,'Fontname', 'Times New Roman','Interpreter','latex');
set(gca,'FontSize',text_size,'Fontname', 'Times New Roman');
set(gca, 'LooseInset', [0,0,0.01,0]);%去除白边，保留右侧
set(gcf,'color','w'); %设置图片外围底色为白色，默认灰色
set(gca,'box', 'on','fontname','times','linewidth', 0.5,...
    'xcolor', 'k', 'ycolor', 'k');
exportgraphics(gcf, './figure/equa_rr_v3_25_m3_b.tiff','ContentType','image',"Resolution",600);
exportgraphics(gcf, './figure/equa_rr_v3_25_m3_b.pdf','ContentType','vector',"Resolution",600);
%%

%%
rng(0,'twister');
ver_n=1*1e4;
X_m=[0.06, 1.0];
X_v=[0.015 0.1];
X1_m=X_m(1);
X1_v=X_v(1);
InputOpts.Marginals(1).Name = 'Vp'; 
InputOpts.Marginals(1).Type = 'Lognormal';
InputOpts.Marginals(1).Moments = [X1_m,X1_v];
% InputOpts.Marginals(1).Bounds = [X1_l,X1_u];
X2_m=X_m(2);
X2_v=X_v(2);
InputOpts.Marginals(2).Name = 'Tp';
InputOpts.Marginals(2).Type = 'Gumbel';    
InputOpts.Marginals(2).Moments = [X2_m,X2_v];
% InputOpts.Marginals(2).Bounds = [X2_l,X2_u];
myInput = uq_createInput(InputOpts);
X_ver_f=uq_getSample(myInput,ver_n,'LHS');
N_max=20;
hh=1;
N_maxm=10;
matname=strcat('result1\AMLGP_v3_25\','Amlgp_','2story_2ue_v3_exp',num2str(N_max),'_',num2str(hh),'.mat');
load (matname)

    Xs_rese=Xs(1:ini_Xn+N_maxm,:);
    Ys_rese=Ys(1:ini_Xn+N_maxm,:);
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")
X_ver=X_ver_f;
    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
%%
figure;
hold on;
canvasX=5;      % 画布右下角点的X坐标
canvasY=5;      % 画布右下角点的Y坐标
canvasL=11;      % 画布宽（cm）
canvasH=6;      % 画布高（cm）
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);
grid on
y = Y_mlgp(:);                  % ensure column vector
y = y(~isnan(y) & isfinite(y)); % clean NaN/Inf
ulim = 7;                  % failure limit (mm)
n    = numel(y);
nf   = sum(y > ulim);      % if you want y>=ulim, change to (y >= ulim)
pf   = nf / n;             % empirical failure probability
% ---- mean line (and show in legend) ----
mu = mean(y,'omitnan');   % y 已经清洗过，写 omitnan 也无妨

% -----------------------------
% Left y-axis: PDF (histogram)
% -----------------------------
yyaxis left
xline(7,'k--','LineWidth',1.0,'DisplayName','Limit = 7 (mm)');
mline = xline(mu, 'g--', 'LineWidth', 1.2);
mline.DisplayName = sprintf('Mean = %.3f (mm)', mu);
h = histogram(y, 'Normalization','pdf', ...
                 'EdgeColor','#4A148C', ...
                 'FaceAlpha', 1);
h.DisplayName = 'PDF';      % <<< PDF 标注
ylabel('PDF');

% -----------------------------
% Right y-axis: CDF (empirical)
% -----------------------------
yyaxis right
if exist('ecdf','file') == 2
    [F, xF] = ecdf(y);
else
    ysort = sort(y);
    n = numel(ysort);
    xF = ysort;
    F  = (1:n).' / n;
end
p = plot(xF, F, 'r-', 'LineWidth', 2.0);
p.DisplayName = 'CDF';      % <<< CDF 标注
ylabel('CDF');
ylim([0 1]);
ax = gca;
ax.YColor = 'r';
% -----------------------------
% Common formatting
% -----------------------------
xlabel('Maximum displacement response (mm)');

text_size = 8;
set(gca,'FontSize',text_size,'Fontname','Times New Roman');

% Keep left y-axis black (after setting right axis red)
yyaxis left
ax.YColor = 'k';
lgd = legend('show', 'Location','northeastoutside');
set(lgd, 'FontName','Times New Roman', 'FontSize', text_size, 'Box','off');

yyaxis right
set(gca, 'LooseInset', [0,0,0,0]); % 去除白边，保留右侧
set(gcf,'color','w');                 % figure背景白色
set(gca,'box','on','linewidth',0.5);

exportgraphics(gcf, './figure/pdf_dis.tiff', 'ContentType','image',  "Resolution",600);
exportgraphics(gcf, './figure/pdf_dis.pdf',  'ContentType','vector', "Resolution",600);
%%



