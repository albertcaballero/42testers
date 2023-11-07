#include "get_next_line.h"
#include <stdio.h>
#include <fcntl.h>

int	main(int ac, char **av){
	int fd = open(av[1], O_RDONLY);
	// int	outfile = open("outfile.txt", O_RDWR | O_CREAT | O_APPEND, 0644);
	char *line;

	if (ac == 3){
		if (av[2][0] == '1' && av[2][1] == '2')
			fd = 234567891;
	}
	while (line)
	{
		line = get_next_line(fd);
		dprintf(1, "%s", line);
		free (line);
	}
	// dprintf(1, "\n===========EOF===========\n\n\n");
}