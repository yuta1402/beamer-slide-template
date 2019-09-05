ROOTEX = main.tex
TARGET = slide.pdf
SRCS = $(shell find ./ -name "*.tex")
CMD = env TEXINPUTS='.//;' latexmk
OS = $(shell uname -s)

all: build

init: docker/build docker/up

up: docker/up

down: docker/down

sh: docker/sh

build:
	@docker-compose exec builder make local/build

watch: build
ifeq ($(OS), Darwin)
	open -a Skim $(TARGET)
else
ifeq ($(OS), Linux)
	evince $(TARGET) &
endif
endif
	@docker-compose exec builder make local/watch

clean:
	@docker-compose exec builder make local/clean

local/build: $(TARGET)

$(TARGET): $(SRCS)
	$(CMD) -jobname=$(basename $@) $(ROOTEX)

local/watch:
	$(CMD) -pvc -jobname=$(basename $(TARGET)) $(ROOTEX) -silent

local/clean:
	${CMD} -CA -jobname=$(basename $(TARGET)) $(ROOTEX)

docker/build: docker-compose.yml
	docker-compose build

docker/up:
	docker-compose up -d

docker/down:
	docker-compose down

docker/sh:
	docker-compose exec builder /bin/sh

.PHONY: init up down sh build watch clean
.PHONY: local/* docker/*
