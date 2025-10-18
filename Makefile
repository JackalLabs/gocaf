export GO111MODULE = on

###############################################################################
###                                Linting                                  ###
###############################################################################
golangci_lint_cmd=golangci-lint

format-tools:
	go install mvdan.cc/gofumpt@latest
	gofumpt -l -w .

lint: format-tools
	@echo "--> Running linter"
	$(golangci_lint_cmd) run --timeout=10m

lint-fix:
	@echo "--> Running linter"
	$(golangci_lint_cmd) run --fix --out-format=tab --issues-exit-code=0

.PHONY: lint lint-fix format-tools

format:
	find . -name '*.go' -type f -not -path "./vendor*" -not -path "*.git*" -not -name '*.pb.go' -not -path "./venv" | xargs gofmt -w -s
	find . -name '*.go' -type f -not -path "./vendor*" -not -path "*.git*" -not -name '*.pb.go' -not -path "./venv" | xargs misspell -w
	find . -name '*.go' -type f -not -path "./vendor*" -not -path "*.git*" -not -name '*.pb.go' -not -path "./venv" | xargs goimports -w -local github.com/desmos-labs/cosmos-go-wallet
.PHONY: format
