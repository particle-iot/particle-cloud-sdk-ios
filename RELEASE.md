## Releasing Particle-SDK Pod and Carthage update

0. Make sure you are running latest version of cocoapods by running `sudo gem update cocoapods`
1. Make sure you udpate changelog.md and podspec to include version you are about to release
2. Push latest to version to github
3. Create github release & add release notes
4. Make sure pod is valid by running 'pod spec lint Particle-SDK.podspec --allow-warnings'
5. If pod is valid, publish pod by running 'pod trunk push Particle-SDK.podspec --allow-warnings'
6. If trunk fails, you might need to register your current session by running 'pod trunk register youremail@partice.io 'FirstName LastName' --description='MBP 2016'
