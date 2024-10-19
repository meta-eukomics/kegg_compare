# kegg_compare

- make_kofam_scripts.sh - Sets up kofamscan script for each peptide file for each assembly
- topko.R - Gets the top KO for each orf based on E-value. Filters E-values < 1e-5.

For the CAG samples, data were then merged with counts (from Emily) and taxonomy (from Maggi) for select KOs.
These data were then merged into one csv file (combined_output.csv) for analysis with analyze_KOs.R
