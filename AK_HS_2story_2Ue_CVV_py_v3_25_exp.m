 % This program is used to choose experimental design adaptively
clc
% close all
clear;
tic
uqlab;
% addpath('RTHS_sim')
rng(0,'twister');
% rng(100);
%%
Cand_Xn=1e5;
ini_Xn=5;
X_m=[0.06, 1.0];
X_v=[0.015 0.1];
%% sample
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

X_ini=uq_getSample(myInput,ini_Xn,'LHS');
X_cand=uq_getSample(myInput,Cand_Xn,'MC');

 % %}
%%  ini_response 
load result1\AK_v3_exp\adaptive_2story2_2ue_1e3_25_exp.mat Xs Ys
Xs_all=Xs;
Ys_all=Ys;
X_ini=Xs_all(1:ini_Xn,:);
Y_ini=Ys_all(1:ini_Xn,:);
%% 迭代主动学习
main_data_dir='.\main_tasks\';
load ver_2story2_2ue_1e3_25_exp.mat
nn=0;
Xs=X_ini;
Ys=Y_ini;
N_max=20;

while  (nn<N_max)
[~,error]=CVV_GP(Xs,Ys,X_cand,X_m,X_v);  
nn=nn+1
RMSE_gpm(nn,1) = sqrt(sum(error.^2)./size(Xs,1))/(max(Ys)-min(Ys));
RMSE_gpm(nn,1)
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
    system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_gp.py');
    filename = [main_data_dir,'test_ver_prediction','.mat'];
    Y11=load (filename);
    Y_gp=Y11.mean;
RMSEgp(nn,1) = sqrt(sum((Y_ver(:,1)-Y_gp(:,1)).^2)./size(X_ver,1))./(max(Y_ver)-min(Y_ver));
RMSEgp(nn,1)
RRgp(nn,1) = (sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2)-sum((Y_ver(:,1)-Y_gp(:,1)).^2))/(sum((Y_ver(:,1)-mean(Y_ver(:,1))).^2))*100;
RRgp(nn,1)


index5=find(X_cand==Xs_new,1);
X_cand(index5,:)=[];
end

%%
toc
matname=strcat('result1\AK_v3_exp\','pyAK_','2story_2ue_v3_expr_',num2str(nn),'.mat');
save (matname)

