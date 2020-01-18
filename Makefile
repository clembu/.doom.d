##
# Doom configuration
#

SHELL = /bin/sh

ORG_FILE = README.org

.PHONY: tangle
tangle: $(ORG_FILE)
	emacs --batch -l ob-tangle --eval "(org-babel-tangle-file \"$<\")"

# end
