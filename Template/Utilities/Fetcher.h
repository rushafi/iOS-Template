//
//  Fetcher.h
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import <Foundation/Foundation.h>

@class Fetcher;

@protocol FetcherDelegate <NSObject>

- (void)fetcher:(Fetcher *)fetcher fetchedResponse:(NSData *)data withError:(NSError *)error andStatusCode:(NSInteger)statusCode;

@end

@interface Fetcher : NSObject {
    
    NSMutableData *data;
    NSURLConnection *connection;
    NSMutableURLRequest *request;
    NSURLRequestCachePolicy cachePolicy;
    NSTimeInterval timeout;
    NSInteger statusCode;
}

// public properties

@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, readwrite)        NSInteger tag;
@property (nonatomic, weak)             id<FetcherDelegate> delegate;

// setup methods

- (id)initWithURL:(NSString *)_url andDelegate:(id)_delegate;
- (void)setTimeout:(NSTimeInterval)timeout;
- (void)overrideCachingMethod:(NSURLRequestCachePolicy)cachePolicy;
- (void)disableCaching;

// fetch methods

- (void)get;
- (void)post:(NSDictionary *)parameters;
- (void)put:(NSDictionary *)parameters;
- (void)delete;

- (void)postImage:(UIImage *)image WithKey:(NSString *)key;

// stop methods

- (void)stop;



@end
