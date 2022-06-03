/*
 * loop-swapping.c
 *
 *
 * Demonstrate the effect of hardware characteristics on two
 * nested loops that process a large array row- or column-wise.
 *
 * (c) Jens Teubner, TU Muenchen 2006.
 * slightly modified by Jan Rittinger, Uni Tuebingen 2009.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int argc, char **argv)
{
    unsigned int *tbl;        /* table */
    unsigned int rows, cols;  /* dimensions of the table */
    unsigned int r, c;        /* counters to iterate over the table */

    /* simple check on soundness of command line arguments */
    if (argc != 3) {
        fprintf (stderr, "usage: %s rows columns\n", argv[0]);
        exit (EXIT_FAILURE);
    }

    /* interpret two arguments */
    rows = atoi (argv[1]);
    cols = atoi (argv[2]);

    /* allocate memory for the table */
    tbl = malloc (rows * cols * sizeof (*tbl));

    if (!tbl) {
        fprintf (stderr, "could not allocate memory\n");
        exit (EXIT_FAILURE);
    }

    /* initialize table row-by-row with random values */
    for (r = 0; r < rows; r++)
        for (c = 0; c < cols; c++)
            tbl[r * cols + c] = (unsigned int) random();

    /* ---------- loop combination i. row-major ---------- */


    /* ---------- loop combination ii. column major ---------- */


    return EXIT_SUCCESS;
}
