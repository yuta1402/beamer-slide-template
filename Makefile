ROOTEX = main.tex
TARGET = slide
SRCS = $(shell find ./ -name "*.tex")

all: $(TARGET)

$(TARGET): $(SRCS)
	latexmk -jobname=$@ $(ROOTEX)

.PHONY: watch
watch:
	latexmk -pvc -jobname=$(TARGET) $(ROOTEX) -silent

.PHONY: clean
clean:
	latexmk -CA -jobname=$(TARGET) $(ROOTEX)
