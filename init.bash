export SWIFT_VERSION=swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a
curl -O https://swift.org/builds/development/xcode/$SWIFT_VERSION/$SWIFT_VERSION-osx.pkg 
sudo installer -pkg $SWIFT_VERSION-osx.pkg -target /
export TOOLCHAINS=swift 


git clone http://www.github.com/tcmcgee/cob_spec cob_spec
cd cob_spec
mvn package
cd ..
