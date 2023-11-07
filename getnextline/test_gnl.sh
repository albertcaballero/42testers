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
printf "$PURPLE=======EXECUTING TESTS========$NC"
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

printf "\n$PURPLE====TESTS COMPLETED====\n$NC"

#can be improved using dprintf to tmp files and using cat -e of such files :)