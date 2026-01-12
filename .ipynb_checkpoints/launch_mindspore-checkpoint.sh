#!/bin/bash
# MindSpore GPU启动脚本

# 激活conda环境
conda activate mindspore

# 设置环境变量
export CUDA_HOME=$CONDA_PREFIX
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH

# 创建必要的符号链接
if [ ! -f $CONDA_PREFIX/lib/libcuda.so ]; then
    # 尝试找到系统libcuda
    if [ -f /usr/lib/x86_64-linux-gnu/libcuda.so ]; then
        ln -sf /usr/lib/x86_64-linux-gnu/libcuda.so $CONDA_PREFIX/lib/libcuda.so
    elif [ -f /usr/lib/x86_64-linux-gnu/libcuda.so.1 ]; then
        ln -sf /usr/lib/x86_64-linux-gnu/libcuda.so.1 $CONDA_PREFIX/lib/libcuda.so
    fi
fi

# 启动Python
echo "环境已设置:"
echo "  CUDA_HOME: $CUDA_HOME"
echo "  Python: $(which python)"
echo ""
python "$@"
