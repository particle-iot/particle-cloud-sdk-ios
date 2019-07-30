#Change Log
All notable changes to this project will be documented in this file.
Particle iOS Cloud SDK adheres to [Semantic Versioning](http://semver.org/).

---
## [0.9.7](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.7) (2019-07-30)

* Removed unused `networkState` property from `ParticleDevice`

* Added support for `networkId`, `networkRole`, `networkRoleState` (device roles need to be approved) properties

## [0.9.6](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.6) (2019-06-27)

* Added support for editing device notes and pinging the device

* Added support for custom ParticleCloud API base URL

* Added support for `ParticleDeviceSystemEventFlashFailed` event

!!! Potentially breaking change !!!
* Preciusly unused `version` property has been renamed to `systemFirmwareVersion` and now it contains DeviceOS version string.

## [0.9.5](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.5) (2019-04-12)

* Added support for endpoints related to SIM & credit card management used in 3rg generation device guided setup. 

## [0.9.4](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.4) (2019-03-05)

!!! Potentially breaking change !!!
* Call to `ParticleCloud.getDevices()` will no longer call `ParticleCloud.getDevice()` for every device that is reported as being online. To receive full device information, call `ParticleCloud.getDevice()` or `ParticleDevice.refresh()` on a device instance returned by `ParticleCloud.getDevices()`

## [0.9.3](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.3) (2019-02-25)

* Introduced 4th log level `Complete` that outputs very noisy data sources (such as getDevice API call)

## [0.9.2](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.2) (2019-02-11)

* Increased max length for function argument from 62 chars to 622 chars

## [0.9.1](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.1) (2019-02-08)

* Added support for 3rd generation SOM devices

* Added support for retrieving device platform ID from serial number

## [0.9.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.9.0) (2019-01-29)

* Added support for 3rd generation devices

* Fixed a crashing EventStreams bug

## [0.8.1](https://github.com/spark/spark-sdk-ios/releases/tag/0.8.1) (2018-08-03)

* Bug fixes

## [0.8.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.8.0) (2018-08-01)

* Added support for two-step verification

* Improved error reporting. `NSError.code` now contains HTTP status code. Added 2 values to userInfo dictionary. `ParticleSDKErrorResponseBodyKey` is the NSDictionary representation of JSON server response. `ParticleSDKErrorLocalizedStringKey` contains human readable error message.  `NSError.localizedDescription` is our best attempt to explain what happened in human readable language based on `ParticleSDKErrorLocalizedStringKey` and `NSError.code`.

* New library folder structure

* New example app

## [0.7.1](https://github.com/spark/spark-sdk-ios/releases/tag/0.7.1) (2018-06-24)

* BugFix: Replaced outdated and complicated keychain code with simplified version.

## [0.7.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.7.0) (2017-04-04)

* Overdue rename from Spark to Particle! SparkCloud is now ParticleCloud, same for ParticleDevice etc.

* Pod has been renamed from Spark-SDK to Particle-SDK. Spark-SDK pod has been deprecated.

* Documentation update

## [0.6.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.6.0) (2017-02-03)

* Updated: Product endpoints deprecates Org endpoints

* Added: Raspberry pi platform 31 support

* Added: accountInfo field to createUser (add optional first/last name, company name and business account info to every user signup)

* Bigfix: ParticleDevice.refresh() now does not nullify the delegate property

* Bigfix: Internal device maptable issue

* Bigfix: System events subscribe only when SDK has an active access token

* Added: Syntax changes for interoperability with Xcode 8 / Swift 3.0

* Bigfix: MBs Usage for Electron endpoint API response fix

## [0.5.1](https://github.com/spark/spark-sdk-ios/releases/tag/0.5.1) (2016-09-07)

* Bugfix: Functions (Array) and Variables (Dictionary) in a ParticleDevice instance will sometimes contain unknown type values for offline devices, this might cause problems with Swift - fixed.

* Added: Set both those fields to nonnull for better Swift interoperability.

## [0.5.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.5.0) (2016-07-21)

* Added: ParticleDevice API function: getCurrentDataUsage for Electron devices

* Added: ParticleDevice API function: Signal device (make on board LED shout rainbows)

* Added: ParticleDeviceDelegate protocol - allow SDK user to register for device system events (offline/online/flashing etc)

* Bugfix: Critical event subsystem bugfixes

* Added: Additional supported device types (P1, RedBear, Bluz, etc)

* Added: Support for additional ParticleDevice properties (ICCID, IMEI, status, platformId, productId, lastIPAddress)

* Added: Automatically Determine device type (family) through platform_id

* Bugfix: Correctly encode organization and product names in request URL

* Bugfix: FlashFiles API now works

* Removed: systemFirmwareVersion property for ParticleDevice

* Updated: Documentation

## [0.4.1](https://github.com/spark/spark-sdk-ios/releases/tag/0.4.1) (2016-03-29)

* Fix a bug with password reset API endpoint

* Added support for injecting Session access tokens for two legged auth

* SDK no longer saves user password in keychain

* SDK will now try to auto refresh expired access token using the OAuth "refresh token"

* Merged the ParticleUser and ParticleAccessToken classes into one ParticleSession class

## [0.4.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.4.0) (2016-03-02)

* Nullability support for even better Swift interoperability. No more implicitly unwrapped arguments in Swift from SDK callbacks!

* Carthage dependency manager support! SDK can now be added as a dynamic framework to ease pain when integrating with Swift dependencies.

* AFNetworking 3.0 support - SDK now returns NSURLSessionDataTask object from every network operation function.

## [0.3.4](https://github.com/spark/spark-sdk-ios/releases/tag/0.3.4) (2015-12-15)

* SDK now knows about Particle Electrons!

* Force AFNetworking pod version to 2.x.x to until migration to 3.x.x requirements is complete

## [0.3.3](https://github.com/spark/spark-sdk-ios/releases/tag/0.3.3) (2015-07-22)

* Fix crash in case error object is nil across cloud SDK functions failure blocks

* Get rid of compiler warnings

## [0.3.2](https://github.com/spark/spark-sdk-ios/releases/tag/0.3.2) (2015-07-22)

* README documentation for OAuth credentials

* Signup customers/password reset for user

* Detailed error logging from cloud SDK functions

## [0.3.1](https://github.com/spark/spark-sdk-ios/releases/tag/0.3.1) (2015-07-22)

* document generateClaimCodeForOrganization func

* isLoggedin flag

* remove OAuth credentials plist file in favor of new class variables (used to 'feed' client/secret to ParticleCloud class)

* README fixes, CHANGELOG added

## [0.3.0](https://github.com/spark/spark-sdk-ios/releases/tag/0.3.0) (2015-07-22)

* Events pub/sub system added to the Cloud SDK - see [here](https://github.com/spark/spark-sdk-ios/blob/master/README.md#events-sub-system)

* Continous integration in [Travis-CI](https://travis-ci.org/spark/spark-sdk-ios).

* Unit tests added.

## [0.2.10](https://github.com/spark/spark-sdk-ios/releases/tag/0.2.10) (2015-06-05)

* Add flash files to device API call (flashFiles:)

* Add flash known firmware images to device API call (flashKnownApp:)

* Internal isFlashing timer

## [0.2.9](https://github.com/spark/spark-sdk-ios/releases/tag/0.2.9) (2015-05-20)

* License fix on podspec

## [0.2.8](https://github.com/spark/spark-sdk-ios/releases/tag/0.2.8) (2015-05-20)

* License updated to Apache 2.0

* Documentation update

## [0.2.7](https://github.com/spark/spark-sdk-ios/releases/tag/0.2.7) (2015-05-12)

* Bug fix bad getDevice API call

## [0.2.6](https://github.com/spark/spark-sdk-ios/releases/tag/0.2.6) (2015-05-06)

* Added device type field to ParticleDevice

* Bug fix rename device API call

## [0.2.5](https://github.com/spark/spark-sdk-ios/releases/tag/0.2.5) (2015-05-04)

* Device refresh API call available

* getDevice API call passes access token as URL parameter
