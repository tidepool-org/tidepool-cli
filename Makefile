ROOT_DIRECTORY:=$(realpath $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))
REPOSITORY:=$(ROOT_DIRECTORY:$(realpath $(ROOT_DIRECTORY)/../../../)/%=%)

GO_LD_FLAGS:=-ldflags "-X $(REPOSITORY)/version.Base=$(REPOSITORY_VERSION_BASE) -X $(REPOSITORY)/version.Commit=$(REPOSITORY_VERSION_COMMIT)"

MAIN_FIND_CMD:=find . -not -path './vendor/*' -name '*.go' -type f -exec egrep -l '^\s*func\s+main\s*\(' {} \;
MAIN_TRANSFORM_CMD:=sed 's/\(.*\/\([^\/]*\)\.go\)/_bin\/\2 \1/'
GO_BUILD_CMD:=go build $(GO_BUILD_FLAGS) $(GO_LD_FLAGS) -o

default: build

check-gopath:
ifndef GOPATH
	@echo "FATAL: GOPATH environment variable not defined. Please see http://golang.org/doc/code.html#GOPATH."
	@exit 1
endif
	@exit 0

check-environment: check-gopath

goimports: check-environment
ifeq ($(shell which goimports),)
	go get -u golang.org/x/tools/cmd/goimports
endif

golint: check-environment
ifeq ($(shell which golint),)
	go get -u github.com/golang/lint/golint
endif

gocode: check-environment
ifeq ($(shell which gocode),)
	go get -u github.com/nsf/gocode
endif

godef: check-environment
ifeq ($(shell which godef),)
	go get -u github.com/rogpeppe/godef
endif

oracle: check-environment
ifeq ($(shell which oracle),)
	go get -u golang.org/x/tools/cmd/oracle
endif

buildable: goimports golint

editable: buildable gocode godef oracle

format: check-environment
	@echo "gofmt -d -e -s"
	@cd $(ROOT_DIRECTORY) && O=`find . -not -path './vendor/*' -name '*.go' -type f -exec gofmt -d -e -s {} \; 2>&1` && [ -z "$${O}" ] || (echo "$${O}" && exit 1)

imports: goimports
	@echo "goimports -d -e"
	@cd $(ROOT_DIRECTORY) && O=`find . -not -path './vendor/*' -name '*.go' -type f -exec goimports -d -e {} \; 2>&1` && [ -z "$${O}" ] || (echo "$${O}" && exit 1)

vet: check-environment
	@echo "go tool vet -test"
	@cd $(ROOT_DIRECTORY) && O=`find . -mindepth 1 -maxdepth 1 -not -path "./.*" -not -path "./_*" -not -path "./vendor" -type d -exec go tool vet -test {} \; 2>&1` && [ -z "$${O}" ] || (echo "$${O}" && exit 1)

lint: golint
	@echo "golint"
	@cd $(ROOT_DIRECTORY) && O=`find . -not -path './vendor/*' -name '*.go' -type f -exec golint {} \; | grep -v 'exported.*should have comment.*or be unexported' 2>&1` && [ -z "$${O}" ] || (echo "$${O}" && exit 0)

pre-build: format imports vet

build:
	@echo "go build"
	@cd $(ROOT_DIRECTORY) && mkdir -p _bin && $(MAIN_FIND_CMD) | $(MAIN_TRANSFORM_CMD) | xargs -L1 $(GO_BUILD_CMD)

clean:
	@cd $(ROOT_DIRECTORY) && rm -rf _bin

git-hooks:
	@echo "Installing git hooks..."
	@cd $(ROOT_DIRECTORY) && cp _tools/git/hooks/* .git/hooks/

pre-commit: format imports vet

.PHONY: default check-go check-gopath check-environment \
	goimports golint gocode godef oracle buildable editable \
	format imports vet lint pre-build build clean git-hooks pre-commit
