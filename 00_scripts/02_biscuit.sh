#!/bin/bash
#SBATCH -D ./
#SBATCH --job-name="biscuit"
#SBATCH -o log-biscuit.out
#SBATCH -c 8
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=7-00:00
#SBATCH --mem=200000

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR


#global variables
GENOME="genome.fasta"
BAM_FOLDER="04_mapped_genetic"
RAW_VCF="raw.vcf"

#index genome
biscuit index $GENOME

#Align
for i in $(ls 03_trimmed/*gz|sed -e 's/.fq.gz//g' -e 's/03_trimmed//g'); do biscuit align $GENOME -t 10 03_trimmed/"$i".fq.gz > 04_mapped_genetic/"$i".sam; done

for i in $(ls 04_mapped_genetic/*sam|sed 's/.sam//g'); do samtools view -Sb -q 10 -F 4 "$i".sam >"$i".bam; done

for i in $(ls 04_mapped_genetic/*bam|sed 's/.bam//g'); do samtools sort "$i".bam "$i".sort; done

rm 04_mapped_genetic/*.sam


sort and index bam file
for i in $(ls 04_mapped/*.sort.bam|sed 's/.sort.bam//g')
do

samtools index "$i".sort.bam
done

# stats
for i in $(ls "$BAM_FOLDER"/*.sort.bam); do samtools flagstat "$i" >"$i".flagstat; done

#prepare bam files
ls -1 04_mapped_genetic/*.sort.bam|tr '\n' ','|sed -e 's/,$//g' -e 's#,# #g' >list_bam
DATA="$(cat list_bam)"

cd 04_mapped_genetic/

#call methylation and snps
biscuit pileup -r $REFERENCE -k 10 -q 30 -E 0.1 -M 0.1 -i $DATA -o "$BAM_FOLDER"/"$RAW_VCF"
