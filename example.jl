#Usage julia example.jl <file_name to process>

include("preprocessOne.jl");

fs_example = Dict("REST"=>1/0.7275, "EMOTION"=>1/0.7727, "GAMBLING"=>1/0.7589, "LANGUAGE"=>1/0.75, "MOTOR"=>1/0.7535, "RELATIONAL"=>1/0.7586, "SOCIAL"=>1/0.7555, "WM"=>1/0.7432)

fpass = [0.009, 0.08]

dataset = "REST"                                  # name of the dataset to be preprocessed  --> REST, GAMBLE, etc..
numsubj = 1

file_name = ARGS[1]


src_path = pwd()
dst_path = pwd()


preprocessDataset(file_name, src_path, dst_path, dataset; normalized=true, BPFed=true, togsr=true,fpass=fpass,fs_dataset=fs_example[dataset])