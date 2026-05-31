%% ============================================================
%  Corrected full program: computation + R2 + plotting
% ============================================================

clear;
clc;

%% -------------------- Basic settings --------------------
load ver_2story2_2ue_1e3_25_exp.mat

pyExe = 'D:\ProgramData\anaconda3\envs\py391\python.exe';

N_max = 20;
hh = 1;

N_maxg    = 15;
N_maxc    = 16;

N_maxcm2  = 13;
N_maxcm3  = 14;

N_maxmms1 = 13;
N_maxmms2 = 18;
N_maxmms3 = 13;

N_maxmm1  = 10;
N_maxmm2  = 10;
N_maxmm3  = 11;

meta_data_dir = '.\meta_tasks\rths_m1\';

% 是否在每次保存新的 meta-task 前清空旧 meta-task 文件
% 建议设为 true，避免不同 meta-task 之间互相污染
cleanMetaDirBeforeSave = true;

%% ============================================================
%  1. ASGP
% ============================================================

%% ============================================================
%  1. ASGP  -- independent GP prediction, no meta-task, no weight
% ============================================================
main_data_dir='.\main_tasks\';
matname = strcat('result1\AK_v3_exp\', ...
    'pyAK_2story_2ue_v3_expr_', num2str(N_max), '.mat');

S_asgp = load(matname);

Xs_rese = S_asgp.Xs(1:S_asgp.ini_Xn + N_maxg, :);
Ys_rese = S_asgp.Ys(1:S_asgp.ini_Xn + N_maxg, :);

% 与原始程序保持一致：只保存主任务训练样本
filename = [main_data_dir, 'rmse_task_', 'main_', 'date', '.mat'];
save(filename, "Xs_rese", "Ys_rese");

% 与原始程序保持一致：只保存验证输入
filename = [main_data_dir, 'rmse_task_', 'test_', 'date', '.mat'];
save(filename, "X_ver");

% 只调用 GP 预测脚本，不调用 MLGP/CK/权重预测脚本
cmd = ['"', pyExe, '" predict_ver_n_gp.py'];
status = system(cmd);

if status ~= 0
    error('ASGP prediction failed. Please check predict_ver_n_gp.py.');
end

% 读取 ASGP 预测结果
filename = [main_data_dir, 'test_ver_prediction', '.mat'];
Y11 = load(filename);

Y_gp = Y11.mean;

% 备份 ASGP 结果，避免后面方法覆盖
filename_backup = [main_data_dir, 'test_ver_prediction_asgp.mat'];
save(filename_backup, "Y_gp");

% ASGP R2
R2_asgp = calc_R2_value(Y_ver(:,1), Y_gp(:,1));

fprintf('ASGP R2 = %.4f %%\n', R2_asgp);

%% ============================================================
%  2. AMT-ASCOGP
% ============================================================
main_data_dir='.\main_tasks\rths_m1\';
% ---------- Meta-task 1 ----------
matname = strcat('result1\Ack_v3_25\', ...
    'Ack_', '2story_2ue_v3_exp', num2str(N_max), '_', num2str(hh), '.mat');

[Y_cgpm1, R2_cgpm1] = run_prediction_case( ...
    'amt_ascogp_m1', matname, N_maxc, ...
    pyExe, 'predict_ver_n_ck.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('AMT-ASCOGP Meta-task 1 R2 = %.4f %%\n', R2_cgpm1);


% ---------- Meta-task 2 ----------
matname = strcat('result1\Ack_v3_25\', ...
    'Ack_', '2story_2ue_v3_exp_m1', num2str(N_max), '_', num2str(hh), '.mat');

[Y_cgpm2, R2_cgpm2] = run_prediction_case( ...
    'amt_ascogp_m2', matname, N_maxcm2, ...
    pyExe, 'predict_ver_n_ck.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('AMT-ASCOGP Meta-task 2 R2 = %.4f %%\n', R2_cgpm2);


% ---------- Meta-task 3 ----------
matname = strcat('result1\Ack_v3_25\', ...
    'Ack_', '2story_2ue_v3_exp_m2', num2str(N_max), '_', num2str(hh), '.mat');

[Y_cgpm3, R2_cgpm3] = run_prediction_case( ...
    'amt_ascogp_m3', matname, N_maxcm3, ...
    pyExe, 'predict_ver_n_ck.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('AMT-ASCOGP Meta-task 3 R2 = %.4f %%\n', R2_cgpm3);


%% ============================================================
%  3. SMT-ASMLGP
% ============================================================

% ---------- Meta-task 1 ----------
matname = strcat('result1\AMLGP_v3_25\', ...
    'ASmlgp_32_', '2story_2ue_v3_exp', num2str(N_max), '_', num2str(hh), '.mat');

[Y_mlgpms1, R2_smt_m1] = run_prediction_case( ...
    'smt_asmlgp_m1', matname, N_maxmms1, ...
    pyExe, 'predict_ver_n_1.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('LMT-ASMLGP Meta-task 1 R2 = %.4f %%\n', R2_smt_m1);

hh=1;
% ---------- Meta-task 2 ----------
matname = strcat('result1\AMLGP_v3_25\', ...
    'ASmlgp_32_', '2story_2ue_v3_exp_m1', num2str(N_max), '_', num2str(hh), '.mat');

[Y_mlgpms2, R2_smt_m2] = run_prediction_case( ...
    'smt_asmlgp_m2', matname, N_maxmms2, ...
    pyExe, 'predict_ver_n_1.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('LMT-ASMLGP Meta-task 2 R2 = %.4f %%\n', R2_smt_m2);

hh=1;
% ---------- Meta-task 3 ----------
matname = strcat('result1\AMLGP_v3_25\', ...
    'ASmlgp_32_', '2story_2ue_v3_exp_m2', num2str(N_max), '_', num2str(hh), '.mat');

[Y_mlgpms3, R2_smt_m3] = run_prediction_case( ...
    'smt_asmlgp_m3', matname, N_maxmms3, ...
    pyExe, 'predict_ver_n_1.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('LMT-ASMLGP Meta-task 3 R2 = %.4f %%\n', R2_smt_m3);


%% ============================================================
%  4. AMT-ASMLGP
% ============================================================

% ---------- Meta-task 1 ----------
matname = strcat('result1\AMLGP_v3_25\', ...
    'Amlgp_', '2story_2ue_v3_exp', num2str(N_max), '_', num2str(hh), '.mat');

[Y_mlgpm1, R2_amt_m1] = run_prediction_case( ...
    'amt_asmlgp_m1', matname, N_maxmm1, ...
    pyExe, 'predict_ver_n_1.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('AMT-ASMLGP Meta-task 1 R2 = %.4f %%\n', R2_amt_m1);


% ---------- Meta-task 2 ----------
matname = strcat('result1\AMLGP_v3_25\', ...
    'Amlgp_', '2story_2ue_v3_exp_m1', num2str(N_max), '_', num2str(hh), '.mat');

[Y_mlgpm2, R2_amt_m2] = run_prediction_case( ...
    'amt_asmlgp_m2', matname, N_maxmm2, ...
    pyExe, 'predict_ver_n_1.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('AMT-ASMLGP Meta-task 2 R2 = %.4f %%\n', R2_amt_m2);


% ---------- Meta-task 3 ----------
matname = strcat('result1\AMLGP_v3_25\', ...
    'Amlgp_', '2story_2ue_v3_exp_m2', num2str(N_max), '_', num2str(hh), '.mat');

[Y_mlgpm3, R2_amt_m3] = run_prediction_case( ...
    'amt_asmlgp_m3', matname, N_maxmm3, ...
    pyExe, 'predict_ver_n_1.py', ...
    main_data_dir, X_ver, Y_ver, ...
    true, meta_data_dir, cleanMetaDirBeforeSave);

fprintf('AMT-ASMLGP Meta-task 3 R2 = %.4f %%\n', R2_amt_m3);


%% ============================================================
%  5. Plotting
% ============================================================

figure;
hold on;

canvasX = 5;
canvasY = 5;
canvasL = 10.5;
canvasH = 6;
set(gcf,'unit','centimeters','position',[canvasX canvasY canvasL canvasH]);

y_true = Y_ver(:,1);

% ---------- ASGP ----------
p1 = plot(y_true, Y_gp(:,1), 'o', ...
    'markersize',5, ...
    'MarkerFaceColor','#E65100', ...
    'MarkerEdgeColor','#006064');
p1.Color(4) = 0.9;
name_asgp = strcat('ASGP-R^2=', num2str(R2_asgp,'%.2f'), '%');


% ---------- AMT-ASCOGP ----------
p2 = plot(y_true, Y_cgpm1(:,1), '^', ...
    'markersize',5, ...
    'MarkerFaceColor','#1B5E20', ...
    'MarkerEdgeColor','#0D47A1');
p2.Color(4) = 0.9;
name_cgpm1 = strcat('AMT-ASCOGP(Meta-task 1)-R^2=', num2str(R2_cgpm1,'%.2f'), '%');

p3 = plot(y_true, Y_cgpm2(:,1), 'v', ...
    'markersize',5, ...
    'MarkerFaceColor','#1B5E20', ...
    'MarkerEdgeColor','#4A148C');
p3.Color(4) = 0.9;
name_cgpm2 = strcat('AMT-ASCOGP(Meta-task 2)-R^2=', num2str(R2_cgpm2,'%.2f'), '%');

p4 = plot(y_true, Y_cgpm3(:,1), '>', ...
    'markersize',5, ...
    'MarkerFaceColor','#1B5E20', ...
    'MarkerEdgeColor','#3E2723');
p4.Color(4) = 0.9;
name_cgpm3 = strcat('AMT-ASCOGP(Meta-task 3)-R^2=', num2str(R2_cgpm3,'%.2f'), '%');


% ---------- SMT-ASMLGP ----------
p8 = plot(y_true, Y_mlgpms1(:,1), 'x', ...
    'markersize',5, ...
    'MarkerFaceColor','#311B92', ...
    'MarkerEdgeColor','#0D47A1');
p8.Color(4) = 0.9;
name_smt_m1 = strcat('LMT-ASMLGP(Meta-task 1)-R^2=', num2str(R2_smt_m1,'%.2f'), '%');

p9 = plot(y_true, Y_mlgpms2(:,1), '*', ...
    'markersize',5, ...
    'MarkerFaceColor','#311B92', ...
    'MarkerEdgeColor','#4A148C');
p9.Color(4) = 0.9;
name_smt_m2 = strcat('LMT-ASMLGP(Meta-task 2)-R^2=', num2str(R2_smt_m2,'%.2f'), '%');

p10 = plot(y_true, Y_mlgpms3(:,1), '+', ...
    'markersize',5, ...
    'MarkerFaceColor','#311B92', ...
    'MarkerEdgeColor','#3E2723');
p10.Color(4) = 0.9;
name_smt_m3 = strcat('LMT-ASMLGP(Meta-task 3)-R^2=', num2str(R2_smt_m3,'%.2f'), '%');


% ---------- AMT-ASMLGP ----------
p5 = plot(y_true, Y_mlgpm1(:,1), 'd', ...
    'markersize',5, ...
    'MarkerFaceColor','#B71C1C', ...
    'MarkerEdgeColor','#0D47A1');
p5.Color(4) = 0.9;
name_amt_m1 = strcat('AMT-ASMLGP(Meta-task 1)-R^2=', num2str(R2_amt_m1,'%.2f'), '%');

p6 = plot(y_true, Y_mlgpm2(:,1), 's', ...
    'markersize',5, ...
    'MarkerFaceColor','#B71C1C', ...
    'MarkerEdgeColor','#4A148C');
p6.Color(4) = 0.9;
name_amt_m2 = strcat('AMT-ASMLGP(Meta-task 2)-R^2=', num2str(R2_amt_m2,'%.2f'), '%');

p7 = plot(y_true, Y_mlgpm3(:,1), 'h', ...
    'markersize',5, ...
    'MarkerFaceColor','#B71C1C', ...
    'MarkerEdgeColor','#3E2723');
p7.Color(4) = 0.9;
name_amt_m3 = strcat('AMT-ASMLGP(Meta-task 3)-R^2=', num2str(R2_amt_m3,'%.2f'), '%');


% ---------- 1:1 reference line ----------
all_data = [ ...
    y_true; ...
    Y_gp(:,1); ...
    Y_cgpm1(:,1); Y_cgpm2(:,1); Y_cgpm3(:,1); ...
    Y_mlgpms1(:,1); Y_mlgpms2(:,1); Y_mlgpms3(:,1); ...
    Y_mlgpm1(:,1); Y_mlgpm2(:,1); Y_mlgpm3(:,1)];

axis_min = floor(min(all_data) * 10) / 10;
axis_max = ceil(max(all_data) * 10) / 10;

p_ref = plot([axis_min axis_max], [axis_min axis_max], ...
    'LineWidth',2, ...
    'Color',[0.4660 0.6740 0.1880]);
p_ref.HandleVisibility = 'off';

xlim([axis_min axis_max]);
ylim([axis_min axis_max]);


% ---------- Legend ----------
legend([p1 p2 p3 p4 p8 p9 p10 p5 p6 p7], ...
    {name_asgp, ...
     name_cgpm1, name_cgpm2, name_cgpm3, ...
     name_smt_m1, name_smt_m2, name_smt_m3, ...
     name_amt_m1, name_amt_m2, name_amt_m3}, ...
    'Location','northeastoutside', ...
    'FontSize',6, ...
    'Fontname','Times New Roman', ...
    'NumColumns',1, ...
    'Box','off');


% ---------- Axis settings ----------
grid on;

ylabel('Predicted response (mm)', ...
    'FontSize',8, ...
    'Fontname','Times New Roman', ...
    'Interpreter','latex');

xlabel('True response (mm)', ...
    'FontSize',8, ...
    'Fontname','Times New Roman', ...
    'Interpreter','latex');

set(gca, ...
    'FontSize',8, ...
    'Fontname','Times New Roman');

set(gca, ...
    'LooseInset',[0,0,0.01,0]);

set(gcf,'color','w');

set(gca, ...
    'box','on', ...
    'fontname','times', ...
    'linewidth',0.5, ...
    'xcolor','k', ...
    'ycolor','k');


% ---------- Export ----------
if ~exist('./figure','dir')
    mkdir('./figure');
end

exportgraphics(gcf, './figure/equa_rr_v3_25_m3_b.tiff', ...
    'ContentType','image', ...
    'Resolution',600);

exportgraphics(gcf, './figure/equa_rr_v3_25_m3_b.pdf', ...
    'ContentType','vector', ...
    'Resolution',600);


%% ============================================================
%  6. Print R2 summary
% ============================================================

fprintf('\n================ R2 Summary ================\n');
fprintf('ASGP                         : %.4f %%\n', R2_asgp);
fprintf('AMT-ASCOGP Meta-task 1       : %.4f %%\n', R2_cgpm1);
fprintf('AMT-ASCOGP Meta-task 2       : %.4f %%\n', R2_cgpm2);
fprintf('AMT-ASCOGP Meta-task 3       : %.4f %%\n', R2_cgpm3);
fprintf('LMT-ASMLGP Meta-task 1       : %.4f %%\n', R2_smt_m1);
fprintf('LMT-ASMLGP Meta-task 2       : %.4f %%\n', R2_smt_m2);
fprintf('LMT-ASMLGP Meta-task 3       : %.4f %%\n', R2_smt_m3);
fprintf('AMT-ASMLGP Meta-task 1       : %.4f %%\n', R2_amt_m1);
fprintf('AMT-ASMLGP Meta-task 2       : %.4f %%\n', R2_amt_m2);
fprintf('AMT-ASMLGP Meta-task 3       : %.4f %%\n', R2_amt_m3);
fprintf('============================================\n');


%% ============================================================
%  Local functions
% ============================================================

function [Y_pred, R2_value] = run_prediction_case( ...
    caseTag, matname, N_add, ...
    pyExe, pyScript, ...
    main_data_dir, X_ver, Y_ver, ...
    useMetaTask, meta_data_dir, cleanMetaDirBeforeSave)

    fprintf('\nRunning case: %s\n', caseTag);

    % ---------- Load data ----------
    if ~exist(matname,'file')
        error('MAT file does not exist: %s', matname);
    end

    S = load(matname);

    if ~isfield(S,'Xs') || ~isfield(S,'Ys') || ~isfield(S,'ini_Xn')
        error('The file %s must contain Xs, Ys, and ini_Xn.', matname);
    end

    nEnd = S.ini_Xn + N_add;

    if nEnd > size(S.Xs,1)
        error('For case %s, ini_Xn + N_add exceeds the number of rows in Xs.', caseTag);
    end

    Xs_rese = S.Xs(1:nEnd,:);
    Ys_rese = S.Ys(1:nEnd,:);

    % ---------- Save meta-task data ----------
    if useMetaTask
        if ~isfield(S,'X_meta') || ~isfield(S,'Y_meta')
            error('The file %s must contain X_meta and Y_meta for meta-task prediction.', matname);
        end

        if isfield(S,'i_mate')
            i_mate = S.i_mate;
        else
            i_mate = 1;
        end

        if ~exist(meta_data_dir,'dir')
            mkdir(meta_data_dir);
        end

        if cleanMetaDirBeforeSave
            oldFiles = dir(fullfile(meta_data_dir,'*.mat'));
            for k = 1:numel(oldFiles)
                delete(fullfile(oldFiles(k).folder, oldFiles(k).name));
            end
        end

        X_meta = S.X_meta;
        Y_meta = S.Y_meta;

        metaFile = fullfile(meta_data_dir, ...
            ['task_', num2str(i_mate), '_date.mat']);

        save(metaFile, 'X_meta', 'Y_meta');

        fprintf('Meta-task file saved: %s\n', metaFile);
    end

    % ---------- Save main-task and test data ----------
    if ~exist(main_data_dir,'dir')
        mkdir(main_data_dir);
    end

    mainFile = fullfile(main_data_dir, 'rmse_task_main_date.mat');
    testFile = fullfile(main_data_dir, 'rmse_task_test_date.mat');

    save(mainFile, 'Xs_rese', 'Ys_rese');
    save(testFile, 'X_ver');

    % ---------- Run Python prediction ----------
    cmd = ['"', pyExe, '" ', pyScript];
    status = system(cmd);

    if status ~= 0
        error('Python prediction failed for case %s. Command: %s', caseTag, cmd);
    end

    % ---------- Load prediction ----------
    predFile = fullfile(main_data_dir, 'test_ver_prediction.mat');

    if ~exist(predFile,'file')
        error('Prediction file was not generated for case %s: %s', caseTag, predFile);
    end

    Yout = load(predFile);

    if ~isfield(Yout,'mean')
        error('Prediction file %s does not contain variable "mean".', predFile);
    end

    Y_pred = Yout.mean;

    % ---------- Backup prediction result ----------
    backupFile = fullfile(main_data_dir, ...
        ['test_ver_prediction_', caseTag, '.mat']);

    copyfile(predFile, backupFile, 'f');

    fprintf('Prediction backup saved: %s\n', backupFile);

    % ---------- Calculate R2 ----------
    R2_value = calc_R2_value(Y_ver(:,1), Y_pred(:,1));
end


function R2_value = calc_R2_value(y_true, y_pred)
    SS_tot = sum((y_true - mean(y_true)).^2);
    SS_res = sum((y_true - y_pred).^2);
    R2_value = (1 - SS_res / SS_tot) * 100;
end