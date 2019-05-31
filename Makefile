ROOTEX = main.tex
TARGET = slide
SRCS = $(shell find ./ -name "*.tex")
CMD = env TEXINPUTS='.//;' latexmk

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CMD) -jobname=$@ $(ROOTEX)

.PHONY: watch
watch:
	$(CMD) -pvc -jobname=$(TARGET) $(ROOTEX) -silent

.PHONY: clean
clean:
	${CMD} -CA -jobname=$(TARGET) $(ROOTEX)
