DEPS = $(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)

all: deps fmt combined

combined:
	go install .

release: release-deps
	gox -output="build/{{.Dir}}_{{.OS}}_{{.Arch}}" .

fmt:
	go fmt ./...

deps:
	go get github.com/mailhog/MailHog-Server
	go get github.com/mailhog/http
	go get github.com/ian-kent/gotcha/gotcha
	go get github.com/ian-kent/go-log/log
	go get github.com/ian-kent/envconf
	go get github.com/ian-kent/goose
	go get github.com/ian-kent/linkio
	go get github.com/jteeuwen/go-bindata/...
	go get labix.org/v2/mgo
	# added to fix travis issues
	go get github.com/satori/go.uuid
	go get -u golang.org/x/crypto/bcrypt

test-deps:
	go get github.com/smartystreets/goconvey

release-deps:
	go get github.com/mitchellh/gox

.PNONY: all combined release fmt deps test-deps release-deps
