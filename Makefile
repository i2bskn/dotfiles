# candidates of dotfiles
CANDIDATES := $(wildcard .??*) bin
# exclude candidates
EXCLUDES := .DS_Store .git .gitignore

DOTFILES := $(filter-out $(EXCLUDES), $(CANDIDATES))
GOPATH := ~/dev
GHQPATH := $(GOPATH)/src

.PHONY: install clean devenv

all: install devenv;

install:
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

clean:
	@$(foreach f, $(DOTFILES), rm -rfv $(HOME)/$(f);)

devenv:
	mkdir -p $(GHQPATH)
