# ASNet

A Swift-Baked Lightweight HTTP Networking Library in addition with the json parsing facility with the help of ObjectMapper. It frees you from the stress of json parsing - Every API call returns you an object or an array of objects. Less Coding - More Efficiency.


## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 3.0+


## Dependencies

The foremost reason is to call it a Lightweight Networking Library is that it's built on the core Swift Libraries except the JSON parsing thing. I have used ObjectMapper to map JSON data to User-Defined Model Objects.

* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) - The JSON to Object Mapping Library


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.3+ is required to build ASNet.

To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'ASNet', '~> 0.1.0'
end
```

Then, run the following command:

```bash
$ pod install
```


## Authors

**Amit Sen** - *The Whole Work* - [Ronstorm](https://github.com/ronstorm)


## License

This project is licensed under the Apache 2.0 License - see the [LICENSE.md](https://github.com/Medium/opensource/blob/master/apache-license-2.0.md) file for details


## Acknowledgments

* Thanks to [Hearst Digital Innovation Group (DIG)](https://github.com/Hearst-DD) for the huge help providing their library called [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper).
* Thanks to Stackoverflow to help me solve a lot of complex stuff while making this library.
* Thanks to the colleagues and friends I worked with for supporting me.
* Finally Thanks to Github.
