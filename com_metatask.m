clear
clc;
uqlab;
rng(0,'twister');
addpath('RTHS_sim')
main_data_dir = '.\main_tasks\';
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
%% Quantitative transfer diagnostics for Figure 5
% This block computes response correlation, normalized RMSE,
% peak-response error, and hysteretic-energy error for each meta-task.

% -----------------------------
% 1. Basic settings
% -----------------------------
t_eval_max = 10;       % The time interval shown in Figure 5 is 0–10 s

% If meta-task restoring forces are in N and target-task forces are in kN,
% use the following scaling.
% If target-task forces are also in N, change Fscale_target to 1e-3.
Fscale_meta   = 1e-3;  % N to kN
Fscale_target = 1.0;   % target force is assumed to be kN in bddata

% Time vector for meta-task simulations
% The RTHS model uses T_end = 30 s and dt_cal = 1/1024 s.
t_meta = linspace(0, 30, length(xcm11))';

% Target-task time vector
t_target = tm(:);

% Common evaluation time vector
idx_eval = (t_target >= 0) & (t_target <= t_eval_max);
t_common = t_target(idx_eval);

% -----------------------------
% 2. Organize meta-task responses
% -----------------------------
Meta(1).name = 'Meta-task 1';
Meta(1).x1 = xcm11(:);
Meta(1).x2 = xcm21(:);
Meta(1).f1 = fmm11(:) * Fscale_meta;
Meta(1).f2 = fmm21(:) * Fscale_meta;

Meta(2).name = 'Meta-task 2';
Meta(2).x1 = xcm12(:);
Meta(2).x2 = xcm22(:);
Meta(2).f1 = fmm12(:) * Fscale_meta;
Meta(2).f2 = fmm22(:) * Fscale_meta;

Meta(3).name = 'Meta-task 3';
Meta(3).x1 = xcm13(:);
Meta(3).x2 = xcm23(:);
Meta(3).f1 = fmm13(:) * Fscale_meta;
Meta(3).f2 = fmm23(:) * Fscale_meta;

% Target-task responses
Target.x1 = xcmm1(:);
Target.x2 = xcmm2(:);
Target.f1 = fmmm1(:) * Fscale_target;
Target.f2 = fmmm2(:) * Fscale_target;

% Interpolate target responses onto the common time vector
x1_t = interp1(t_target, Target.x1, t_common, 'linear', 'extrap');
x2_t = interp1(t_target, Target.x2, t_common, 'linear', 'extrap');
f1_t = interp1(t_target, Target.f1, t_common, 'linear', 'extrap');
f2_t = interp1(t_target, Target.f2, t_common, 'linear', 'extrap');

resp_t = [x1_t(:); x2_t(:)];
peak_t = max(abs(resp_t));
range_t = max(resp_t) - min(resp_t);

E_t = hysteretic_energy_abs(x1_t, f1_t) + hysteretic_energy_abs(x2_t, f2_t);

% -----------------------------
% 3. Load learned MLGP weights if available
% -----------------------------
w_meta = nan(3,1);

% Modify this filename according to your actual MLGP output file.
weight_file = fullfile(main_data_dir, 'test_ver_prediction.mat');

if exist(weight_file, 'file')
    Wdata = load(weight_file);

    if isfield(Wdata, 'weights')
        w_tmp = squeeze(Wdata.weights);
        if numel(w_tmp) >= 3
            w_meta = w_tmp(1:3);
        end
    elseif isfield(Wdata, 'w')
        w_tmp = squeeze(Wdata.w);
        if numel(w_tmp) >= 3
            w_meta = w_tmp(1:3);
        end
    end
end

% -----------------------------
% 4. Compute diagnostics
% -----------------------------
TaskName = strings(3,1);
ResponseCorrelation = zeros(3,1);
NormalizedRMSE = zeros(3,1);
PeakError_percent = zeros(3,1);
EnergyError_percent = zeros(3,1);
LearnedWeight = w_meta;

for im = 1:3
    TaskName(im) = Meta(im).name;

    % Interpolate meta-task responses onto the common time vector
    x1_m = interp1(t_meta, Meta(im).x1, t_common, 'linear', 'extrap');
    x2_m = interp1(t_meta, Meta(im).x2, t_common, 'linear', 'extrap');
    f1_m = interp1(t_meta, Meta(im).f1, t_common, 'linear', 'extrap');
    f2_m = interp1(t_meta, Meta(im).f2, t_common, 'linear', 'extrap');

    resp_m = [x1_m(:); x2_m(:)];

    % Response correlation coefficient
    R = corrcoef(resp_m, resp_t);
    ResponseCorrelation(im) = R(1,2);

    % Normalized RMSE of displacement time histories
    rmse_val = sqrt(mean((resp_m - resp_t).^2));
    NormalizedRMSE(im) = rmse_val / range_t;

    % Peak-response error
    peak_m = max(abs(resp_m));
    PeakError_percent(im) = abs(peak_m - peak_t) / peak_t * 100;

    % Hysteretic energy error
    E_m = hysteretic_energy_abs(x1_m, f1_m) + hysteretic_energy_abs(x2_m, f2_m);
    EnergyError_percent(im) = abs(E_m - E_t) / E_t * 100;
end

% -----------------------------
% 5. Generate table
% -----------------------------
DiagTable = table( ...
    TaskName, ...
    ResponseCorrelation, ...
    NormalizedRMSE, ...
    PeakError_percent, ...
    EnergyError_percent, ...
    LearnedWeight, ...
    'VariableNames', { ...
    'MetaTask', ...
    'ResponseCorrelation', ...
    'NormalizedRMSE', ...
    'PeakError_percent', ...
    'EnergyError_percent', ...
    'LearnedWeight'});

disp(DiagTable);

% Save table
if ~exist('./table', 'dir')
    mkdir('./table');
end

writetable(DiagTable, './table/transfer_diagnostics_Figure5.csv');
writetable(DiagTable, './table/transfer_diagnostics_Figure5.xlsx');

%% Local function
function E = hysteretic_energy_abs(u, f)
% Compute cumulative absolute hysteretic work.
% u: displacement, f: restoring force.
% The unit is force × displacement, e.g., kN·mm if f is in kN and u is in mm.

u = u(:);
f = f(:);

du = diff(u);
f_mid = 0.5 * (f(1:end-1) + f(2:end));

E = sum(abs(f_mid .* du));
end