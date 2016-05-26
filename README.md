[![Build Status](https://travis-ci.org/tcmcgee/SwiftHTTPServer.svg?branch=master)](https://travis-ci.org/tcmcgee/SwiftHTTPServer)
# SwiftHTTPServer

# Quick Start
- ```bash init.bash``` to install the toolchain and prepare cob_spec to be run.
- ```bash tests.bash``` to run all tests xCodeTest and cob_spec ResponseTestSuite
- ```bash start.bash``` builds the server and starts it with default values at http://localhost:5000

# Requirements

**Recommended Specs (Confirmed working)**

__________________________________________

- XCode 7.3
- OSX El Capitan
- Java (cob_spec)
- Maven (cob_spec)

# Installing the Toolchain, building and running the server

**bash init.bash** to install the toolchain, and prepare cob_spec

**If using Terminal**
__________________________
- bash init.bash 


**If using XCode**
_____________________________
- Download my toolchain [here] (https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-osx.pkg)
- [Read This Guide] (https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/AlternativeToolchains.html)

# Building and Running 

**If Using Terminal**
________________________________

- bash start.bash

Or

- xcodebuild -configuration Release -toolchain swift
- ./build/Release/SwiftHTTPServer -p {YOUR DESIRED PORT} -d {YOUR DESIRED PUBLIC DIRECTORY} -l {YOUR DESIRED LOG DIRECTORY}
- example: ./build/ReleaseSwiftHTTPServer -p 5000 -d ./cob_spec/public -l ./logs
- In a browser of your choice navigate to localhost:{YOUR DESIRED PORT}

**If Using XCode**
_________________________________

- Hit the play button or ctrl + R


# Testing 

**bash tests.bash** to run all tests

Check out the latest live build [here] (https://travis-ci.org/tcmcgee/SwiftHTTPServer)

**Running Just XCodeTest Tests Locally**
______________________________

- Follow Instructions to install and build using XCode
- ctrl + u to build and run tests in XCode
Or in terminal
- xcodebuild -configuration Release -toolchain swift  -scheme SwiftHTTPServer test

**Running Cob_Spec Locally**
___________________________

- git clone http://www.github.com/tcmcgee/cob_spec cob_spec
- cd cob_spec
- mvn package
- read README in cob_spec to run fitnesse server
OR
- java -jar fitnesse.jar -c "HttpTestSuite.ResponseTestSuite?suite&format=text"  to run the response suite in terminal

# built using toolchain: swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a 
