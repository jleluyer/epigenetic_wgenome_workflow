
#!/bin/bash

for i in $(ls 05_results/CpG_predict/*.gff)

do

grep -v "#" "$i"|awk '{print $1,$5+2000,$5+4000,"\*"}'|sed 's/ /Y/g'|tr 'Y' '\t' >>cpg_predict/shelves."$i"

grep -v "#" "$i"|awk '{print $1,$4-4000,$4-2000,"\*"}'|sed 's/ /Y/g'|tr 'Y' '\t' >>cpg_predict/shelves."$i"

grep -v "#" "$i"|awk '{print $1,$5,$5+2000,"\*"}'|sed 's/ /Y/g' |tr 'Y' '\t' >>cpg_predict/shores."$i"

grep -v "#" "$i"|awk '{print $1,$4-2000,$4,"\*"}'|sed 's/ /Y/g' |tr 'Y' '\t' >>cpg_predict/shores."$i"

grep -v "#" "$i"|awk '{print $1,$4,$5,"\*"}'|sed 's/ /Y/g'|tr 'Y' '\t' >>cpg_predict/cpg."$i"

done
