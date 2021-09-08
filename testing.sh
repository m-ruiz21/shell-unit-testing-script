#!/bin/sh

num_testing_files=7;    # number of testing files total, later number of testing files left
num_tests_passed=0;     # number of tests passed
num_tests_failed=0;     # number of tests failed

# compiles code
g++ -std=c++17 -Wall -Wextra -pedantic -Weffc++ grade_calculator.cpp


while [ $num_testing_files != 0 ] ; # goes through every testing file 
do
    current_output=$(./a.out < test_complete_$num_testing_files.txt);   # sets current output from test input
    correct_output=$(cat ./test_correct_$num_testing_files.txt);    # finds file with correct output, stores it

    if [ "$correct_output" == "$current_output" ]   # compares both outputs
    then    
        num_tests_passed=$((num_tests_passed+1));   # up the passed test tally!
    else
        num_tests_failed=$((num_tests_failed+1));   # darn :/ adds one more to failed count
        echo "Test $num_testing_files failed"   # error message, diff compares too files
        echo "Differences found: (Top is your result, bottom is expected result)"
        diff <($current_output) <($correct_output)
        # diff usually compares two files. By wrapping each commant with <(), it allow us to compare outputs
        echo "---------------------------------------------------------------" # buffer for readability 
    fi  # dunno what this is for, but it doesn't work without it, and stack overflow recommends it
    
    num_testing_files=$((num_testing_files-1)); # lowers the number of testing files to go for next loop
done

echo "Passed: $num_tests_passed , Failed: $num_tests_failed"    # prints out overview of results
