# candidates of dotfiles
CANDIDATES := $(wildcard .??*) bin
# exclude candidates
EXCLUDES := .DS_Store .git .gitignore

DOTFILES := $(filter-out $(EXCLUDES), $(CANDIDATES))
GHQPATH := ~/ghq
GOPATH := ~/go

.PHONY: install clean ghq

all: install ghqenv goenv;

install:
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

clean:
	@$(foreach f, $(DOTFILES), rm -rfv $(HOME)/$(f);)

ghqenv:
	mkdir -p $(GHQPATH)

goenv:
	mkdir -p $(GOPATH)
