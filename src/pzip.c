#include <stdio.h>
#include <stdlib.h>
#include <pzip.h>

void pzip(struct zip_t* zip) {
  int i, n = zip_entries_total(zip);
  unsigned char *buf;
  for (i = 0; i<n; ++i){
    zip_entry_openbyindex(zip, i);
    {
      const char* name = zip_entry_name(zip);
      int isdir = zip_entry_isdir(zip);
      size_t size = zip_entry_size(zip);
      unsigned int crc32 = zip_entry_crc32(zip);
      if (!isdir){
        printf("%s: %zu bytes, CRC: %i\n", name, size, crc32);
        //zip_entry_open(zip, name);
        {
          buf = calloc(sizeof(unsigned char), size);
          zip_entry_noallocread(zip, (void*)buf, size);
          printf("Contents:\n%s\n", buf);
        }
        zip_entry_close(zip);
      } else {
        printf("%s\n", name);
      }
    }
    zip_entry_close(zip);
  }
  free(buf);
}
