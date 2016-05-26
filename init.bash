export SWIFT_VERSION=swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a
printf "\n\nDownloading Toolchain $SWIFT_VERSION \n"
curl -O https://swift.org/builds/development/xcode/$SWIFT_VERSION/$SWIFT_VERSION-osx.pkg 
printf "\nInstalling Toolchain, You'll need to enter your password!\n"
sudo installer -pkg $SWIFT_VERSION-osx.pkg -target /
export TOOLCHAINS=swift 
rm $SWIFT_VERSION-osx.pkg

printf "\nCloning Cob_Spec\n"
git clone http://www.github.com/tcmcgee/cob_spec cob_spec
cd cob_spec
printf "\nRunning \"mvn package\", you need Java and Maven!\n"
mvn package
cd ..
