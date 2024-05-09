#! /bin/bash
#SBATCH --mincpus=64
#SBATCH --mem=512000
#SBATCH --partition=a100-8-gm640-c96-m1152
#SBATCH --gpus=1
directory=$1
if [ -z "$directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi
echo "changing directory to $directory"
cd $directory
bash sh.py.sh
bash sh.java.sh "a100-8-gm640-c96-m1152"
