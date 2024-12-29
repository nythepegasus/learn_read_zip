.DEFAULT_GOAL := $(EXE)

INCLUDES :=
LIBPATHS :=
LIBS     :=

ZIP_PATH := deps/zip/
ZIP_LIB  := $(ZIP_PATH)libzip.a

INCLUDES += $(ZIP_PATH)src/
LIBPATHS += $(ZIP_PATH)
LIBS     += $(ZIP_LIB)

CC       := gcc
CFLAGS   := -O2 -I$(INCLUDES)
LDFLAGS  := -L$(LIBPATHS) -lzip

SRC      := src/main.c
# DIR is install dir
DIR      := build/
EXE      := $(DIR)parse_zip

$(EXE): $(SRC) $(LIBS) $(DIR)
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
