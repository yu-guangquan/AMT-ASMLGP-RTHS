# AMT-ASMLGP-RTHS

This repository provides the reviewer-ready implementation and supporting data structure for the manuscript:

**Meta-Learning–Enhanced Real-Time Hybrid Simulation for Data-Efficient Probabilistic Assessment**

The repository is intended to support reproducibility of the key surrogate-modeling, adaptive-sampling, and probabilistic-assessment results reported in the paper. The proposed framework is referred to as **AMT-ASMLGP-RTHS**, namely an **Adaptive-Meta-task Adaptive Sampling Meta-Learning Gaussian Process framework integrated with Real-Time Hybrid Simulation**.

## 1. Overview

Real-time hybrid simulation (RTHS) is an effective experimental approach for evaluating nonlinear structural systems under earthquake excitation. However, uncertainty quantification based on repeated RTHS experiments is expensive because each high-fidelity target-task evaluation requires physical or real-time experimental execution.

To reduce the number of target-task RTHS evaluations, this repository implements a data-efficient surrogate-modeling framework that combines:

* Gaussian process regression (**GP**);
* co-Gaussian process / co-Kriging surrogate modeling (**COGP**);
* meta-learning Gaussian process regression (**MLGP**);
* CV–Voronoi adaptive sampling (**CVV**);
* meta-task selection using structurally similar virtual hybrid simulations;
* probabilistic response prediction and model-performance evaluation.

The main objective is to transfer useful task-level prior information from related virtual hybrid simulation tasks to a data-scarce target RTHS task, thereby reducing the required number of high-fidelity target-task evaluations.

## 2. Main Script

The main adaptive-sampling script is:

```text
N_Amlgp_HS_2story_2Ue_CVV_comck_v3_25_exp.m
```

This script controls the main AMT-ASMLGP-RTHS workflow, including:

1. defining the uncertain input variables;
2. generating candidate samples and initial samples;
3. constructing meta-task data;
4. performing CV–Voronoi-based adaptive sampling;
5. comparing GP, COGP, and MLGP surrogate models;
6. evaluating prediction errors on the validation dataset;
7. saving the adaptive-sampling and prediction results.

In the current implementation, the uncertain input variables are:

* `Vp`: pulse velocity parameter, modeled as a lognormal random variable;
* `Tp`: pulse period parameter, modeled as a Gumbel random variable.

Two different meta-task settings are considered:

```matlab
X_m1 = [0.06, 1.0];
X_v1 = [0.015, 0.1];

X_m2 = [0.1, 1.25];
X_v2 = [0.03, 0.2];
```

Here, `m1` and `m2` denote two different meta-task distributions. These meta-tasks represent virtual hybrid simulation tasks associated with structurally similar or statistically related systems. They are used to provide transferable prior information for the target RTHS task.

## 3. Model Types

This repository includes three main surrogate-modeling strategies.

### 3.1 GP

The **GP** model is used as the single-task Gaussian process baseline. It is trained only with the available target-task samples and does not use meta-task information.

### 3.2 COGP

The **COGP** model denotes the co-Gaussian process or co-Kriging-based baseline. It uses information from related tasks or fidelity levels through a multi-task or multi-fidelity modeling structure.

### 3.3 MLGP

The **MLGP** model is the meta-learning Gaussian process model used in the proposed AMT-ASMLGP-RTHS framework. It learns transferable prior information from meta-tasks and updates the prediction model using sequentially acquired target-task RTHS samples.

In the main script, MLGP prediction is performed through the Python interface:

```matlab
system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
```

Users should modify this path according to their local Python environment.

For example:

```matlab
system('python predict_ver_n_1.py');
```

or

```matlab
system('C:\path\to\python.exe predict_ver_n_1.py');
```

## 4. CV–Voronoi Adaptive Sampling

The CV–Voronoi adaptive sampling strategy is the active-learning component of the framework. It is used to select new target-task samples sequentially from the candidate sample pool.

In the main script, the CVV-related model-error indicators are evaluated by:

```matlab
[~, error]  = CVV_GP(Xs, Ys, X_cand, X_m1, X_v1);
[~, errorm] = CVV_GPML(Xs, Ys, X_cand, X_m1, X_v1);
```

where:

* `Xs` and `Ys` are the current target-task training samples and responses;
* `X_cand` is the candidate sample pool;
* `X_m1` and `X_v1` define the statistical parameters of the target-task input distribution;
* `error` is the CVV-based error indicator for the GP model;
* `errorm` is the CVV-based error indicator for the MLGP model.

The selected new target-task sample is then added to the training set:

```matlab
Xs_new = Xs_all(ini_Xn + nn, :);
Ys_new = Ys_all(ini_Xn + nn, :);

Xs(ini_Xn + nn, :) = Xs_new;
Ys(ini_Xn + nn, :) = Ys_new;
```

The selected sample is removed from the candidate pool to avoid repeated selection:

```matlab
index5 = find(X_cand == Xs_new, 1);
X_cand(index5, :) = [];
```

## 5. Repository Structure

A typical repository structure is expected to be:

```text
AMT-ASMLGP-RTHS/
│
├── README.md
├── N_Amlgp_HS_2story_2Ue_CVV_comck_v3_25_exp.m
│
├── RTHS_sim/
│   ├── pulse_groundmotion.m
│   ├── Model_Input_equa_m1.m
│   ├── RT_F2D_Bld.m
│   ├── Virtual_RTHS_CR_sca.slx
│   └── other RTHS simulation files
│
├── meta_tasks/
│   ├── rths_m1/
│   └── rths_m2/
│
├── main_tasks/
│   ├── rths_m1/
│   └── rths_m2/
│
├── result1/
│   ├── AK_v3_exp/
│   ├── AMLGP_v3_25/
│   └── other result folders
│
├── data/
│   ├── ver_2story2_2ue_1e3_25_exp.mat
│   └── other validation or processed data files
│
├── predict_ver_n_1.py
├── CVV_GP.m
├── CVV_GPML.m
└── auxiliary functions
```

The exact directory names may be adjusted according to the released version. Users should make sure that all paths in the MATLAB scripts are consistent with the local repository structure.

## 6. Requirements

The implementation requires both MATLAB and Python.

### MATLAB requirements

The MATLAB part requires:

* MATLAB;
* Simulink;
* UQLab;
* the RTHS simulation files included in `RTHS_sim/`;
* the MATLAB functions for GP, COGP, MLGP, and CVV-based adaptive sampling.

Before running the main script, initialize UQLab in MATLAB:

```matlab
uqlab;
```

The script automatically adds the RTHS simulation folder:

```matlab
addpath('RTHS_sim')
```

If additional folders are used for GP, COGP, MLGP, or DACE-related routines, users should add them manually, for example:

```matlab
addpath('dace')
addpath('functions')
addpath('models')
```

### Python requirements

The Python script `predict_ver_n_1.py` is used for MLGP-based validation prediction.

Users should create a Python environment and install the required packages according to the actual implementation of `predict_ver_n_1.py`. A typical environment may include:

```text
numpy
scipy
matplotlib
scikit-learn
torch
gpytorch
h5py
```

If the released version uses a different MLGP implementation, please install the corresponding dependencies listed in the Python script or in `requirements.txt`.

## 7. How to Run

### Step 1: Clone the repository

```bash
git clone https://github.com/yu-guangquan/AMT-ASMLGP-RTHS.git
cd AMT-ASMLGP-RTHS
```

### Step 2: Check MATLAB paths

Open MATLAB and set the repository as the current working directory.

Make sure the following folders and files are available:

```text
RTHS_sim/
meta_tasks/
main_tasks/
result1/
predict_ver_n_1.py
CVV_GP.m
CVV_GPML.m
ver_2story2_2ue_1e3_25_exp.mat
```

If necessary, update the path definitions in the main script, for example:

```matlab
meta_data_dir = '.\meta_tasks\rths_m1\';
main_data_dir = '.\main_tasks\rths_m1\';
```

### Step 3: Modify the Python executable path

In the main MATLAB script, replace the hard-coded Python path:

```matlab
system('D:\ProgramData\anaconda3\envs\py391\python.exe predict_ver_n_1.py');
```

with the Python path on your own computer. For example:

```matlab
system('python predict_ver_n_1.py');
```

### Step 4: Run the main script

In MATLAB, run:

```matlab
N_Amlgp_HS_2story_2Ue_CVV_comck_v3_25_exp
```

The script will:

1. initialize the input distributions;
2. generate candidate and initial samples;
3. generate or load meta-task data;
4. sequentially add target-task samples;
5. evaluate GP and MLGP CVV indicators;
6. call the Python MLGP prediction script;
7. compute normalized RMSE and coefficient of determination;
8. save the final results.

### Step 5: Check output files

The final results are saved in:

```text
result1/AMLGP_v3_25/
```

The main output file follows the naming format:
N_Amlgp_HS_2story_2Ue_CVV_comck_v3_25_exp.m

The saved MATLAB workspace contains the adaptive-sampling history, prediction errors, selected training samples, validation results, and model-performance indicators.

## 8. Expected Outputs

The main script produces the following quantities:

* selected target-task samples `Xs`;
* corresponding target-task responses `Ys`;
* normalized RMSE history for GP and MLGP;
* MLGP validation predictions;
* MLGP model weights;
* coefficient of determination `R^2`;
* saved adaptive-sampling results.

The normalized RMSE is computed as:

```matlab
RMSE = sqrt(sum((Y_true - Y_pred).^2) / N) / (max(Y_true) - min(Y_true));
```

The coefficient of determination is computed as:

```matlab
R2 = (sum((Y_true - mean(Y_true)).^2) - sum((Y_true - Y_pred).^2)) ...
     / sum((Y_true - mean(Y_true)).^2) * 100;
```

These metrics are used to evaluate the predictive accuracy of the surrogate models during the adaptive-sampling process.

## 9. Meta-Task Settings

The current implementation considers different meta-task choices. The two representative meta-task distributions are denoted as `m1` and `m2`.

For example:

```matlab
% Meta-task / target-task distribution setting 1
X_m1 = [0.06, 1.0];
X_v1 = [0.015, 0.1];

% Meta-task distribution setting 2
X_m2 = [0.1, 1.25];
X_v2 = [0.03, 0.2];
```

The corresponding input variables are:

```text
Vp ~ Lognormal(mean, standard deviation)
Tp ~ Gumbel(mean, standard deviation)
```

The script generates 32 initial meta-task samples using Latin hypercube sampling:

```matlab
num_meta_ini = 32;
X_meta_ini = uq_getSample(myInput1, num_meta_ini, 'LHS');
```

The response of each meta-task sample is obtained from the virtual RTHS simulation:

```matlab
GM = pulse_groundmotion(X_meta_ini(iuu,1), X_meta_ini(iuu,2));
Earthquake_record_X(:,2) = GM * 1000;

run Model_Input_equa_m1.m;
run RT_F2D_Bld;
sim('Virtual_RTHS_CR_sca')

Y_meta_ini(iuu,1) = max([max(abs(xc1)); max(abs(xc2))]);
```

The response quantity is the maximum absolute displacement response among the two structural degrees of freedom.

## 10. Reproducibility Notes

This repository is designed to support the minimum reproducibility requirement for the data-driven components of the study. The shared materials are intended to reproduce the key results related to:

* adaptive sampling;
* surrogate-model training;
* MLGP-based prediction;
* GP/COGP/MLGP comparison;
* validation-error evaluation;
* probabilistic response prediction based on the trained surrogate model.

The full laboratory-specific RTHS control system and hardware-dependent implementation details are not required to reproduce the surrogate-modeling results. Instead, processed target-task and validation datasets are provided to enable reviewer-ready reproduction of the main numerical results.

## 11. Data Availability

This repository is provided to meet the **Tier 1: Minimum Mandatory Standard** of the EESD Data and Code Availability Standards for papers utilizing data-driven approaches. The released materials include the processed test/validation data and a reviewer-ready runnable implementation sufficient to reproduce the key results reported in the manuscript.

The shared reproducibility package includes, where applicable:

* processed target-task input–output samples used for surrogate-model construction;
* validation samples and validation responses used for model-performance evaluation;
* processed meta-task samples and responses used by the MLGP framework;
* implementation scripts for GP, COGP, and MLGP-based comparison;
* CV–Voronoi adaptive-sampling scripts;
* scripts for reproducing the principal prediction-error, probabilistic-response, failure-probability, and sensitivity-analysis results;
* a README/User Guide describing the required environment and step-by-step execution procedure.

The complete laboratory-specific RTHS control programs, hardware-dependent actuator-control configurations, and full raw experimental records are not included in the public release because they contain laboratory-specific implementation details and internal experimental resources. These unreleased materials are not required to reproduce the principal data-driven results reported in the manuscript. Instead, the shared package provides processed data, implementation scripts, and documentation sufficient to verify the main surrogate-modeling, adaptive-sampling, probabilistic-prediction, and sensitivity-analysis results.

## 12. Citation

If you use this repository, please cite the associated manuscript:

```text
Yu, G., Peng, C., Chen, C., Xu, W., and Li, N.
Meta-Learning–Enhanced Real-Time Hybrid Simulation for Data-Efficient Probabilistic Assessment.
Earthquake Engineering & Structural Dynamics, under review.
```

## 13. Contact

For questions regarding the implementation or data, please contact the corresponding author of the manuscript.

## 14. License

This repository is provided for peer-review and academic reproducibility purposes. Redistribution or commercial use is not permitted without permission from the authors.

