#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <assert.h>
#include <stdint.h>

/* path to BAT's tail file */
#define TAIL "/Users/grust/DB2/course/MonetDB/data/scratch/bat/06/605.tail"
/* path to BAT's str heap file */
#define HEAP "/Users/grust/DB2/course/MonetDB/data/scratch/bat/06/605.theap"
/* offset of string dictionary in heap file (see hexdump -C ‹HEAP›) */
#define OFFSET 0x2000


/* scan the tail file (assuming it uses 8-bit refs into str heap) */
void scan_tail(int8_t *tail, off_t size, char *heap)
{
  for (off_t i = 0; i < size / sizeof(int8_t); i = i+1) {
    printf("row #%lld: heap ref %d = \"%s\"\n", i, tail[i], heap + OFFSET + tail[i]);
  }
}

/* mmap file at ‹path›, return address and ‹size› of memory map */
void* mmap_file(char *path, off_t *size)
{
  int fd;
  struct stat status;
  void *map;

  fd = open(path, O_RDONLY);
  assert(fd >= 0);
  assert(stat(path, &status) == 0);
  *size = status.st_size;

  map = mmap(NULL, *size, PROT_READ, MAP_SHARED, fd, 0);
  assert(map != MAP_FAILED);

  close(fd);

  return map;
}


int main()
{
  void *tail_map, *heap_map;
  off_t tail_size, heap_size;

  /* map tail and string dictionary (heap) files into memory */
  tail_map = mmap_file(TAIL, &tail_size);
  heap_map = mmap_file(HEAP, &heap_size);

  scan_tail(tail_map, tail_size, heap_map);

  return 0;
}
