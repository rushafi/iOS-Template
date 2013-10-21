//
//  NSArray+Additions.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (NSString *)returnJSONArray {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
