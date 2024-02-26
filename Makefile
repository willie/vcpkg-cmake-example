ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Be sure to define OTEL_EXPORTER_OTLP_ENDPOINT & OTEL_EXPORTER_OTLP_HEADERS before running."
	@echo "Usage: make bootstrap|clean|configure|build|run|reconfigure"

.PHONY: bootstrap
bootstrap:
	git submodule update --init && vcpkg/bootstrap-vcpkg.sh

.PHONY: clean
clean:
	rm -rf build

.PHONY: configure
configure:
	@cmake -S . -B build -G Ninja

.PHONY: build
build:
	@cmake --build build

.PHONY: run
run: build
	@build/example $(ARGS)

.PHONY: reconfigure
reconfigure: clean configure