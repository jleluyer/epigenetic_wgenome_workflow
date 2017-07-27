
#!/bin/bash
#SBATCH -D ./
#SBATCH --job-name="windowsmasker"
#SBATCH -o log-windowsmasker
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#variables
GENOME="genome.fasta"

#stage 1
windowmasker -in $GENOME -mk_counts -out stat.file.wm.txt

#stage 2
windowmasker -in $GENOME -ustat stat.file.wm.txt -out masked_genome.fasta -outfmt 'fasta'

# soft to hard clipping
perl -pe '/^[^>]/ and $_=~ s/[a-z]/N/g' masked_genome.fasta >maskedhard_genome.fasta

#Clean up
#rm masked_genome.fasta
rm stat.file.wm.txt
