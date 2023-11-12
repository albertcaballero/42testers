RED="\033[38;5;161m"
GREEN="\033[38;5;154m"
YELLOW="\033[38;5;227m"
BLUE="\033[38;5;81m"
PURPLE="\033[38;5;93m"
PINK="\033[38;5;219m"
NC="\033[0m"

cat /dev/urandom | head -1 > randomfile.txt
cat /dev/urandom | head -10 > randomfilebig.txt
testnbr=1
qttError=0
printf "\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"
printf "$GREEN\n\t🌟=======ALCABALL GNL mini-TESTER========🌟\n$NC"
printf "$PINK\nIf there's any issue or something to improve, pls tell me!! :)\n\
	(I'm always at the campus and I'm 24/7 on Slack)\n"
printf "\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"

#============================================================================================================#

printf "$PINK\n==============TEST WITHOUT BUFFER_SIZE==============\n$NC"
gcc -Wall -Wextra -Werror gnltst_main.c get_next_line.c get_next_line_utils.c -o test.out 2> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out
	exit 42
fi

printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC"
file="secret.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC"
file="randomfile.txt" 
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC"
file="randomfilebig.txt"
./test.out $file > output 2>> test_error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

#============================================================================================================#

testnbr=0
printf "$PINK\n==============TEST WITH BAD BUFFER_SIZE==============\n$NC"
printf "$PINK\nBUFFER_SIZE -1\n$NC"

gcc -Wall -Wextra -Werror -D BUFFER_SIZE=-1 gnltst_main.c get_next_line.c get_next_line_utils.c -o test.out 2> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out test_error
	exit 42
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	printf "$GREEN[OK]\n$NC"
fi

printf "$PINK\nBUFFER_SIZE -100\n$NC"

gcc -Wall -Wextra -Werror -D BUFFER_SIZE=-100 gnltst_main.c get_next_line.c get_next_line_utils.c -o test.out 2> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out test_error
	exit 42
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	printf "$GREEN[OK]\n$NC"
fi

printf "$PINK\nBUFFER_SIZE 0\n$NC"

gcc -Wall -Wextra -Werror -D BUFFER_SIZE=0 gnltst_main.c get_next_line.c get_next_line_utils.c -o test.out 2> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out test_error
	exit 42
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	printf "$GREEN[OK]\n$NC"
fi

#============================================================================================================#

testnbr=0
printf "$PINK\n==============TEST WITH BUFFER_SIZE==============\n$NC"
gcc -Wall -Wextra -Werror -D BUFFER_SIZE=1 gnltst_main.c get_next_line.c get_next_line_utils.c -o test.out 2> error

printf "$PINK\nBUFFER_SIZE 1\n$NC"

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out
	exit 42
fi

printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC"
file="secret.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC"
file="randomfile.txt" 
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC"
file="randomfilebig.txt"
./test.out $file > output 2>> test_error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

gcc -Wall -Wextra -Werror -D BUFFER_SIZE=1000 gnltst_main.c get_next_line.c get_next_line_utils.c -o test.out 2> error
testnbr=0
printf "$PINK\nBUFFER_SIZE 1000\n$NC"

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out
	exit 42
fi

printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC"
file="secret.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC"
file="randomfile.txt" 
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC"
file="randomfilebig.txt"
./test.out $file > output 2>> test_error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

printf "$PINK\nBUFFER_SIZE 100\n$NC"

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
else
	printf "$RED KO Check the subject.... 😑\n$NC"
	printf "$RED Compiling error\n"
	cat error
	rm error test.out
	exit 42
fi

printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
file="secretfile.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC"
file="secret.txt"
timeout 10s ./test.out $file > output 2>> error
diff output $file

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Empty file)\n$NC" >> error
	./test.out $file 2>> error
fi

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC"
file="randomfile.txt" 
timeout 10s ./test.out $file > output 2>> error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

((testnbr++))
printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC"
file="randomfilebig.txt"
./test.out $file > output 2>> test_error

if [ $? -eq 0 ]; then
	printf "$GREEN[OK]\n$NC"
elif [ $? -eq 124 ]; then
	((qttError++))
	printf "$PURPLE[TIMEOUT]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(normal test)\n$NC" >> error
	printf "\nTimeout ¿? test better your code"
else
	((qttError++))
	printf "$RED[KO]\n$NC"
	printf "\n$BLUE==== TEST $testnbr ====\n$YELLOW(Random big file)\n$NC" >> error
	./test.out $file 2>> error
fi

printf "In this case the diff isn't important. Focus in leaking and segfault\n"

#============================================================================================================#

#                                           YOUR OWN TEST 							 						 #

#============================================================================================================#

if [ $qttError -gt 0 ]; then
	printf "\n$RED========TEST FAILED, GOOD TRY!========\n"
	cat error
	rm error test_error output test.out
	exit 42;
fi
rm error test_error output test.out
printf "$NC\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"
printf "\n\t$GREEN 🌟========TESTS COMPLETED, GOOD LUCK!========🌟\n$NC"
printf "$PINK By Albert Caballero\n Intra: Alcaball\n Github: https://github.com/albertcaballero\n$NC"
printf "$NC\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"
