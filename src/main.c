#include <stdio.h>
#include <pzip.h>


int main(int argc, char** argv){
  if (argc > 2 || argc < 2){
    fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
    return 1;
  }

  struct zip_t* zip;
  if (!(zip = zip_open(argv[1], 0, 'r'))){
    fprintf(stderr, "Couldn't open '%s'\n", argv[1]);
    return 2;
  }
  pzip(zip);
  zip_close(zip);

  return 0;
}
