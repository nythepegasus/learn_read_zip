.DEFAULT_TARGET := $(EXE)

CC      := gcc
CFLAGS  := -O2 -Iinclude/
LDFLAGS := -Llibs/ -lzip

SRC     := src/main.c
# DIR is install dir
DIR     := build/
EXE     := $(DIR)parse_zip

$(EXE): $(SRC) $(DIR)
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

$(DIR):
	mkdir $@

run: $(EXE)
	$(EXE) data/test.zip

clean:
	rm -r build


.PHONY := clean run
