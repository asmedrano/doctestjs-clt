#!/bin/bash
SCRIPTPATH=$(cd "$(dirname "$0")"; pwd)
TEST_NAME=""
OUTPUT=""
PORT=8999
TEST_FILES=""
LIBS=""
while getopts ":t:o:p:" opt; do
  case $opt in
    t)
	    # this should be a c,d,s of test.js files
	    TEST_FILES="$OPTARG"
	    ;;
    l)
	    # this is a c,d,s of additional js files to be injected into the top of the page.
	    LIBS="$OPTARG"
	    ;;
    p)

	    PORT=$OPTARG
	    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


build_test (){
	# make sure we have some test files otherwise exit
	if [[ "$TEST_FILES" == "" ]]; then
		echo "At least one test files (-t) is required."
		exit
	fi
	OIFS=$IFS
	IFS=','

	mkdir -p $SCRIPTPATH/tests
	# we need to stich together the tests
	cat $SCRIPTPATH/fragments/head.html > $SCRIPTPATH/index.html

	#inject the External Libs. If we've been passed a url, load it from the net, else copy it into our tests dir
	for l in $LIBS
	do
		s="http"
		if [[ "$l" == *"$s"* ]]; then
			echo "<script src='$l'></script>" >> $SCRIPTPATH/index.html
		else
			cp $l $SCRIPTPATH/tests/.
			FILE=$(basename "$l")
			echo "<script src='$l'></script>" >> $SCRIPTPATH/index.html
	        fi	       

	done

	cat $SCRIPTPATH/fragments/tests.html >> $SCRIPTPATH/index.html
	# make a directory to hold our js tests
	# now inject the tests
	for t in $TEST_FILES
	do	
		cp $t $SCRIPTPATH/tests/.
		FILE=$(basename "$t")
		echo "<pre class='commenttest' href='./tests/$FILE'></pre>" >> $SCRIPTPATH/index.html
	done
	cat $SCRIPTPATH/fragments/footer.html >> $SCRIPTPATH/index.html
	IFS=$OIFS
}

build_test

# start the server in the directory where this script lives.
cd $SCRIPTPATH
echo "Staring Test on port: $PORT"
python -m SimpleHTTPServer $PORT >/dev/null 2>&1 &
SERVER_PID=$!
echo "...type k to end"
read END_SESS
if [ $END_SESS == "k" ];
then
	kill $SERVER_PID
	exit
fi


