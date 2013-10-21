//
//  NSDictionary+Additions.h
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (NSString *)getURLParameterString;
- (NSDictionary *)filteredDictionaryWithKeys:(NSArray *)keyArray;
- (NSString *)returnJSONDictionary;

@end
