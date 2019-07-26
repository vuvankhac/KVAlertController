# KVAlertController

[![CI Status](https://img.shields.io/travis/Vu Van Khac/KVAlertController.svg?style=flat)](https://travis-ci.org/Vu Van Khac/KVAlertController)
[![Version](https://img.shields.io/cocoapods/v/KVAlertController.svg?style=flat)](https://cocoapods.org/pods/KVAlertController)
[![License](https://img.shields.io/cocoapods/l/KVAlertController.svg?style=flat)](https://cocoapods.org/pods/KVAlertController)
[![Platform](https://img.shields.io/cocoapods/p/KVAlertController.svg?style=flat)](https://cocoapods.org/pods/KVAlertController)

## Example

* Updating

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 10.0+
* Swift 5.0

## Installation

KVAlertController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KVAlertController', '~> 1.0.0'
```

Show default alert:
```swift
KVAlertController.shared.showIn(self, title: "KVAlertController", message: "My fullname is Vu Van Khac", cancelTitle: "CANCEL", cancelAction: {
    print("Cancel")
}, submitTitle: "OK", submitAction: {
    print("OK")
})
```

## Author

Vu Van Khac, khacvv0451@gmail.com

## License

KVAlertController is available under the MIT license. See the LICENSE file for more info.
