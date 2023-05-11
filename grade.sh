CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
    echo "file found"

else 
    echo "File not found"
    exit
fi

cp student-submission/ListExamples.java ./grading-area


javac -cp $CPATH grading-area/*.java
##javac $CPATH ListExamples.java TestListExamples.java 2> compile-output.txt
if [[ $? -eq 0 ]]
then 
    echo "compile successful"
else 
    echo "compile failed"
    cat compile-output.txt
    exit $?
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

grepCount= grep -c "Ok" junit-output.txt

if [[ $grepCount -eq 0 ]]
then 
    echo "Test failed"
else
    echo "Test passed"
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
