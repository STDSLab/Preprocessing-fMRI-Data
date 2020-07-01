using PyCall
nib = pyimport("nibabel")

include("BPFparallel.jl");
include("normalizationParallel.jl");
include("globalSignalRegressionParallel.jl");


fs = Dict("REST"=>1/0.7275, "EMOTION"=>1/0.7727, "GAMBLING"=>1/0.7589, "LANGUAGE"=>1/0.75, "MOTOR"=>1/0.7535, "RELATIONAL"=>1/0.7586, "SOCIAL"=>1/0.7555, "WM"=>1/0.7432)


function preprocessDataset(filename::String,src_path::String, dst_path::String, dataset::String; normalized::Bool=true, BPFed::Bool=true, togsr::Bool=true, fpass::Vector{F}=[0.009, 0.08], fs_dataset::F=F(0)) where {F<:AbstractFloat}
    time0 = time()

    file_temp = nib.load(src_path*"/"*filename)                                        #cifti file load
    scan_temp = file_temp[:get_fdata]()
    timepoint, numvoxel = size(scan_temp)
    scan_data = SharedArray{F}(timepoint, numvoxel)
	          
    
    hdr = file_temp.header
    scan_data[:,:] = convert(Array{F,2}, scan_temp)                  #  conversion to 2d array/matrix, conversion to Float32 ***
	
    normalized && (normalizeArray(scan_data))                                      # Normalization
    
    #println("\tNormalization completed. Subj time ellapsed:  ", time() - time1)

    BPFed && (BPFarray(scan_data, fpass, fs_dataset))                              # BPF 
	
    #println("\tBPF completed. Subj time ellapsed:  ", time() - time2)
	
    togsr && (globalSignalRegression(scan_data))                                   # Global signal regression 
	
    processed_filename = dst_path*"/Processed_"*filename
    img = nib.Cifti2Image(Array{Float32}(scan_data),hdr)                                                                      
    nib.save(img, processed_filename)                                              # saving the processed matrix to cifti image back
    println("PREPROCESSING TIME: ", time()-time0)
    return nothing
end