RED="\033[38;5;161m"
GREEN="\033[38;5;154m"
YELLOW="\033[38;5;227m"
BLUE="\033[38;5;81m"
PURPLE="\033[38;5;93m"
PINK="\033[38;5;219m"
NC="\033[0m"

cc main.c libftprintf.a #keep in mind file locations

testnbr=1
printf "$PURPLE=======EXECUTING TESTS========$NC"
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(normal test)\n$NC"
./a.out "holaholahola"
testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(empty string)\n$NC"
./a.out "Hey, how are you!?  	\0!!"
testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(empty string)\n$NC"
./a.out ""
testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(weird behaviourt)\n$NC"
./a.out "%%%%%%%"
testnbr=$(($testnbr + 1))
printf "\n$BLUE====TEST $testnbr ====\n$YELLOW(segfault)\n$NC"
./a.out "%s%s" #if segfault KO
printf "\n$PURPLE====TESTS COMPLETED====\n$NC"