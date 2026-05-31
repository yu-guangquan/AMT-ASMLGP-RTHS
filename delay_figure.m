clear;
clc;

%% ============================================================
%  Actuator tracking metrics for all RTHS tests
% =============================================================

dataDir  = 'adap_25';
outDir   = 'table';
figDir   = 'figure';

if ~exist(outDir, 'dir')
    mkdir(outDir);
end

if ~exist(figDir, 'dir')
    mkdir(figDir);
end

%% ------------------------------------------------------------
%  1. Read all test files
% -------------------------------------------------------------
files = dir(fullfile(dataDir, 'test_*.mat'));

% Sort files according to filename, e.g., test_202510131552.mat
[~, idxSort] = sort({files.name});
files = files(idxSort);

% If only the first 15 target-task RTHS tests are used, keep nUse = 15.
% If all test_*.mat files should be included, set nUse = numel(files).
nUse = 15;
nUse = min(nUse, numel(files));
files = files(1:nUse);

nTest = numel(files);

%% ------------------------------------------------------------
%  2. Initialize storage
% -------------------------------------------------------------
FileName = strings(nTest,1);

PeakErr_A1_mm = nan(nTest,1);
PeakErr_A2_mm = nan(nTest,1);

RMSErr_A1_mm = nan(nTest,1);
RMSErr_A2_mm = nan(nTest,1);

NRMSE_A1_percent = nan(nTest,1);
NRMSE_A2_percent = nan(nTest,1);

CmdRange_A1_mm = nan(nTest,1);
CmdRange_A2_mm = nan(nTest,1);

% For global summary
allErr_A1 = [];
allErr_A2 = [];
allCmd_A1 = [];
allCmd_A2 = [];

%% ------------------------------------------------------------
%  3. Compute tracking errors for each test
% -------------------------------------------------------------
for k = 1:nTest

    matname = fullfile(dataDir, files(k).name);
    S = load(matname);

    if ~isfield(S, 'bddata')
        warning('File %s does not contain bddata. Skipped.', files(k).name);
        continue;
    end

    bddata = S.bddata;

    xc1 = bddata(:,1);   % command displacement, actuator 1
    xc2 = bddata(:,2);   % command displacement, actuator 2
    xm1 = bddata(:,3);   % measured displacement, actuator 1
    xm2 = bddata(:,4);   % measured displacement, actuator 2

    FileName(k) = string(files(k).name);

    % ---------- Actuator 1 ----------
    idx1 = isfinite(xc1) & isfinite(xm1);
    e1 = xm1(idx1) - xc1(idx1);
    c1 = xc1(idx1);

    PeakErr_A1_mm(k) = max(abs(e1));
    RMSErr_A1_mm(k) = sqrt(mean(e1.^2));

    CmdRange_A1_mm(k) = max(c1) - min(c1);
    if CmdRange_A1_mm(k) > eps
        NRMSE_A1_percent(k) = RMSErr_A1_mm(k) / CmdRange_A1_mm(k) * 100;
    else
        NRMSE_A1_percent(k) = NaN;
    end

    allErr_A1 = [allErr_A1; e1(:)];
    allCmd_A1 = [allCmd_A1; c1(:)];

    % ---------- Actuator 2 ----------
    idx2 = isfinite(xc2) & isfinite(xm2);
    e2 = xm2(idx2) - xc2(idx2);
    c2 = xc2(idx2);

    PeakErr_A2_mm(k) = max(abs(e2));
    RMSErr_A2_mm(k) = sqrt(mean(e2.^2));

    CmdRange_A2_mm(k) = max(c2) - min(c2);
    if CmdRange_A2_mm(k) > eps
        NRMSE_A2_percent(k) = RMSErr_A2_mm(k) / CmdRange_A2_mm(k) * 100;
    else
        NRMSE_A2_percent(k) = NaN;
    end

    allErr_A2 = [allErr_A2; e2(:)];
    allCmd_A2 = [allCmd_A2; c2(:)];

end

%% ------------------------------------------------------------
%  4. Read delay data
% -------------------------------------------------------------
Delay_A1_ms = nan(nTest,1);
Delay_A2_ms = nan(nTest,1);

delayFile = fullfile(dataDir, 'delay_date.mat');

if exist(delayFile, 'file')
    D = load(delayFile);

    if isfield(D, 'delaydate')
        delaydate = D.delaydate;

        % Your original code uses:
        % delay1 = delaydate(:,1);
        % delay2 = delaydate(:,3);
        nDelay = min(nTest, size(delaydate,1));

        Delay_A1_ms(1:nDelay) = delaydate(1:nDelay,1);
        Delay_A2_ms(1:nDelay) = delaydate(1:nDelay,3);
    else
        warning('delay_date.mat does not contain variable delaydate.');
    end
else
    warning('delay_date.mat is not found.');
end

%% ------------------------------------------------------------
%  5. Per-test table
% -------------------------------------------------------------
PerTestTable = table( ...
    FileName, ...
    PeakErr_A1_mm, RMSErr_A1_mm, NRMSE_A1_percent, Delay_A1_ms, ...
    PeakErr_A2_mm, RMSErr_A2_mm, NRMSE_A2_percent, Delay_A2_ms, ...
    'VariableNames', { ...
    'FileName', ...
    'PeakErr_FirstStory_mm', ...
    'RMSErr_FirstStory_mm', ...
    'NRMSE_FirstStory_percent', ...
    'Delay_FirstStory_ms', ...
    'PeakErr_SecondStory_mm', ...
    'RMSErr_SecondStory_mm', ...
    'NRMSE_SecondStory_percent', ...
    'Delay_SecondStory_ms'});

disp(PerTestTable);

writetable(PerTestTable, fullfile(outDir, 'tracking_metrics_per_test.xlsx'));
writetable(PerTestTable, fullfile(outDir, 'tracking_metrics_per_test.csv'));

%% ------------------------------------------------------------
%  6. Summary table for manuscript
% -------------------------------------------------------------
Actuator = ["First-story actuator"; "Second-story actuator"];

% Peak error: maximum absolute tracking error over all selected tests
PeakError_mm = [
    max(abs(allErr_A1));
    max(abs(allErr_A2))
];

% RMS error: RMS over all selected tests
RMSError_mm = [
    sqrt(mean(allErr_A1.^2));
    sqrt(mean(allErr_A2.^2))
];

% Normalized RMS error: normalized by global command displacement range
range_A1 = max(allCmd_A1) - min(allCmd_A1);
range_A2 = max(allCmd_A2) - min(allCmd_A2);

NormalizedRMSE_percent = [
    RMSError_mm(1) / range_A1 * 100;
    RMSError_mm(2) / range_A2 * 100
];

MeanDelay_ms = [
    mean(Delay_A1_ms, 'omitnan');
    mean(Delay_A2_ms, 'omitnan')
];

DelayStd_ms = [
    std(Delay_A1_ms, 'omitnan');
    std(Delay_A2_ms, 'omitnan')
];

MaxAbsDelay_ms = [
    max(abs(Delay_A1_ms), [], 'omitnan');
    max(abs(Delay_A2_ms), [], 'omitnan')
];

SummaryTable = table( ...
    Actuator, ...
    PeakError_mm, ...
    RMSError_mm, ...
    NormalizedRMSE_percent, ...
    MeanDelay_ms, ...
    DelayStd_ms, ...
    MaxAbsDelay_ms);

disp(SummaryTable);

writetable(SummaryTable, fullfile(outDir, 'tracking_metrics_summary.xlsx'));
writetable(SummaryTable, fullfile(outDir, 'tracking_metrics_summary.csv'));

%% ------------------------------------------------------------
%  7. Updated delay figure with physical labels
% -------------------------------------------------------------
figure;
hold on;

canvasX = 5;
canvasY = 5;
canvasL = 12;
canvasH = 6;
set(gcf, 'unit', 'centimeters', 'position', [canvasX canvasY canvasL canvasH]);

bar([Delay_A1_ms, Delay_A2_ms]);

ylim([-3.5 3.5]);
xlabel('RTHS test number', 'FontSize', 8, 'FontName', 'Times New Roman');
ylabel('Equivalent delay (ms)', 'FontSize', 8, 'FontName', 'Times New Roman');

legend({'First-story actuator', 'Second-story actuator'}, ...
    'Location', 'best', ...
    'Box', 'off', ...
    'FontSize', 8, ...
    'FontName', 'Times New Roman');

set(gca, 'LooseInset', [0, 0, 0.01, 0]);
set(gcf, 'color', 'w');
set(gca, ...
    'box', 'on', ...
    'fontname', 'Times New Roman', ...
    'fontsize', 8, ...
    'linewidth', 0.5, ...
    'xcolor', 'k', ...
    'ycolor', 'k');

grid on;

exportgraphics(gcf, fullfile(figDir, 'delay_all_updated.tiff'), ...
    'ContentType', 'image', 'Resolution', 600);
exportgraphics(gcf, fullfile(figDir, 'delay_all_updated.pdf'), ...
    'ContentType', 'vector', 'Resolution', 600);