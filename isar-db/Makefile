# simple command:
# protoc --dart_out=grpc:isar-db/lib/api -Iprotos protos/users.proto

SHELL := /bin/bash

PROTO_DIR := ../protos           # Path to the protos directory
OUT_DIR := lib/api               # Output directory for generated Dart files
PROTO_FILES := $(wildcard $(PROTO_DIR)/*.proto)  # Collect all .proto files

.DEFAULT_GOAL := generate

generate: ## Generate Dart gRPC files from .proto definitions
	@if [ -z "$(PROTO_FILES)" ]; then \
		echo "No .proto files found in $(PROTO_DIR)"; \
		exit 1; \
	fi
	@echo "Generating gRPC files from:"
	@for proto_file in $(PROTO_FILES); do \
		echo "  $$proto_file"; \
		protoc \
			--dart_out="grpc:$(OUT_DIR)" \
			--proto_path=$(PROTO_DIR) \
			$$proto_file; \
	done
	@echo "gRPC file generation complete. Files are in $(OUT_DIR)"
