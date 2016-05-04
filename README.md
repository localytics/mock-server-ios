# MockServer

[![Version](https://img.shields.io/cocoapods/v/MockServer.svg?style=flat)](http://cocoapods.org/pods/MockServer)
[![License](https://img.shields.io/cocoapods/l/MockServer.svg?style=flat)](http://cocoapods.org/pods/MockServer)
[![Platform](https://img.shields.io/cocoapods/p/MockServer.svg?style=flat)](http://cocoapods.org/pods/MockServer)

MockServer is an HTTP Server that captures all requests it receives. Its primary use case is being embedded in a test app and capturing network traffic from your application for validation. In particular, if you consider one of the primary outputs of a product to be its network requests, MockServer can be used to black-box test the product. This can also be useful in a unit testing environment if you want to test a piece of network code while still using a real HTTP stack. As a real HTTP server, this tool also has a lot of potential around returning stub data to the product being tested.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first. Open the `MockServer.xcworkspace`. Select the `MockServer-Example` target and run unit tests. The usage of mock server is shown below. For more detailed examples check out the tests in the `MockServerTests` class. Note that MockServer only supports `http` requests, so `ATS` exceptions must be enabled on iOS 9 and greater

```objc
@import MockServer; // if using frameworks
#import <MockServer/MockServer.h> // if not using frameworks

// ...

// create and start the server
LLMockServer *server = [[LLMockServer alloc] init];
XCTAssert([server startServer]);

// pass the host and port the server is listening on to code being tested
[uut setAuthority:server.authority];

// do something that cause the code being tested to make a network request
[uut doSomethingOnTheNetwork];

// obtain the request from the server. If the payload is not yet available it will wait for a timeout before returning `nil`
HTTPMessage *message = [server getNextRequest];
XCTAssertNotNil(message);
XCTAssertEqualObjects([message ll_bodyString], expectedPayload);
```

In addition to the methods in `HTTPMessage+Parsing.h`, you can also take advantage of all the functionality of the `HTTPMessage` class in the [CocoaHTTPServer project](https://github.com/robbiehanson/CocoaHTTPServer).

## Installation

MockServer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MockServer"
```

## Next Steps

There is a lot of room for growth in the functionality this project offers, so any feedback on additional features or improvements to the current product are appreciated. Pull requests are welcome.

## Author

Char Software, Inc. d/b/a Localytics, support@localytics.com

## License

MockServer is available under the the The MIT License (MIT). See the LICENSE file for more info.
