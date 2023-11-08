RED="\033[38;5;161m"
GREEN="\033[38;5;154m"
YELLOW="\033[38;5;227m"
BLUE="\033[38;5;81m"
PURPLE="\033[38;5;93m"
PINK="\033[38;5;219m"
NC="\033[0m"

cc main.c get_next_line.c get_next_line_utils.c
rm outfile.txt

file="secretfile.txt"
testnbr=1
printf "\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"
printf "$GREEN\n\t🌟=======ALCABALL GNL mini-TESTER========🌟\n$NC"
printf "$PINK\nIf there's any issue or something to improve, pls tell me!! :)\n\
	(I'm always at the campus and I'm 24/7 on Slack)\n"
printf "\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"

printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
./a.out $file

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(nonexisting file)\n$NC"
./a.out "NOSUCHFILE"

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(no file permissions)\n$NC"
chmod a-r $file
./a.out $file
chmod a+r $file

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(big buffer size)\n$NC"
cc main.c get_next_line.c get_next_line_utils.c -D BUFFER_SIZE=9223
./a.out $file

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(small buffer size)\n$NC"
cc main.c get_next_line.c get_next_line_utils.c -D BUFFER_SIZE=1
./a.out $file

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(buffer size is 0)\n$NC"
cc main.c get_next_line.c get_next_line_utils.c -D BUFFER_SIZE=0
./a.out $file

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(negative buffer size)\n$NC"
cc main.c get_next_line.c get_next_line_utils.c -D BUFFER_SIZE=-727
./a.out $file

testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(megabig fd)\n$NC"
./a.out $file "12"

printf "$NC\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"
printf "\n\t$GREEN 🌟========TESTS COMPLETED, GOOD LUCK!========🌟\n$NC"
printf "$PINK By Albert Caballero\n Intra: Alcaball\n Github: https://github.com/albertcaballero\n$NC"
printf "$NC\n🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲🔳🔲\n"

#can be improved using dprintf to tmp files and using cat -e of such files :)