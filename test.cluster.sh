# test cases:
date && find ../ | wc && date
date && du -sh ../ && date
date && sh sh.py.sh && date
date && sh sh.java.sh && date

echo "installing packages"
bash sh.pip.sh
echo "running sbatch.test.sbatch"
working_directory=$(pwd)
sbatch sbatch.c64.sbatch $working_directory
sbatch sbatch.c96.sbatch $working_directory
sbatch sbatch.a100.sbatch $working_directory
