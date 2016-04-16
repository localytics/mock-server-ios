//
//  MockServerTests.m
//  MockServerTests
//
//  Created by Matthew Patey on 04/16/2016.
//  Copyright (c) 2016 Matthew Patey. All rights reserved.
//

@import XCTest;
@import MockServer;

@interface MockServerTests : XCTestCase

@end

@implementation MockServerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    LLMockServer *server = [[LLMockServer alloc] init];
    XCTAssert([server startServer]);
    NSString *authority = [NSString stringWithFormat:@"http://%@:%lu/test/path", server.host, (unsigned long) server.port];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:authority]];
    request.HTTPMethod = @"POST";
    NSString *payload = @"test payload";
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"network request"];
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request
                                                fromData:[payload dataUsingEncoding:NSUTF8StringEncoding]
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                           [expectation fulfill];
                                       }] resume];
    
    [self waitForExpectationsWithTimeout:5
                                 handler:nil];
    HTTPMessage *message = [server getNextRequest];
    XCTAssertNotNil(message);
    XCTAssertEqualObjects([message bodyString], payload);
}

@end

