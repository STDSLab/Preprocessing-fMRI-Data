# Preprocessing fMRI timeseries

This package provides three preprocessing steps in preparing fMRI timeseries for analysis:
- Normalization using **Z-score**
- Band-pass filtering
- Global signal processing

## Requirements
Julia 1.1 or later
- Packages: PyCall (v"1.91.4" tested), DSP (v"0.6.7")

Python 3.x
- Packages: nibabel (v"3.1.1" tested)

## Usage

```julia
julia> include("preprocessOne.jl")
julia> preprocessDataset( filename, 
                          src_path, 
                          dst_path, 
                          dataset, 
                          fs_dataset, 
                          normalized=true, 
                          BPFed=true, 
                          togsr=true, 
                          fpass=[0.009, 0.08])

```

Input:
- **filename** : the file name (*.nii*) of the fMRI scan to be processed
- **src_path** : the path to the source folder containing the fMRI file
- **dst_path** : the path to the destination folder where the output will be saved
- **dataset** : the name of the dataset
- **fs_dataset** : the dictionary having the (key, value) as (dataset::String, signal_frequency::AbstractFloat)
- **normalized** {true, false}: whether to conduct the normalization step. Optional, default=true
- **BPFed** {true, false} : whether to conduct the Band-pass filtering step. Optional, default=true
- **togsr** {true, false} : whether to conduct the Global Signal Processing step. Optional, default=true
- **fpass** : the array of two cut-off frequencies in Hz of the Band-pass filter . Optional, default=[0.009, 0.08]  

Output:
- Preprocessed file (*.nii*) saved in the folder specified by *src_path* that has the file name specified by *filename*

