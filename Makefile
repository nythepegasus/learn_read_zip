.DEFAULT_GOAL := $(EXE)

INCLUDES :=
LIBPATHS :=
LIBFILES :=
LIBS     := -lzip

ZIP_PATH := deps/zip/
ZIP_LIB  := $(ZIP_PATH)libzip.a

INCLUDES += $(ZIP_PATH)src/
LIBPATHS += $(ZIP_PATH)
LIBFILES += $(ZIP_LIB)

CC       := gcc
CFLAGS   := -O2 $(foreach include,$(INCLUDES),-I$(include))
LDFLAGS  := $(foreach lib,$(LIBPATHS),-L$(lib)) $(LIBS)

SRC      := src/main.c
# DIR is install dir
DIR      := build/
EXE      := $(DIR)parse_zip

$(EXE): $(SRC) $(LIBFILES) $(DIR)
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

$(DIR):
	mkdir $@

run: $(EXE)
	$(EXE) data/test.zip

$(ZIP_LIB): $(ZIP_PATH)
	git submodule update --init $<
	cmake -B$< -S$<
	$(MAKE) -C $<

clean:
	#git submodule deinit -f $(ZIP_PATH)
	rm -r build 2>/dev/null


.PHONY := clean run
