//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

#import <XCDYouTubeKit/XCDYouTubeClient.h>

@interface XCDYouTubeProtectedVideosTestCase : XCDYouTubeKitTestCase
@end

@implementation XCDYouTubeProtectedVideosTestCase

- (void) testProtectedVEVOVideo
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"rId6PKlDXeU" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNotNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop) {
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

- (void) testProtectedVideoWithDollarSignature
{
	TRVSMonitor *monitor = [TRVSMonitor monitor];
	[[XCDYouTubeClient defaultClient] getVideoWithIdentifier:@"Pgum6OT_VH8" completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
		XCTAssertNil(error);
		XCTAssertNotNil(video.title);
		XCTAssertNotNil(video.smallThumbnailURL);
		XCTAssertNotNil(video.mediumThumbnailURL);
		XCTAssertNil(video.largeThumbnailURL);
		XCTAssertTrue(video.streamURLs.count > 0);
		XCTAssertTrue(video.duration > 0);
		[video.streamURLs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSURL *streamURL, BOOL *stop) {
			XCTAssertTrue([streamURL.query rangeOfString:@"signature="].location != NSNotFound);
		}];
		[monitor signal];
	}];
	XCTAssertTrue([monitor waitWithTimeout:10]);
}

@end