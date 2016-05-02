//
//  MockServerTests.m
//  Copyright (C) 2016 Localytics
//
//  This code is provided under the The MIT License (MIT).
//  A copy of this license has been distributed in a file called LICENSE
//  with this source code.
//
// Please visit www.localytics.com for more information.
//

@import XCTest;
@import MockServer;

@interface MockServerTests : XCTestCase

@end

@implementation MockServerTests
{
    LLMockServer *server;
}

- (void)setUp
{
    [super setUp];
    
    server = [[LLMockServer alloc] init];
    XCTAssert([server startServer]);
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSString *payload = @"test payload";
    [self uploadWithBody:[payload dataUsingEncoding:NSUTF8StringEncoding]];
    
    HTTPMessage *message = [server getNextRequest];
    XCTAssertNotNil(message);
    XCTAssertEqualObjects([message ll_bodyString], payload);
}

- (void)testJSON
{
    NSDictionary *json = @{
                           @"field_1": @1,
                           @"field_2": @"some value",
                           @"field_3": @[@1, @2, @3]
                           };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:0
                                                         error:&error];
    XCTAssertNil(error);
    
    [self uploadWithBody:jsonData];
    HTTPMessage *message = [server getNextRequest];
    XCTAssertNotNil(message);
    
    error = nil;
    id receivedJSON = [message ll_bodyJsonWithError:&error];
    XCTAssertNotNil(receivedJSON);
    XCTAssertEqualObjects(receivedJSON, json);
}

- (void)testHeaderFieldsAndPath
{
    NSString *payload = @"test payload";
    NSString *path = @"/a/path/for/testing/paths";
    NSString *url = [NSString stringWithFormat:@"http://%@%@", server.authority, path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    [request addValue:@"first value" forHTTPHeaderField:@"first field"];
    [request addValue:@"second value" forHTTPHeaderField:@"second field"];
    [self uploadWithBody:[payload dataUsingEncoding:NSUTF8StringEncoding] request:request];
    
    HTTPMessage *message = [server getNextRequest];
    XCTAssertNotNil(message);
    XCTAssertEqualObjects(message.url.path, path);
    XCTAssertEqualObjects([message headerField:@"first field"], @"first value");
    XCTAssertEqualObjects([message headerField:@"second field"], @"second value");
}

- (void)uploadWithBody:(NSData *)body request:(NSURLRequest *)request
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"network request"];
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request
                                                fromData:body
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                           [expectation fulfill];
                                       }] resume];
    
    [self waitForExpectationsWithTimeout:5
                                 handler:nil];
}

- (void)uploadWithBody:(NSData *)body
{
    NSString *url = [NSString stringWithFormat:@"http://%@/test/path", server.authority];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST";
    [self uploadWithBody:body request:request];
    
}

@end

