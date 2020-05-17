cut -d ':' -f 3 newrelevantfiles.txt > namesofdefinitions.txt
cut -d ':' -f 1 newrelevantfiles.txt > namesoffiles.txt
cut -d ':' -f 2 newrelevantfiles.txt > linenumbers.txt

counter=1;
cat namesofdefinitions.txt|while read F	
do
echo $F > temp.txt
methodname=$(grep -o 'SYSCALL_DEFINE.(.*,' temp.txt | cut -f 2  -d'(' | cut -f 1  -d',' ) #> methodname.txt
echo $methodname
#echo $F
filename=$(cat namesoffiles.txt | head -$counter | tail -1)
echo $filename

linenumber=$(cat linenumbers.txt | head -$counter | tail -1)
echo $linenumber
linenumber=$((linenumber-1))
insertnumber=$({ head -n $linenumber >/dev/null; grep -m 1 -n { | cut -f 1 -d':'; } <$filename )
insertnumber=$((insertnumber+linenumber))
echo $insertnumber

{ head -n $linenumber >/dev/null; grep -B 5 -m 1 -n { >> testthis; } <$filename 

fname=$({ head -n $linenumber >/dev/null; grep -o -m 1 -n 'fd\|filename\|oldname\|newdfd\|newfd\|dfd\|kernel_fd\|group_fd|\mountdirfd\|path\|pathname\|oldname\|out_fd\|in_fd' | cut -f 2 -d':'; } <$filename )
echo $fname

#sed '$insertnumber a mymacro($methodname, $fname, $pid)' $filename
counter=$((counter+1))

done