[ -f "$1.class" ] && rm $1.class
for file in $1.java
do
	echo "Compile $file ... "
	javac $file
done
if [ -f "$1.class" ] then
	echo "------ output ------"
	java $1
else
	echo " "
fi
