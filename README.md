# ASNet

A Swift-Baked Lightweight HTTP Networking Library in addition with the json parsing facility with the help of ObjectMapper. It frees you from the stress of json parsing - Every API call returns you an object or an array of objects. Less Coding - More Efficiency.


## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 3.0+


## Dependencies

The foremost reason is to call it a Lightweight Networking Library is that it's built on the core Swift Libraries except the JSON parsing thing. I have used ObjectMapper to map JSON data to User-Defined Model Objects. One more Library is Reachability. This library will check if the host is reachable or not and moreover if it's reachable through Wifi or Cellular Data.

* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) - The JSON to Object Mapping Library
* [Reachability.swift](https://github.com/ashleymills/Reachability.swift) - Reachability.swift is a replacement for Apple's Reachability sample, re-written in Swift with closures.


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
pod 'ASNet', '~> 0.1.5'
end
```

Then, run the following command:

```bash
$ pod install
```

## Updates in new version

There are Two major updates in this version.
- Add Custom Header (HTTPHeader)
- Loading Image from URL


## Usage

### Initialize

```Swift
import ASNet

ASNet.shared.initialize(withHost: "www.google.com", andBaseURL: "https://www.google.com")
```

The host parameter is to check if the host domain is reachable or not. And the baseURL is for the common partial url that's going to be used ahead of all the api calls in a single app. You can initialize it in AppDelegate and then use it throughout the whole app.

### Sample Request

There are only two methods to request to the Rest API and getting response
* One for Json Object Response
* The other for Json Array Response

#### Json Object Response

```Swift
import ASNet

// For Object Response
asNet.fetchAPIDataWithJsonObjectResponse(endpointURL: apiUrl, httpMethod: .get, httpHeader: nil, parameters: nil, isMultiPart: false, filesWhenMultipart: nil, returningType: Lead.self) { (result) in

    switch result {
    case .success(let lead, let json):
        // lead is an object of Lead model.
        // json is the the json response of the request. this response is not needed unless you want to do something special with this. The library is parsing your data itself and returning you the object of the class type you are sending through parameters you want.
        break
    case .error(let errorTitle, let errorText):
        // you can edit this errortitle and errortext.
        break
    }
}
```

#### Json Array Response

```Swift
import ASNet

// for array response
asNet.fetchAPIDataWithJsonArrayResponse(endpointURL: apiUrl, httpMethod: .get, httpHeader: nil, parameters: nil, isMultiPart: false, filesWhenMultipart: nil, returningType: Lead.self) { (result) in

    switch result {
    case .success(let leads, let json):
        // leads is an array of Lead model Objects.
        // json is the the json response of the request. this response is not needed unless you want to do something special with this. The library is parsing your data itself and returning you the array of object of the class type you are sending through parameters you want.
        break
    case .error(let errorTitle, let errorText):
        // you can edit this errortitle and errortext.
        break
    }
}
```

### Parameters in Depth

- **Endpoint URL -** The parameter name defines it pretty well. This is the endpoint url we are gonna append with the base url.
- **Http Method -** It's pretty straightforward as well. You can make a post or get call by choosing one. It's an Enum that's defined as follows -
```Swift
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
```
- **HTTPHeader -** It's a `nullable` (You can send nil instead of empty dictionary) Dictionary to send parameters - either in json or in post form pattern.
```Swift
public typealias HTTPHeader = [String: String]
```
- **Parameters -** It's a `nullable` (You can send nil instead of empty dictionary) Dictionary to send parameters - either in json or in post form pattern.
```Swift
public typealias Parameters = [String: Any]
```
- **isMultiPart -** It's boolean argument to indicate if the request includes any multipart file to send or not. It's false by default.
- **filesWhenMultipart -** It's a parameter of `ImageFileArray` type. ImageFileArray is an array of `ImageFile` type. If you have to send one or more images, you have to make an array of ImageFile type as follows -
```Swift
var imageFileList: ImageFileArray = []
let imageFile:  = ImageFile(image: profieImageView.image!, fileKey: "photo", fileName: "profile_image", mimeType: .jpg)
imageFileList.append(imageFile)
// append as many ImageFile as you want and then send it through filesWhenMultipart in the methods.
```
`ImageFile` has some more supporting objects. Those are as follows -
```Swift
public typealias ImageFileArray = [ImageFile]

open class ImageFile: NSObject {
    public var imageData: Data
    public var fileKey: String
    public var fileName: String
    public var mimeType: MimeType

    public init?(image: UIImage, fileKey: String, fileName: String, mimeType: MimeType) {

        self.fileKey = fileKey
        self.fileName = fileName
        self.mimeType = mimeType

        switch mimeType {
        case .jpg:
            guard let data = UIImageJPEGRepresentation(image, 0.7) else { return nil
            }
            self.imageData = data
            break
        case .png:
            guard let data = UIImagePNGRepresentation(image) else {
            return nil
            }
            self.imageData = data
            break
        }

        super.init()
    }
}
```
```Swift
public enum MimeType: String {
    case jpg = "image/jpg"
    case png = "image/png"
}
```
- **returningType -** Here comes the necessity of ObjectMapper. To use this library you have to let your model class inherit from the class Mappable (From ObjectMapper). My library will automatically map the response json result to your desired model object. I am providing a simple example here -
```Json
    [
        {
            "id": 1,
            "title": "English"
        },
        {
            "id": 2,
            "title": "Chinese"
        },
        {
            "id": 3,
            "title": "Malay"
        },
        {
            "id": 4,
            "title": "Hindi"
        },
        {
            "id": 5,
            "title": "Tamil"
        },
        {
            "id": 6,
            "title": "Korean"
        },
        {
            "id": 7,
            "title": "Japanese"
        }
    ]
```
To parse the json above you need to write a model as follows -
```Swift
import ObjectMapper

class Language: Mappable {
    private struct Key {
        let id_key = "id"
        let title_key = "title"
    }

    internal var id: Int?
    internal var title: String?

    required internal init(map: Map) {
        mapping(map: map)
    }

    internal func mapping(map: Map) {
        let key = Key.init()

        id <- map[key.id_key]
        title <- map[key.title_key]
    }
}
```
Now call either of the api methods discussed above according to your need.

You must have the query about the `result` thingy inside the closure of the method. Right? Actually it's an Enum that helps to accumulate the Successful and Failed response in a single object.
```Swift
public enum JsonObjectResult<T> {
    case success(T, Any)
    case error(String, String)
}
```
```Swift
public enum JsonArrayResult<T> {
    case success([T], Any)
    case error(String, String)
}
```

### Load Image from Image URL

You can load images from url through this library as well.
```Swift
import ASNet

// To get an image from url
asNet.loadImage(fromUrl: imageUrl, usingCache: true, onSuccess: { (image) in
// do whatever you want with the image

}, onError: {
// Error downloading image. Show any alert or something.

})
```
You have to make usingCache true if you need it to get from the cache. That's it. Pretty straightforward!


### Some More Customizable Stuff

#### TimeOut Interval
You can change the TimeOut Interval for a request.
```Swift
import ASNet

ASNet.shared.networkService.timeoutIntervalForRequest = 60
```
#### Error Texts
```Swift
open class ASNetErrorTexts {
    public var requestErrorTitle = "Bad Request!"
    public var responseErrorTitle = "Parse Error!"
    public var serverErrorTitle = "Server Error!"
    public var networkErrorTitle = "Network Error!"
    public var timeoutErrorTitle = "Network Error!"
    public var customErrorTitle = "Error!"
    public var parsingErrorTitle = "Parsing Error!"

    public var requestErrorText = "Please, check your request parameters!"
    public var responseErrorText = "Something went wrong with parsing response data!"
    public var serverErrorText = "Something went wrong on the Server Side."
    public var networkErrorText = "Network is not connected!"
    public var timeoutErrorText = "Request timed out! Please check your internet connection!"
    public var parsingErrorText = "Data parsing failed because of invalid format!"

    public init() {

    }
}
```
You can change the Error Texts that you are getting through the result object.
```Swift
import ASNet

ASNet.shared.networkService.errorTexts.customErrorTitle = "Yo! It's a custom error title!"
```

## Upcoming Versions

There are a lot to improve in this library. It's just the beginning. The upcoming version will have the facility of sending headers through the methods. Keep your eyes on that. Keep exploring this version till then.


## Author

**Amit Sen** - *The Whole Work* - [Ronstorm](https://github.com/ronstorm)


## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/ronstorm/ASNet/blob/master/LICENSE) file for details


## Acknowledgments

* Thanks to [Hearst Digital Innovation Group (DIG)](https://github.com/Hearst-DD) for the huge help providing their library called [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper).
* Thanks to Stackoverflow to help me solve a lot of complex stuff while making this library.
* Thanks to the colleagues and friends I worked with for supporting me.
* Finally Thanks to Github.
