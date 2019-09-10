ROOTEX = main.tex
TARGET = slide.pdf
SRCS = $(shell find ./ -name "*.tex")
CMD = env TEXINPUTS='.//;' latexmk
OS = $(shell uname -s)
UID = $(shell echo "$${SUDO_UID:-$(shell id -u)}")
GID = $(shell echo "$${SUDO_GID:-$(shell id -g)}")
DOCKER_RUN = env UID=$(UID) GID=$(GID) docker-compose run --rm

all: build

init: docker/build

up: docker/up

down: docker/down

sh: docker/sh

build:
	@$(DOCKER_RUN) builder make local/build

watch: build
ifeq ($(OS), Darwin)
	open -a Skim $(TARGET)
else
ifeq ($(OS), Linux)
	evince $(TARGET) &
endif
endif
	@$(DOCKER_RUN) builder make local/watch

clean:
	@$(DOCKER_RUN) builder make local/clean

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
	@$(DOCKER_RUN) builder /bin/sh

.PHONY: init up down sh build watch clean
.PHONY: local/* docker/*
