##
## EPITECH PROJECT, 2019
## imageCompressor
## File description:
## makefile
##

SRC_DIR		=	$(realpath ./src)

NAME		=	imageCompressor

TEST_NAME	=	test_coverage

RM			=	rm -f

PA_TEST		= `stack path --local-install-root`/hpc/$(NAME)/$(NAME)-test/hpc_index.html

PA			= `stack path --local-install-root`/bin/imageCompressor-exe

all:	$(NAME)

$(NAME):
		stack build
		@cp $(PA) ./$(NAME)

tests_run:
	@rm -f $(PA_TEST)
	stack test --coverage
	@/usr/bin/firefox --new-window $(PA_TEST)

debug:
	stack build --trace
	@cp $(PA) ./$(NAME)

clean:
		$(RM) $(SRC_DIR)/*~
		$(RM) $(SRC_DIR)/\#*\#
		$(RM) *~
		$(RM) \#*\#

fclean:	clean
		$(RM) $(NAME)

re:	fclean all

.PHONY:	all, clean, fclean, re
