#include "get_next_line.h"
#include <stdio.h>
#include <fcntl.h>

int	main(int ac, char **av){
	int fd = open(av[1], O_RDONLY);
	char *line;

	if (ac == 3){
		if (av[2][0] == '1' && av[2][1] == '2')
			fd = 234567891;
	}
	line = get_next_line(fd);
	while (line)
	{
		printf("%s", line);
		free (line);
		line = get_next_line(fd);
	}
	close (fd);
}