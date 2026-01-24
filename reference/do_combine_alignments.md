# Combine all BAM alignment files into a single one

Combine all BAM alignment files into a single one

## Usage

``` r
do_combine_alignments(seq_tab, aln_dir, outdir, top_only = FALSE, cores = NULL)
```

## Arguments

- seq_tab:

  Sequence table as returned by
  [do_infer_all_barcodes](https://markschl.github.io/DadaNanoBC/reference/do_infer_all_barcodes.md)
  or downstream functions

- aln_dir:

  Alignment directory (as provided to
  [do_infer_all_barcodes](https://markschl.github.io/DadaNanoBC/reference/do_infer_all_barcodes.md))

- top_only:

  include only the top taxon

- cores:

  Number of cores to use (default: 1, unless
  `getOption('DadaNanoBC.cores')` is defined, or the `DadaNanoBC_cores`
  environment variable is set)

- out_prefix:

  Output prefix for '.bam', '.bam.bai' and '.fasta' files

## Value

Named list of output files
