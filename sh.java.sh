echo "testing java"
javac Test.java
echo "Main-Class: Test" >manifest.txt
jar cvfm Test.jar manifest.txt Test.class
java -jar Test.jar
echo "done"
machine=$1
time_stamp=$(date +%s)
id=$machine-$time_stamp
for i in {1..10}; do
    java -jar Test.jar $id $i &
done
wait
echo "done"
