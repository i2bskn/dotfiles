CANDIDATES := $(wildcard .??*) bin
EXCLUDES := .DS_Store .git .gitignore
DOTFILES := $(filter-out $(EXCLUDES), $(CANDIDATES))

.PHONY: install clean ghq

install:
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

clean:
	@$(foreach f, $(DOTFILES), rm -rfv $(HOME)/$(f);)

ghq:
	@$(foreach path, $(shell git config --get-all ghq.root), mkdir -p $(path);)
