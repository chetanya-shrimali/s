APPNAME = s
OSARCH = darwin/386 darwin/amd64 linux/386 linux/amd64 windows/386 windows/amd64
DIRS = darwin_386 darwin_amd64 linux_386 linux_amd64 windows_386 windows_amd64
OUTDIR = pkg

all:
	go build .

compile:
	gox -osarch="$(OSARCH)" -output "$(OUTDIR)/{{.OS}}_{{.Arch}}/s"
	@for dir in $(DIRS) ; do \
		(cp README.md $(OUTDIR)/$$dir/README.md) ;\
		(cp LICENSE $(OUTDIR)/$$dir/LICENSE) ;\
		(cp -r autocomplete $(OUTDIR)/$$dir/autocomplete) ;\
		(cd $(OUTDIR) && zip -q s-$$dir.zip -r $$dir) ;\
		echo "make $(OUTDIR)/s-$$dir.zip" ;\
	done

install: all
	go install .

uninstall:
	rm $(GOPATH)/bin/$(APPNAME)
