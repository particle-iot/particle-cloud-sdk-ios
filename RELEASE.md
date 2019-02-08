## Releasing Particle-SDK Pod and Carthage update

1. Make sure you udpate changelog.md and podspec to include version you are about to release
2. Push latest to version to github
3. Create github release
4. Make sure pod is valid by running 'pod spec lint Particle-SDK.podspec --allow-warnings'
5. If pod is valid, publish pod by running 'pod trunk push Particle-SDK.podspec --allow-warnings'
6. If trunk fails, you might need to register your current session by running 'pod trunk register youremail@partice.io 'FirstName LastName' --description='MBP 2016'
