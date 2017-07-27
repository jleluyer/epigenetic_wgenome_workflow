#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#variables
GENOME="genome.fasta"
GENOMEMSK="masked.genome.fasta"
GENOME_FOLDER="04_reference"
OUTPOUT_FOLDER="05_results"
OUTPUTGG="GG.CpGi"
OUTPUTGGM="GGM.CpGi"
OUTPUTTJ="TJ.CpGi"

# Takai and Jones (Takai and Jones., 2002)
cpgplot -sequence "$GENOME" -window 100 -minlen 500 -minoe 0.65 -minpc 55.0 -outfile "$OUTPOUT_FOLDER"/"$OUTPUTTJ".cpgplot -graph none -outfeat "$OUTPOUT_FOLDER"/"$OUTPUTTJ".gff

# Gardiner-Garden approach (Gardiner-Garden et al., 1987)
cpgplot -sequence "$GENOME" -window 100 -minlen 200 -minoe 0.6 -minpc 50.0 -outfile "$OUTPOUT_FOLDER"/"$OUTPUTGG".cpgplot -graph none -outfeat "$OUTPOUT_FOLDER"/"$OUTPUTGG".gff

#Gardiner-Garden masked approach (Bock et al., 2007)
cpgplot -sequence "$GENOMEMSK" -window 100 -minlen 200 -minoe 0.6 -minpc 50.0 -outfile "$OUTPOUT_FOLDER"/"$OUTPUTGGM".cpgplot -graph none -outfeat "$OUTPOUT_FOLDER"/"$OUTPUTGGM".gff
