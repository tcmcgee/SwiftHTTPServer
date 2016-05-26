printf "\n\n\nRunning XCodeTestSuite\n"
xcodebuild -scheme SwiftHTTPServer -configuration Release -toolchain swift test
if [ $? != 0 ]; then
  printf "XCodeTestSuite Failed\n"
  exit 1
fi

xcodebuild -configuration Release -toolchain swift

cd cob_spec
git pull 
mvn package

printf "\n\n\nRunning Cob_Spec Response Test Suite\n"
java -jar fitnesse.jar -c "HttpTestSuite.ResponseTestSuite?suite&format=text"
if [ $? != 0 ]; then
  printf "CobSpec ResponseTestSuite Failed\n"
  exit 1
fi

cd ..
