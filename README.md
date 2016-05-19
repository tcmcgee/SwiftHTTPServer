[![Build Status](https://travis-ci.org/tcmcgee/SwiftHTTPServer.svg?branch=master)](https://travis-ci.org/tcmcgee/SwiftHTTPServer)
# SwiftHTTPServer

# Requirements

**Recommended Specs (Confirmed working)**

__________________________________________

- XCode 7.3
- OSX El Capitan


# Installing the Toolchain

**If using Terminal**
__________________________

- curl -O https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-osx.pkg
- sudo installer -pkg swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-osx.pkg -target /
- export TOOLCHAINS=swift

**If using XCode**
_____________________________
- Download my toolchain [here] (https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-osx.pkg)
- [Read This Guide] (https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/AlternativeToolchains.html)

# Building and Running 

**If Using Terminal**
________________________________

- xcodebuild -configuration Release -toolchain swift
- ./build/Release//SwiftHTTPServer -p {YOUR DESIRED PORT} -d {YOUR DESIRED PUBLIC DIRECTORY}
- In a browser of your choice navigate to localhost:5000

**If Using XCode**
_________________________________

- Hit the play button or ctrl + R


# Testing 

Check out the latest live build [here] (https://travis-ci.org/tcmcgee/SwiftHTTPServer)

**Running Tests Locally**
______________________________

- Follow Instructions to install and build using XCode
- ctrl + u to build and run tests in XCode

**Running Cob_Spec Locally**
___________________________

- git clone http://www.github.com/tcmcgee/cob_spec cob_spec
- cd cob_spec
- mvn package
- read README in cob_spec to run fitnesse server

# built using toolchain: swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a 
