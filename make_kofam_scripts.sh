#!/bin/bash

# clean up old files
rm slurm_execute.sh
touch slurm_execute.sh

# Make script for each file and then execute all from slurm_execute.sh
samps=`ls *.fa | sed -e 's/.fa//g'`

for samp in $samps
do
    echo $samp
    cat >> kofam_${samp}.sh <<EOL
#!/bin/bash
#SBATCH --partition=condo
#SBATCH --qos=condo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --time=24:00:00
#SBATCH --account=sio141

cd /tscc/nfs/home/rlampe/ps-allenlab/rlampe/metaT_intercal/KEGG_compare/indiv/assemb

source activate metaT

/tscc/projects/ps-allenlab/rlampe/metaT_intercal/KEGG_compare/bin/kofam_scan-1.3.0/exec_annotation \
     -o kofam_${samp}.tsv \
     -p /tscc/projects/ps-allenlab/rlampe/metaT_intercal/KEGG_compare/db/kofam_profiles/ \
     -k /tscc/projects/ps-allenlab/rlampe/metaT_intercal/KEGG_compare/db/ko_list \
     --cpu=8 --tmp-dir=./tmp_${samp} --e-value=0.00001 \
     -f detail-tsv --report-unannotated ${samp}.fa

EOL

echo "sbatch kofam_${samp}.sh" >> slurm_execute.sh

done
