# fpass: a vector of 2 frequencies of the band
# fs: sampling frequency of the timeseries

using Distributed;
@everywhere import DSP;
@everywhere using SharedArrays
# apply filtering on each column of an array in parallel
function BPFarray(array::SharedArray{F,2}, fpass::Vector{F}, fs::F) where {F<:AbstractFloat}
    nrow, ncol = size(array)
    responsetype = DSP.Filters.Bandpass(fpass[1],fpass[2];fs=fs); 
    designmethod = DSP.Butterworth(7);
    filter_coefficients = DSP.digitalfilter(responsetype, designmethod);
    @sync @distributed for idx=1:ncol
        y = DSP.filtfilt(filter_coefficients, vec(array[:,idx]));
        array[:,idx] = y
    end

    return nothing
end