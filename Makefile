# candidates of dotfiles
CANDIDATES := $(wildcard .??*)
# exclude candidates
EXCLUDES := .DS_Store .git .gitignore

DOTFILES := $(filter-out $(EXCLUDES), $(CANDIDATES))
GOPATH := ~/dev
GHQPATH := $(GOPATH)/src
SSHPATH := ~/.ssh

.PHONY: install clean devenv sshenv

all: install devenv sshenv;

install:
	@$(foreach f, $(DOTFILES), ln -sfnv $(abspath $(f)) $(HOME)/$(f);)

clean:
	@$(foreach f, $(DOTFILES), rm -rfv $(HOME)/$(f);)

devenv:
	mkdir -p $(GHQPATH)

sshenv:
	mkdir -p $(SSHPATH)
	chmod 700 $(SSHPATH)
	\cp -f ssh/config $(SSHPATH)
	mkdir -p $(SSHPATH)/config.d
