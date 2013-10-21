//
//  NSString+Additions.h
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSDate *)            getDate;
- (NSDate *)            getBirthDate;
- (NSDate *)            getAccountCreationDate;
- (NSString *)          getMD5;
- (NSString *)          getSHA1String;
- (NSString *)          getURLEncodedStringWithCharacters:(NSString *)additionalCharacters;
- (NSComparisonResult)  compareAsTime:(NSString *)anotherTime;
- (CGFloat)             getHeightInCommentCell;

@end
