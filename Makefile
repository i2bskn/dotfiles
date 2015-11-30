CANDIDATES := $(wildcard .??*) bin
EXCLUDES := .DS_Store .git .gitignore
DOTFILES := $(filter-out $(EXCLUDES), $(CANDIDATES))

.PHONY: install
install:
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

.PHONY: clean
clean:
	@$(foreach f, $(DOTFILES), rm -rfv $(HOME)/$(f);)

.PHONY: ghq
ghq:
	@$(foreach path, $(shell git config --get-all ghq.root), mkdir -p $(path);)
