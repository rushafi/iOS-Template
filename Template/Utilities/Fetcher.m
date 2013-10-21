//
//  Fetcher.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "Fetcher.h"

#define urlCharactersToBeEncoded @"!*'();@$,%#[]"
#define urlDataCharactersToBeEncoded @"!*'();@$,%#[]+"

@implementation Fetcher

@synthesize url;
@synthesize tag;
@synthesize delegate;

#pragma mark - setup methods

- (id)initWithURL:(NSString *)_url andDelegate:(id)_delegate {
    
    if(self = [super init]) {
        
        url = [self getURLEncodedStringWithCharacters:urlCharactersToBeEncoded forString:_url];
        
        delegate    = _delegate;
        
        cachePolicy = NSURLRequestUseProtocolCachePolicy;
        timeout     = 20.0;
    }
    
    return self;
}

- (void)setTimeout:(NSTimeInterval)_timeout {
    
    timeout = _timeout;
}

- (void)overrideCachingMethod:(NSURLRequestCachePolicy)_cachePolicy {
    
    cachePolicy = _cachePolicy;
}

- (void)disableCaching {
    
    cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
}

#pragma mark - fetch methods

- (void)get {
    
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = cachePolicy;
    request.HTTPMethod = @"GET";
    request.timeoutInterval = timeout;
    
    [self initConnection];
    [self startRequest];
}

- (void)post:(NSDictionary *)parameters {
    
    NSMutableData *postData = [[NSMutableData alloc] init];
    
    NSString *firstkey  = [[parameters allKeys] objectAtIndex:0];
    
    for(NSString *key in [parameters allKeys]) {
        
        if(![key isEqualToString:firstkey] && ![key isEqualToString:@"profilepic"]) {
            
            [postData appendData:[@"&" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        id object = [parameters objectForKey:key];
        
        if([object isKindOfClass:[NSString class]]) {
            
            NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, (NSString *)object];
            
            [postData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        else if([object isKindOfClass:[NSArray class]]) {
            
            for(int i = 0; i < [(NSArray *)object count]; i++) {
                
                if(i) [postData appendData:[@"&" dataUsingEncoding:NSUTF8StringEncoding]];
                
                NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, [(NSArray *)object objectAtIndex:i]];
                
                [postData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        else if([object isKindOfClass:[NSDictionary class]]) {
            
            NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, [self returnJSONForDictionary:(NSDictionary *)object]];
            
            [postData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([object isKindOfClass:[NSNumber class]]) {
            
            NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, [(NSNumber *)object stringValue]];
            
            [postData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else {
            
            NSLog(@"%@", key);
        }
    }
    
    if(postData) {
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.cachePolicy = cachePolicy;
        request.HTTPMethod = @"POST";
        request.timeoutInterval = timeout;
        request.HTTPBody = postData;
        
        [self initConnection];
        [self startRequest];
    }
    else {
        
        // raise exception
    }
}

- (void)put:(NSDictionary *)parameters {
    
    NSMutableData *putData = [[NSMutableData alloc] init];
    
    NSString *firstkey  = [[parameters allKeys] objectAtIndex:0];
    
    for(NSString *key in [parameters allKeys]) {
        
        if(![key isEqualToString:firstkey] && ![key isEqualToString:@"photo"]) {
            
            [putData appendData:[@"&" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        id object = [parameters objectForKey:key];
        
        if([object isKindOfClass:[NSString class]]) {
            
            NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, (NSString *)object];
            
            [putData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([object isKindOfClass:[NSArray class]]) {
            
            for(int i = 0; i < [(NSArray *)object count]; i++) {
                
                if(i) [putData appendData:[@"&" dataUsingEncoding:NSUTF8StringEncoding]];
                
                NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, [(NSArray *)object objectAtIndex:i]];
                
                [putData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        else if([object isKindOfClass:[NSDictionary class]]) {
            
            NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, [self returnJSONForDictionary:(NSDictionary *)object]];
            
            [putData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([object isKindOfClass:[NSNumber class]]) {
            
            NSString *postPart = [NSString stringWithFormat:@"%@=%@", key, [(NSNumber *)object stringValue]];
            
            [putData appendData:[[self getURLEncodedStringWithCharacters:urlDataCharactersToBeEncoded forString:postPart] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    if(putData) {
        
        NSString *putString = [[NSString alloc] initWithData:putData encoding:NSUTF8StringEncoding];
        
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, putString]]];
        request.cachePolicy = cachePolicy;
        request.HTTPMethod = @"PUT";
        request.timeoutInterval = timeout;
        
        [self initConnection];
        [self startRequest];
    }
    else {
        
        // raise exception
    }
}

- (void)delete {
    
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    request.HTTPMethod = @"DELETE";
    request.timeoutInterval = timeout;
    
    [self initConnection];
    [self startRequest];
}

- (void)postImage:(UIImage *)image WithKey:(NSString *)key {
    
    NSMutableData *postData = [[NSMutableData alloc] init];
    
    // define boundary
    NSString *boundary = @"14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    NSData *imageData;
    double quality = 0.067;
    
    imageData = UIImageJPEGRepresentation((UIImage *)image, quality);
    
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpeg\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:imageData];
    
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = cachePolicy;
    request.HTTPMethod = @"POST";
    request.timeoutInterval = timeout;
    request.HTTPBody = postData;
        
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [self initConnection];
    [self startRequest];
}

#pragma mark - stop methods

- (void)stop {
    
    [connection cancel];
    data = nil;
}

#pragma mark - utility methods

- (NSString *)getURLEncodedStringWithCharacters:(NSString *)characters forString:(NSString *)string {
    
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, (CFStringRef)characters, kCFStringEncodingUTF8);
}

- (NSString *)returnJSONForDictionary:(NSDictionary *)dictionary {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

#pragma mark - private methods

- (void)initConnection {
    
    data = [[NSMutableData alloc] init];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
}

- (void)startRequest {
    
    [connection start];
}

#pragma mark - NSURLConnection Delegates

- (void)connection:(NSURLConnection *)_connection didReceiveResponse:(NSURLResponse *)_response {
    
    statusCode = [(NSHTTPURLResponse *)_response statusCode];
}

- (void)connection:(NSURLConnection *)_connection didReceiveData:(NSData *)_data {
    
	[data appendData:_data];
}

- (void)connection:(NSURLConnection *)_connection didFailWithError:(NSError *)error {
    
	NSLog(@"Connection Failed with error: %@ %@",[error localizedDescription],
		  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
	
    [delegate fetcher:self fetchedResponse:nil withError:error andStatusCode:statusCode];
    
	data = nil;
	connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)_connection {
    
    [delegate fetcher:self fetchedResponse:(NSData *)data withError:nil andStatusCode:statusCode];
    
	connection = nil;
	data = nil;
}

@end
