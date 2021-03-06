## About

[![Build Status](https://img.shields.io/travis/0xced/XCDYouTubeKit/master.svg?style=flat)](https://travis-ci.org/0xced/XCDYouTubeKit)
[![Coverage Status](https://img.shields.io/coveralls/0xced/XCDYouTubeKit/master.svg?style=flat)](https://coveralls.io/r/0xced/XCDYouTubeKit?branch=master)
[![Platform](https://img.shields.io/cocoapods/p/XCDYouTubeKit.svg?style=flat)](http://cocoadocs.org/docsets/XCDYouTubeKit/)
[![Pod Version](https://img.shields.io/cocoapods/v/XCDYouTubeKit.svg?style=flat)](https://cocoapods.org/pods/XCDYouTubeKit)
[![Carthage Compatibility](https://img.shields.io/badge/carthage-✓-f2a77e.svg?style=flat)](https://github.com/Carthage/Carthage/)
[![License](https://img.shields.io/cocoapods/l/XCDYouTubeKit.svg?style=flat)](LICENSE)

**XCDYouTubeKit** is a YouTube video player for iOS and OS X.

<img src="Screenshots/XCDYouTubeVideoPlayerViewController.png" width="480" height="320">

Are you enjoying XCDYouTubeKit? You can say thank you with [a tweet](https://twitter.com/intent/tweet?text=%400xced%20Thank%20you%20for%20XCDYouTubeKit%2E). I am also accepting donations. ;-)

[![Donate button](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MGEPRSNQFMV3W)

## Requirements

- Runs on iOS 5.0 and later
- Runs on OS X 10.7 and later

## Warning

XCDYouTubeKit is against the YouTube [Terms of Service](https://www.youtube.com/t/terms). The only *official* way of playing a YouTube video inside an app is with a web view and the [iframe player API](https://developers.google.com/youtube/iframe_api_reference). Unfortunately, this is very slow and quite ugly, so I wrote this player to give users a better viewing experience.

## Installation

XCDYouTubeKit is available through CocoaPods and Carthage.

CocoaPods:
```ruby
pod "XCDYouTubeKit", "~> 2.2.0"
```

Carthage:
```objc
github "0xced/XCDYouTubeKit" ~> 2.2.0
```

Alternatively, you can manually use the provided static library on iOS or dynamic framework on OS X. In order to use the iOS static library, you must:

1. Create a workspace (File → New → Workspace…)
2. Add your project to the workspace
3. Add the XCDYouTubeKit project to the workspace
4. Drag and drop the `libXCDYouTubeKit.a` file referenced from XCDYouTubeKit → Products → libXCDYouTubeKit.a into the *Link Binary With Libraries* build phase of your app’s target.

These steps will ensure that `#import <XCDYouTubeKit/XCDYouTubeKit.h>` will work properly in your project.

**Warning**: If you use the iOS static library and you are targeting iOS 7, add the JavaScriptCore framework. If you are targeting iOS 5 or 6, you must add the following *Other Linker Flags* instead to your app:

```
-Wl,-U,_JSContextGetGlobalObject -Wl,-U,_JSEvaluateScript -Wl,-U,_JSGlobalContextCreate -Wl,-U,_JSGlobalContextRelease -Wl,-U,_JSObjectCallAsFunction -Wl,-U,_JSObjectIsFunction -Wl,-U,_JSObjectMake -Wl,-U,_JSObjectSetProperty -Wl,-U,_JSStringCopyCFString -Wl,-U,_JSStringCreateWithCFString -Wl,-U,_JSStringRelease -Wl,-U,_JSValueIsObject -Wl,-U,_JSValueIsString -Wl,-U,_JSValueMakeString -Wl,-U,_JSValueToStringCopy
```

See my [JavaScriptCore framework availability on iOS](http://stackoverflow.com/questions/23514579/javascriptcore-framework-availability-on-ios/23514580#23514580) answer on Stack Overflow for a complete explanation.


## Usage

XCDYouTubeKit is [fully documented](http://cocoadocs.org/docsets/XCDYouTubeKit/).

### iOS and OS X

```objc
NSString *videoIdentifier = @"EdeVaT-zZt4"; // A 11 characters YouTube video identifier
[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
	if (video)
	{
		// Do something with the `video` object
	}
	else
	{
		// Handle error
	}
}];
```

### iOS only

On iOS, you can use the class `XCDYouTubeVideoPlayerViewController` the same way you use a `MPMoviePlayerViewController`, except you initialize it with a YouTube video identifier instead of a content URL.

#### Present the video in full-screen

```objc
XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
```

#### Present the video in a non full-screen view

```objc
XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
[videoPlayerViewController presentInView:self.videoContainerView];
[videoPlayerViewController.moviePlayer play];
```

See the demo project for more sample code.

## Logging

Since version 2.2.0, XCDYouTubeKit produces logs. XCDYouTubeKit supports [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) but does not require it. If your project includes CocoaLumberjack, all logs will be routed through CocoaLumberjack, else logs will be emitted with `NSLog`.

The context for identifying all XCDYouTubeKit logs in CocoaLumberjack is the number `(NSInteger)0xced70676`. Beware, CocoaLumberjack contexts are NSIntegers, don’t forget the cast.

### Controlling log levels

If you are using CocoaLumberjack, you are responsible for controlling the log levels with the CocoaLumberjack APIs.

If you are not using CocoaLumberjack, you can control the log levels with the `XCDYouTubeKitLogLevel` environment variable. The log levels are the same as CocoaLumberjack, with the addition of the *trace* level.

Level   | Value
--------|------
Error   | 0x01
Warning | 0x02
Info    | 0x04
Debug   | 0x08
Verbose | 0x10
Trace   | 0x20
 
The levels are bitmasks, so you can combine them. For example, if you want to log *error*, *warning* and *info* levels, set the `XCDYouTubeKitLogLevel` environment variable to `0x7`.

If you do not set the `XCDYouTubeKitLogLevel` environment variable, only warning and error levels are logged.

## Credits

The URL extraction algorithms in *XCDYouTubeKit* are inspired by the [YouTube extractor](https://github.com/rg3/youtube-dl/blob/master/youtube_dl/extractor/youtube.py) module of the *youtube-dl* project.

## Contact

Cédric Luthi

- http://github.com/0xced
- http://twitter.com/0xced

## License

XCDYouTubeKit is available under the MIT license. See the [LICENSE](LICENSE) file for more information.
