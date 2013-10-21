//
//  NSData+Additions.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "NSData+Additions.h"
#import <Foundation/NSJSONSerialization.h>

@implementation NSData (Additions)

- (NSMutableDictionary *)getDeserializedDictionary {
    
    NSError *error = nil;
    NSMutableDictionary *ret = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    
    return ret;
}

- (NSArray *)getDeserializedArray {
    
    NSError *error = nil;
    NSArray *ret = (NSArray *)[NSJSONSerialization JSONObjectWithData:self options:0 error:&error];
    
    return ret;
}

- (id)deserialize {
    
    NSError *error = nil;
    id object = (id)[NSJSONSerialization JSONObjectWithData:self options:0 error:&error];
    
    return object;
}

@end
