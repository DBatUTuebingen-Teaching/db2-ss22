#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <assert.h>
#include <stdint.h>

// Relative path to the tail-file for column a of table binary in your solution
#define TAIL_A "relative/path/to/table/binary/column/a/tail"

// Relative path to the tail-file for column b of table binary in your solution
#define TAIL_B "relative/path/to/table/binary/column/b/tail"

// Print oid, tail_a and tail_b of table binary side by side.
void scan_tails(int32_t *tail_a, double *tail_b, off_t record_count)
{
  // (c) Your code here.
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
  off_t tail_a_size, tail_b_size, a_count, b_count;
  int32_t *tail_a_map;
  double *tail_b_map;

  tail_a_map = (int32_t *) mmap_file(TAIL_A, &tail_a_size);
  tail_b_map = (double *) mmap_file(TAIL_B, &tail_b_size);

  // (d)
  a_count = tail_a_size / sizeof(int32_t);
  b_count = tail_b_size / sizeof(double);

  scan_tails(tail_a_map, tail_b_map, a_count);

  return 0;
}
