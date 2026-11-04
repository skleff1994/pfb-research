# Build the documents from the code in the enclosing repository (..).
#   make figures   regenerate the vector figures of doc/figures/ with the code's figure scripts
#   make pdf       write doc/code_version.tex, then build main.pdf and experiments.pdf (experiments cites main via xr)
#   make           both
CODE := ..
FIG  := $(CURDIR)/doc/figures
EXAMPLE_TASKS := concepts fields wrench-sets resolution plugin load-factor
SIM_TASKS     := sim-grip-plot sim-delay-plot

.PHONY: all figures version pdf
all: figures pdf

figures:
	cd $(CODE) && for t in $(EXAMPLE_TASKS); do PFB_DOC_FIG=$(FIG) pixi run $$t || exit 1; done
	cd $(CODE) && for t in $(SIM_TASKS); do PFB_DOC_FIG=$(FIG) pixi run -e sim $$t || exit 1; done

# code commit, with -dirty if code differs from it (regenerated previews in examples/figures/ do not count)
version:
	v=$$(git -C $(CODE) rev-parse --short HEAD); \
	git -C $(CODE) diff --quiet HEAD -- . ':(exclude)examples/figures' || v=$$v-dirty; \
	printf '\\newcommand{\\codeversion}{%s}\n' "$$v" > doc/code_version.tex

pdf: version
	cd doc && latexmk -pdf -interaction=nonstopmode main.tex && latexmk -pdf -interaction=nonstopmode experiments.tex
