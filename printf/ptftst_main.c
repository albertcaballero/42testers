#include "ft_printf.h"
#include <stdio.h>

int	main(int ac, char **av){
	int	or_ret;
	int	ft_ret;

	if (ac != 2)
		return (write(1, "wrong argc", 20), 1);
	printf("---Your result:---\n");
	ft_ret = ft_printf(av[1]);
	printf("\n---Original:---\n");
	or_ret = printf(av[1]);
	printf("\nYour return value: %i\nOriginal return value: %i\n", ft_ret, or_ret);
	return (0);
}