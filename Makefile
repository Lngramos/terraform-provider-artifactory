GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)

build:
	go build

test: fmtcheck
	@sh -c "'$(CURDIR)/scripts/gotest.sh'"

testacc: setup-test-artifactory
	TF_ACC=1 make test

setup-test-artifactory:
	docker-compose up -d

teardown-test-artifactory:
	docker-compose down
	rm -rf test-artifactory-data

fmt:
	gofmt -w $(GOFMT_FILES)

fmtcheck:
	@sh -c "'$(CURDIR)/scripts/gofmtcheck.sh'"
