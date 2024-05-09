net_id=$1
if [ -z "$net_id" ]; then
    echo "Usage: $0 <net_id>"
    exit 1
fi
mkdir -p logs
date >logs/log.txt
current="cirrostratus.it.emory.edu"
stage="cirrostratus-stage.it.emory.edu"
home_dir="/users/$net_id"
scratch_dir="/scratch/$net_id"

date >>logs/log.txt
ssh-copy-id $net_id@$current && echo "Success: ssh-copy-id $net_id@$current" >>logs/log.txt || echo "Error: ssh-copy-id $net_id@$current" >>logs/log.txt
date >>logs/log.txt
ssh-copy-id $net_id@$stage && echo "Success: ssh-copy-id $net_id@$stage" >>logs/log.txt || echo "Error: ssh-copy-id $net_id@$stage" >>logs/log.txt
date >>logs/log.txt
echo "if it asks for password copy-id failed" | tee -a logs/log.txt
date >>logs/log.txt

echo "cleaning up the destination directory on cluster" | tee -a logs/log.txt
date >>logs/log.txt
ssh $net_id@$current "rm -rf $home_dir/test" && echo "Success: rm $current$home_dir/test" >>logs/log.txt || echo "Error: rm $current$home_dir/test" >>logs/log.txt
date >>logs/log.txt
ssh $net_id@$current "rm -rf $scratch_dir/test" && echo "Success: rm $current$scratch_dir/test" >>logs/log.txt || echo "Error: rm $current$scratch_dir/test" >>logs/log.txt
date >>logs/log.txt
ssh $net_id@$stage "rm -rf $scratch_dir/test" && echo "Success: rm $stage$scratch_dir/test" >>logs/log.txt || echo "Error: rm $stage$scratch_dir/test" >>logs/log.txt
date >>logs/log.txt
ssh $net_id@$stage "rm -rf $home_dir/test" && echo "Success: rm $stage$home_dir/test" >>logs/log.txt || echo "Error: rm $stage$home_dir/test" >>logs/log.txt
date >>logs/log.txt

echo "cleaning up the destination directory on local" | tee -a logs/log.txt
date >>logs/log.txt
rm -rf ./test && echo "Success: rm -rf ./test" >>logs/log.txt || echo "Error: rm -rf ./test" >>logs/log.txt
date >>logs/log.txt

echo "create the destination directory on cluster" | tee -a logs/log.txt
date >>logs/log.txt
ssh $net_id@$current "mkdir -p $home_dir/test" && echo "Success: mkdir $current$home_dir/test" >>logs/log.txt || echo "Error: mkdir $current$home_dir/test" >>logs/log.txt
date >>logs/log.txt
ssh $net_id@$current "mkdir -p $scratch_dir/test" && echo "Success: mkdir $current$scratch_dir/test" >>logs/log.txt || echo "Error: mkdir $current$scratch_dir/test" >>logs/log.txt
date >>logs/log.txt
ssh $net_id@$stage "mkdir -p $scratch_dir/test" && echo "Success: mkdir $stage$scratch_dir/test" >>logs/log.txt || echo "Error: mkdir $stage$scratch_dir/test" >>logs/log.txt
date >>logs/log.txt
ssh $net_id@$stage "mkdir -p $home_dir/test" && echo "Success: mkdir $stage$home_dir/test" >>logs/log.txt || echo "Error: mkdir $stage$home_dir/test" >>logs/log.txt
date >>logs/log.txt

date >>logs/log.txt
mkdir -p ./test/current/$scratch_dir && echo "Success: rm -rf ./test/current/$scratch_dir" >>logs/log.txt || echo "Error: rm -rf ./test/current/$scratch_dir" >>logs/log.txt
date >>logs/log.txt
rm -rf ./test/stage/$scratch_dir && echo "Success: rm -rf ./test/stage/$scratch_dir" >>logs/log.txt || echo "Error: rm -rf ./test/stage/$scratch_dir" >>logs/log.txt
date >>logs/log.txt
rm -rf ./test/current/$home_dir && echo "Success: rm -rf ./test/current/$home_dir" >>logs/log.txt || echo "Error: rm -rf ./test/current/$home_dir" >>logs/log.txt
date >>logs/log.txt
rm -rf ./test/stage/$home_dir && echo "Success: rm -rf ./test/stage/$home_dir" >>logs/log.txt || echo "Error: rm -rf ./test/stage/$home_dir" >>logs/log.txt

echo "create the destination directory on local" | tee -a logs/log.txt
date >>logs/log.txt
mkdir -p ./test/current/$scratch_dir && echo "Success: mkdir -p ./test/current/$scratch_dir" >>logs/log.txt || echo "Error: mkdir -p ./test/current/$scratch_dir" >>logs/log.txt
date >>logs/log.txt
mkdir -p ./test/stage/$scratch_dir && echo "Success: mkdir -p ./test/stage/$scratch_dir" >>logs/log.txt || echo "Error: mkdir -p ./test/stage/$scratch_dir" >>logs/log.txt
date >>logs/log.txt
mkdir -p ./test/current/$home_dir && echo "Success: mkdir -p ./test/current/$home_dir" >>logs/log.txt || echo "Error: mkdir -p ./test/current/$home_dir" >>logs/log.txt
date >>logs/log.txt
mkdir -p ./test/stage/$home_dir && echo "Success: mkdir -p ./test/stage/$home_dir" >>logs/log.txt || echo "Error: mkdir -p ./test/stage/$home_dir" >>logs/log.txt

date >>logs/log.txt
echo "local to scratch" | tee -a logs/log.txt
date >>logs/log.txt
scp -r . $net_id@$current:$scratch_dir/test && echo "Success: scp -r . $net_id@$current:$scratch_dir/test" >>logs/log.txt || echo "Error: scp -r . $net_id@$current:$scratch_dir/test" >>logs/log.txt
date >>logs/log.txt
scp -r . $net_id@$stage:$scratch_dir/test && echo "Success: scp -r . $net_id@$stage:$scratch_dir/test" >>logs/log.txt || echo "Error: scp -r . $net_id@$stage:$scratch_dir/test" >>logs/log.txt
date >>logs/log.txt

date >>logs/log.txt
echo "local to home" | tee -a logs/log.txt
date >>logs/log.txt
scp -r . $net_id@$current:$home_dir/test && echo "Success: scp -r . $net_id@$current:$home_dir/test" >>logs/log.txt || echo "Error: scp -r . $net_id@$current:$home_dir/test" >>logs/log.txt
date >>logs/log.txt
scp -r . $net_id@$stage:$home_dir/test && echo "Success: scp -r . $net_id@$stage:$home_dir/test" >>logs/log.txt || echo "Error: scp -r . $net_id@$stage:$home_dir/test" >>logs/log.txt
date >>logs/log.txt

echo "backup the local directory" | tee -a logs/log.txt
date >>logs/log.txt
cp -r . ./test/local && echo "Success: cp -r . ./test/local" >>logs/log.txt || echo "Error: cp -r . ./test/local" >>logs/log.txt
date >>logs/log.txt

echo "running test.cluster.sh" | tee -a logs/log.txt
date >>logs/log.txt

date && ssh $net_id@$current "cd $home_dir/test && bash test.cluster.sh" && date | tee -a logs/log.txt
date && ssh $net_id@$current "cd $scratch_dir/test && bash test.cluster.sh" && date | tee -a logs/log.txt
date && ssh $net_id@$stage "cd $home_dir/test && bash test.cluster.sh" && date | tee -a logs/log.txt
date && ssh $net_id@$stage "cd $scratch_dir/test && bash test.cluster.sh" && date | tee -a logs/log.txt

date >>logs/log.txt

echo "scratch to local" | tee -a logs/log.txt
date >>logs/log.txt
scp -r $net_id@$current:$scratch_dir/test ./test/current/$scratch_dir && echo "Success: scp -r $net_id@$current:$scratch_dir/test ./test/current/$scratch_dir " >>logs/log.txt || echo "Error: scp -r $net_id@$current:$scratch_dir/test ./test/current/$scratch_dir " >>logs/log.txt
date >>logs/log.txt
scp -r $net_id@$stage:$scratch_dir/test ./test/stage/$scratch_dir && echo "Success: scp -r $net_id@$stage:$scratch_dir/test ./test/stage/$scratch_dir " >>logs/log.txt || echo "Error: scp -r $net_id@$stage:$scratch_dir/test ./test/stage/$scratch_dir " >>logs/log.txt
date >>logs/log.txt

date >>logs/log.txt
echo "home to local" | tee -a logs/log.txt
date >>logs/log.txt
scp -r $net_id@$current:$home_dir/test ./test/current/$home_dir && echo "Success: scp -r $net_id@$current:$home_dir/test ./test/current/$home_dir" >>logs/log.txt || echo "Error: scp -r $net_id@$current:$home_dir/test ./test/current/$home_dir" >>logs/log.txt
date >>logs/log.txt
scp -r $net_id@$stage:$home_dir/test ./test/stage/$home_dir && echo "Success: scp -r $net_id@$stage:$home_dir/test ./test/stage/$home_dir" >>logs/log.txt || echo "Error: scp -r $net_id@$stage:$home_dir/test ./test/stage/$home_dir" >>logs/log.txt

date >logs/log.diff.txt

echo "diff -r ./test/current/$scratch_dir/test ./test/stage/$scratch_dir/test" >>logs/log.diff.txt
diff -r ./test/current/$scratch_dir/test ./test/stage/$scratch_dir/test >>logs/log.diff.txt
echo "diff -r ./test/current/$home_dir/test ./test/stage/$home_dir/test" >>logs/log.diff.txt
diff -r ./test/current/$home_dir/test ./test/stage/$home_dir/test >>logs/log.diff.txt
echo "diff -r ./test/current/$scratch_dir/test ./test/current/$home_dir/test" >>logs/log.diff.txt
diff -r ./test/current/$scratch_dir/test ./test/current/$home_dir/test >>logs/log.diff.txt
echo "diff -r ./test/local ./test/current/$scratch_dir/test" >>logs/log.diff.txt
diff -r ./test/local ./test/current/$scratch_dir/test >>logs/log.diff.txt
echo "diff -r ./test/local ./test/current/$home_dir/test" >>logs/log.diff.txt
diff -r ./test/local ./test/current/$home_dir/test >>logs/log.diff.txt
echo "diff -r ./test/local ./test/stage/$scratch_dir/test" >>logs/log.diff.txt
diff -r ./test/local ./test/stage/$scratch_dir/test >>logs/log.diff.txt
echo "diff -r ./test/local ./test/stage/$home_dir/test" >>logs/log.diff.txt
diff -r ./test/local ./test/stage/$home_dir/test >>logs/log.diff.txt
