# epigenetic_wgenome_workflow
Pipeline for DNA methylation and genetic polymorphism analysis from RRBS data 


**WARNING**

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.


## Documentation

Note that **ALL** the scripts must be launched from the root folder
### 1. Clone git hub directory

```
git clone https://github.com/jleluyer/epigenetic_wgenome_workflow
```

### 2. Import data

```
cp /path/to/the/data/repository/*.gz 02_data
```

### 3. Trimming the data

```
sbatch 00_scripts/katak-jobs/01_trim_galore_rrbs.sh
```

You may also want to check the quality of your data prior to trimming using **00_scripts/utility_scripts/fastq.sh**. This will require to have **fastQC** installed in your **$PATH**.


### 4. Polymorphism SNP analysis

##### 4.1 SNPs calling

**Import Biscuit**

```
git clone https://github.com/zwdzwd/biscuit
```

**launch Biscuit**

```
sbatch 00_scripts/02_biscuit.sh
```

##### 4.2 Masking C-T polymorphism in the reference

*Note: SNPs should be post-processed prior to the masking step according to your experiment and data*

**Create .bed file**

*To be added*

**Genome Masking**


### 5. Mapping

**Prepare reference genome**

```
sbatch 00_scripts/02_prepare_reference.sh
```

**Index reference**

```
sbatch 00_scripts/03_bismark_index.sh
```

**Mapping on reference genome**

```
sbatch 00_scripts/04_bismark_align.sh
```

*Also available script for parallel mapping*

### 6. Methylation calls

```
sbatch 00_scripts/05_bismark_CpG_extractor.sh
```

*Scripts for downstream mehytlation analysis are also available*

## Notes

## Dependencies

### Softwares

[BEDtools](http://bedtools.readthedocs.io/en/latest/)

[Bismark](http://www.bioinformatics.babraham.ac.uk/projects/index.html)

[Trim_galore!](http://www.bioinformatics.babraham.ac.uk/projects/index.html)

[FastQC](http://www.bioinformatics.babraham.ac.uk/projects/index.html)

[BISCUIT](https://github.com/zwdzwd/biscuit)

[VCFtools](http://vcftools.sourceforge.net/)


## Licence


##Citations

F. Krueger, S. R. Andrews (2011). Bismark: a flexible aligner and methylation caller for Bisulfite-Seq applications [doi:  10.1093/bioinformatics/btr167](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3102221/)

J. M. Catchen, A. Amores, P. Hohenlohe. W.Cresko, J. H. Postlethwai (2011). Stacks: guilding and genotyping loci de novo from short-read sequences
[doi:  10.1534/g3.111.000240](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3276136/)

G. Shengjie, Z. Dan, M. Likai, et al. BS-SNPer: SNP calling in bisulfite-seq data. Bioinformatics, 2015, 31(24): 4006-4008.[doi:  10.1093/bioinformatics/btv507](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4673977/)

**_worflow in progress_**

*Contributors: Jeremy Le Luyer, Martin Laporte, Eric Normandeau, Madoka Krick*

