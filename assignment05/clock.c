#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

// Represents an element in the buffer
typedef struct {
  int reference; // The page reference. Initially the value is set to -1.
                 // Otherwise, its a reference which is a positive integer greater 0
  int used;      // Is set to 1, if it has been used. Otherwise, its unused and thus set to 0.
                 // Initially it is set to 0 (unused)
} buffer;

// Parse the reference string from a file at the given path
// and return a list of references and set the reference string length
int* parse_reference_string(char *path, int *length) {  
  int size, line_size;
  int *reference_string;
  FILE *file;
  char *line;
  
  file = fopen(path, "r");
  assert(file);
  
  line_size = 32;
  line = (char *)malloc(sizeof(char)*line_size);
  
  size = 2;
  *length = 0;
  reference_string = (int *)malloc(sizeof(int)*size);
  
  while (fgets(line, line_size, file)) {      
      reference_string[*length] = atoi(line);
      assert(reference_string[*length] > 0);
      
      (*length)++;
      
      if(*length == size) {
        size *= 2;
        reference_string = realloc(reference_string, sizeof(int) * size);
      }
  }
  
  reference_string = realloc(reference_string, sizeof(int) * (*length));
  
  return reference_string;
}

// Initialize buffer with buffer size 
buffer *init_buffer(int buffer_size) {
  buffer *buffer_state = (buffer *)malloc(sizeof(buffer) * buffer_size);
  
  for(int i = 0; i < buffer_size; ++i) {
    buffer_state[i].reference = -1;
    buffer_state[i].used = 0;
  }
  
  return buffer_state;
}

// Based on the current clock pointer and the buffer state, update the 
// buffer state and return the new clock pointer 
int clock_sweep_step(int clock_pointer, buffer *buffer_state, int buffer_size, int current_reference) {
  // YOUR CODE HERE
}

int main(int argc, char **args) {
  if(argc != 3) {
    printf("USAGE:\tclock <buffer size> <reference string file>\n\n"
           "OPTIONS:\n"
           "<buffer size>\n"
           "\tThe buffer size is a positive integer greater 0.\n"
           "\tIt defines how many different references the buffer can hold\n" 
           "\ti.e.: the buffer size.\n"
           "<reference string file>\n"
           "\tProvides the path to a file holding the reference string.\n"
           "\tThe reference string has to be in the form of a line break seperated list.\n"
           "\tThe references are represented as positive integers greater 0 and\n"
           "\tare read line by line.\n");
    return 0;
  }
  
  int clock_pointer, reference_string_length, buffer_size;
  buffer *buffer_state;
  int *reference_string;
  
  buffer_size = atoi(args[1]);
  reference_string = parse_reference_string(args[2], &reference_string_length);
  clock_pointer = 0;
  
  assert(buffer_size > 0);
  assert(reference_string);
  
  buffer_state = init_buffer(buffer_size);
    
  // Reference the pages from the reference string from left to right and 
  // modify the buffer according to the clock algorithm.
  for(int i = 0; i < reference_string_length; ++i) {
    clock_pointer = clock_sweep_step(clock_pointer, buffer_state, buffer_size, reference_string[i]);
    printf("Reference: %d, Buffer: ", reference_string[i]);
    
    for(int i = 0; i < buffer_size; ++i) {
      if(buffer_state[i].reference >= 0) {          
        printf("(%d,%d) ", buffer_state[i].reference, buffer_state[i].used);
      } else {
        printf("( , ) ");
      }
    }
    
    printf("Pointer Position: %d\n", clock_pointer);
  }
  
  return 0;
}
