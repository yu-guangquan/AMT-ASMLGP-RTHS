 % This program is used to choose experimental design adaptively
clc
% close all
clear;
tic
uqlab;
addpath('RTHS_sim')
% addpath('dace')
% rng(100);
for hh=1:1
%%
rng(hh-1,'twister');
Cand_Xn=1e5;
ini_Xn=5;
X_m1=[0.06, 1.0];
X_v1=[0.015 0.1];

X_m2=[0.06, 1.0];
X_v2=[0.015 0.1];
%% sample
X1_m=X_m1(1);
X1_v=X_v1(1);
InputOpts.Marginals(1).Name = 'Vp'; 
InputOpts.Marginals(1).Type = 'Lognormal';
InputOpts.Marginals(1).Moments = [X1_m,X1_v];
X2_m=X_m1(2);
X2_v=X_v1(2);
InputOpts.Marginals(2).Name = 'Tp';
InputOpts.Marginals(2).Type = 'Gumbel';    
InputOpts.Marginals(2).Moments = [X2_m,X2_v];
myInput = uq_createInput(InputOpts);

X1_m1=X_m2(1);
X1_v1=X_v2(1);
InputOpts1.Marginals(1).Name = 'Vp'; 
InputOpts1.Marginals(1).Type = 'Lognormal';
InputOpts1.Marginals(1).Moments = [X1_m1,X1_v1];
X2_m1=X_m2(2);
X2_v1=X_v2(2);
InputOpts1.Marginals(2).Name = 'Tp';
InputOpts1.Marginals(2).Type = 'Gumbel';    
InputOpts1.Marginals(2).Moments = [X2_m1,X2_v1];
myInput1 = uq_createInput(InputOpts1);

X_ini=uq_getSample(myInput,ini_Xn,'LHS');
X_cand1=uq_getSample(myInput,Cand_Xn,'MC');
dt=0.01;
t=0:dt:10;
time=t';
Earthquake_record_X = zeros(length(time),2); %Stochastic Ground Motion
Earthquake_record_X(:,1)=time;
%%  辅助任务1
cn=0.05;
X_candm1=uq_getSample(myInput1,Cand_Xn,'MC');
X_cand=X_candm1;
meta_data_dir = '.\meta_tasks\rths_m1\';
num_meta_ini = 5;
X_meta_ini=uq_getSample(myInput1,num_meta_ini,'LHS');
Y_meta_ini=ones(num_meta_ini,1);
i_mate = 1;
for iuu=1:num_meta_ini
    GM = pulse_groundmotion(X_meta_ini(iuu,1),X_meta_ini(iuu,2));
    Earthquake_record_X(:,2) = GM*1000;
    run Model_Input_equa_m1.m;
    run RT_F2D_Bld;
    sim('Virtual_RTHS_CR_sca')
    Y_meta_ini(iuu,1)=max([max(abs(xc1));max(abs(xc2))]);    
end
Xs_mete1=X_meta_ini;
Ys_mete1=Y_meta_ini;

%% 辅助任务1
nn=0;
N_max=100;
while  (nn<N_max)
[Xs_new,error]=CVV_GP(Xs_mete1,Ys_mete1,X_cand,X_m2,X_v2);  
Ys_new=zeros(1,1);
    GM = pulse_groundmotion(Xs_new(1,1),Xs_new(1,2));
    Earthquake_record_X(:,2) = GM*1000;
    run Model_Input_equa_m1.m;
    run RT_F2D_Bld;
    sim('Virtual_RTHS_CR_sca')
    Ys_new(1,1)=max([max(abs(xc1));max(abs(xc2))]);    
nn=nn+1
Xs_mete1(num_meta_ini+nn,:)=Xs_new;
Ys_mete1(num_meta_ini+nn,:)=Ys_new;
    RMSE_gp1(nn,1) = sqrt(sum(error.^2)./size(Xs_mete1,1))/(max(Ys_mete1)-min(Ys_mete1));
    RMSE_gp1(nn,1)

if nn>2
    if RMSE_gp1(nn,1)<cn && RMSE_gp1(nn-1,1)<cn
        break
    end
end

index5=find(X_cand==Xs_new,1);
X_cand(index5,:)=[];

end
X_meta=Xs_mete1;
Y_meta=Ys_mete1;
filename = [meta_data_dir,'task_', num2str(i_mate),'_date', '.mat'];
save(filename,"X_meta","Y_meta")
%%  ini_response 
load result1\AK_v3_exp\adaptive_2story2_2ue_1e3_25_exp.mat Xs Ys
X_cand=X_cand1;
Xs_all=Xs;
Ys_all=Ys;
X_ini=Xs_all(1:ini_Xn,:);
Y_ini=Ys_all(1:ini_Xn,:);
%% 迭代主动学习
main_data_dir='.\main_tasks\rths_m1\';
load ver_2story2_2ue_1e3_25_exp.mat
nn=0;
Xs=X_ini;
Ys=Y_ini;
N_max=20;

while  (nn<N_max)
[~,error]=CVV_GP(Xs,Ys,X_cand,X_m1,X_v1);  
[~,errorm]=CVV_coGP(Xs,Ys,X_cand,X_m1,X_v1);
nn=nn+1
RMSE_gpm(nn,1) = sqrt(sum(error.^2)./size(Xs,1))/(max(Ys)-min(Ys));
RMSE_gpm(nn,1)
    RMSE_mlgp3m(nn,1) = sqrt(sum(errorm.^2)./size(Xs,1))./(max(Ys)-min(Ys));
    RMSE_mlgp3m(nn,1)
Xs_new=Xs_all(ini_Xn+nn,:);
Ys_new=Ys_all(ini_Xn+nn,:);
Xs(ini_Xn+nn,:)=Xs_new;
Ys(ini_Xn+nn,:)=Ys_new;
    Xs_rese=Xs;
    Ys_rese=Ys;
    filename = [main_data_dir,'rmse_task_', 'main_','date', '.mat'];
    save(filename,"Xs_rese","Ys_rese")

    filename = [main_data_dir,'rmse_task_', 'test_','date', '.mat'];
    save(filename,"X_ver")
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_ck.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_mlgp=Y11.mean;
    % mlgp_weig(nn,1)=Y11.weights;
RMSEcgp(nn,1) = sqrt(sum((Y_ver(:,1)-Y_mlgp(:,1)).^2)./size(X_ver,1))./(max(Y_ver)-min(Y_ver));
RMSEcgp(nn,1)
    RRcgp(nn,1) = (sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)-sum((Y_ver(:,1)-Y_mlgp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
    RRcgp(nn,1)
% if RMSEgp(nn,1)<0.02
%     break
% end

index5=find(X_cand==Xs_new,1);
X_cand(index5,:)=[];

end

%%
toc
matname=strcat('result1\Ack_v3_25\','Ack_','2story_2ue_v3_exp_m1',num2str(N_max),'_',num2str(hh),'.mat');
save (matname)
clearvars -except hh
end
%%
% figure
% hold on
% plot(xc1)
% plot(xc2)
