Setup:

  $ . $TESTDIR/setup.sh
  $ TEST_FILETYPE_EXT1=`ag --list-file-types | grep -E '^[ \t]+\..+' | head -n 1 | awk '{ print $1 }'`
  $ TEST_FILETYPE_EXT2=`ag --list-file-types | grep -E '^[ \t]+\..+' | tail -n 1 | awk '{ print $1 }'`
  $ TEST_FILETYPE_DIR=filetype_test
  $ mkdir $TEST_FILETYPE_DIR
  $ printf "This is filetype test1.\n" >  $TEST_FILETYPE_DIR/test.$TEST_FILETYPE_EXT1
  $ printf "This is filetype test2.\n" >  $TEST_FILETYPE_DIR/test.$TEST_FILETYPE_EXT2

Match only top file type:

  $ TEST_FILETYPE_OPTION=`ag --list-file-types | grep -E '^[ \t]+--.+' | head -n 1 | awk '{ print $1 }'`
  $ ag 'This is filetype test' --nofilename $TEST_FILETYPE_OPTION $TEST_FILETYPE_DIR
  This is filetype test1.
