xcodebuild -toolchain swift -configuration Release
./build/Release/SwiftHTTPServer -p 5000 -d ./cob_spec/public -l ./logs
