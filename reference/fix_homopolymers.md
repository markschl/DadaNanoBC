# Attempt at "fixing" the consensus sequence in a homopolymer region

Attempt at "fixing" the consensus sequence in a homopolymer region

## Usage

``` r
fix_homopolymers(cons_seq, ref_seq, homopoly_minlen = 6)
```

## Arguments

- cons_seq:

  the consensus

- ref_seq:

  the reference sequence (there should be some confidence that it is
  correct)

- homopoly_minlen:

  minimum homopolymer length to check and fix

## Value

a data frame with these columns:

- *consensus*: the "fixed" consensus sequence

- *n_adjusted* the number of "fixed" homopolymer stretches

## Details

Resolves N-ambiguities in the consensus if surrounded by a homopolymer
stretch, replacing them with the corresponding reference sequence. This
sequence is assumed to be the most likely true sequence, following the
concept of DADA2, which is also based on the assumption that there are
at least a few error-free reads present. It is clear that this might not
be true in *all* cases if there are very long homopolymer stretches
present.

Ns are usually found on the left side (or near it), as minimap2 tends to
left-align gaps, and if there is an ambiguous situation (base + gap),
the consensus becomes an N.

1.  A consensus/reference pairwise alignment is done with DECIPHER

2.  The leftmost N is identified

3.  The first non-N base downstream (right) is assumed to be the
    repeated base (usually true if gaps are left-aligned). Jump to 7. if
    none is found.

4.  The longest stretch of the given base/N/gaps is searched in the
    aligned consensus

5.  If the aligned reference contains only the given base and gaps
    within the range identified in 4., then the consensus sequence is
    replaced with the aligned reference

6.  Go back to 2., searching for the next N

7.  Remove all gaps from the consensus and return this sequence
