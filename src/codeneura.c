#include <errno.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
  if (argc != 2) {
    fprintf(stderr, "Usage: %s <file_path>\n", argv[0]);
    return 1;
  }

  char* filename = argv[1];
  FILE* f = fopen(filename, "r");
  if (f == NULL) {
    fprintf(stderr," Can't open file %s: %s\n", filename, strerror(errno));
    return 1;
  }
  //TODO: buffer should be change to target dataset to map dataset to specific struct
  unsigned char buffer[400];
  fread(&buffer, sizeof(buffer), 1, f);

  printf("%s\n", buffer);

  fclose(f);
  return 0;
}

