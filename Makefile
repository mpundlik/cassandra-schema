include Makeroutines.mk

VERSION=$(shell git rev-parse HEAD)
DATE=$(shell date +'%Y-%m-%dT%H:%M%:z')
COVER_DIR=/tmp/
LDFLAGS=-ldflags '-X github.com/ligato/cassandra-schema/core.BuildVersion=$(VERSION) -X github.com/ligato/cassandra-schema/core.BuildDate=$(DATE)'

# run code analysis
define lint_only
    @echo "# running code analysis"
    @./scripts/golint.sh
    @./scripts/govet.sh
    @echo "# done"
endef

# verify that links in markdown files are valid
# requires npm install -g markdown-link-check
define check_links_only
    @echo "# checking links"
    @./scripts/check_links.sh
    @echo "# done"
endef

# run code formatter
define format_only
    @echo "# formatting the code"
    @./scripts/gofmt.sh
    @echo "# done"
endef

#build struct_to_ddl only
define build_struct_to_ddl_only
    @echo "# building struct_to_ddl tool"
    @cd cmd/struct_to_ddl && go build -v ${LDFLAGS}
    @echo "# done"
endef

#build diff_ddl only
define build_diff_ddl_only
    @echo "# building diff_ddl tool"
    @cd cmd/diff_ddl && go build -v ${LDFLAGS}
    @echo "# done"
endef

# build all binaries
build:
	$(call build_struct_to_ddl_only)
	$(call build_diff_ddl_only)

# install dependencies
install-dep:
	$(call install_dependencies)

# update dependencies
update-dep:
	$(call update_dependencies)

# run & print code analysis
lint:
	$(call lint_only)

# validate links in markdown files
check_links:
	$(call check_links_only)

# format the code
format:
	$(call format_only)

# clean
clean:
	@echo "# cleanup completed"

# run all targets
all:
	$(call lint_only)

.PHONY: build update-dep install-dep lint check_links clean
