#!/bin/bash

GPU=2 # Change to your reserved GPU device number
DEVICE='GPU' # Do not change

DATE=$(date +%Y%m%d) # Change if you don't like it

O_DIR='/home/members/gsnpu/workspace/gs/Deformable-3D-Gaussians/profiling/nsys_jumpingjacks/render' # Change to your directory

O_FILE=${O_DIR}/${DATE}_GPU_breakdown_result # Change to your filename
RESULT_FILE=${O_DIR}/${DATE}_operation_stats.txt # File to save average and maximum operations per second
export CUDA_VISIBLE_DEVICES=$GPU
f_launch(){
    # *** CHANGE CAPITALIZED WORDS (that does not start with $) TO YOUR OWN ***
    # For Nsys (usually nsys is enough for gpu profiling)
    # nsys profile -t cuda,nvtx --sample=none --cpuctxsw=none --gpu-metrics-device $GPU --force-overwrite=true --stats=true --output=$O_FILE python3 /home/members/gsnpu/workspace/gs/Deformable-3D-Gaussians/render.py -m output/jumping_jacks --mode render --skip_train

    ncu --target-processes all --set full -o $O_FILE python3 /home/members/gsnpu/workspace/gs/Deformable-3D-Gaussians/render.py -m output/jumping_jacks --mode render --skip_train



    # # Extract average and maximum operations per second from the profiling result
    # nsys stats ${O_FILE}.sqlite --report gputrace --format csv -o ${O_DIR}/temp_stats

    # # Extract detailed GPU metrics (including memory stalls and DRAM bandwidth utilization)
    # nsys stats ${O_FILE}.sqlite --report gpumetrics --format csv -o ${STATS_FILE}

}

f_launch
