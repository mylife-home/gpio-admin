
CC=gcc
CFLAGS=-Wall -O2

SRCDIR=src

SRC=$(wildcard $(SRCDIR)/*.c)
OBJS=$(SRC:$(SRCDIR)/%.c=$(OUTDIR)/%.o)

ifndef DESTDIR
DESTDIR=/usr/local
endif

all: out/gpio-admin
.PHONY: all

out/gpio-admin: $(OBJS)

out/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $< -c -o $@

install: out/gpio-admin
	mkdir -p $(DESTDIR)/bin/
	install $(OUTDIR)/gpio-admin $(DESTDIR)/bin/
	chown root:root $(DESTDIR)/bin/gpio-admin
	chmod +s $(DESTDIR)/bin/gpio-admin
.PHONY: install

uninstall:
	rm -vf $(DESTDIR)/bin/gpio-admin
.PHONY: uninstall

clean :
	rm -rf out
.PHONY: clean

again: clean all
.PHONY: again
