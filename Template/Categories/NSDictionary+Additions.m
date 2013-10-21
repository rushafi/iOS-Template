//
//  NSDictionary+Additions.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "NSDictionary+Additions.h"
#import <Foundation/NSJSONSerialization.h>

@implementation NSDictionary (Additions)

- (NSString *)getURLParameterString {
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *retVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return retVal;
}

- (NSDictionary *)filteredDictionaryWithKeys:(NSArray *)keyArray {
    
    NSMutableDictionary *filteredDictionary = [NSMutableDictionary dictionary];
                                               
   for(NSString *key in keyArray) {
       
       [filteredDictionary setObject:[self objectForKey:key] forKey:key];
   }
                                               
   return filteredDictionary;
}

- (NSString *)returnJSONDictionary {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
