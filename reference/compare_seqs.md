# Compare different sequences per taxon

Aligns different sequences/haplotypes per putative taxon (if there are
multiple) by mapping all of them to the first sequence (including the
first sequence itself). The resulting small BAM files are useful for
visual comparisons.

Also aligns DADA2 ASV sequences that don't match the consensus, as well
as any provided 'known' sequences. For the putative taxa concerned,
*all* sequences are included for comparison.

Usually the first sequence within a taxon is chosen as reference, or the
one matching the known sequence

## Usage

``` r
compare_seqs(d, bam_out, tmp_dir = NULL, known_seq = NULL)
```

## Arguments

- d:

  data frame returned by
  [infer_barcode](https://markschl.github.io/DadaNanoBC/reference/infer_barcode.md)
  (needs these columns: *taxon_num*, *consensus*, *sequence*, *is_rare*)

- bam_out:

  path of BAM output file

- tmp_dir:

  optional temporary directory

- known_seq:

  optional known sequence

## Value

Returns the input data frame with the following additional columns:

- `consensus_diffs`: Number of ASV/consensus differences (NA if not
  compared, Inf if not mapped due to too many mismatches).
  Base/ambiguity or ambiguity/ambiguity matching is also done.
  Mismatches are only reported if there is no overlap between the two
  (partially matching ambiguities still count as match).

- `is_compare_ref`: logical indicating whether a consensus sequence was
  used as reference for the comparison within a taxon
