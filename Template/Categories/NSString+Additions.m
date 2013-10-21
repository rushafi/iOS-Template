//
//  NSString+Additions.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additions)

- (NSDate *)getDate {
    
    return [NSDate date];
}

- (NSDate *)getBirthDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
	return [dateFormatter dateFromString:self];
}

- (NSDate *)getAccountCreationDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"MM/dd/yyyy mm:ss"];
    
    return [dateFormatter dateFromString:self];
}

- (NSString *)getMD5 {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (NSString *)getSHA1String {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(cStr, strlen(cStr), digest); // This is the SHA1 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (NSString *)getURLEncodedStringWithCharacters:(NSString *)characters {
    
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)characters, kCFStringEncodingUTF8);
}

- (NSComparisonResult)compareAsTime:(NSString *)anotherTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSMutableString *basicDate = [[NSMutableString alloc] init];
    [basicDate appendFormat:@"Feb 28, 2013, "];
    
    NSDate *reciever = [dateFormatter dateFromString:[NSString stringWithFormat:@"Feb 28, 2013, %@", self]];
    NSDate *sender = [dateFormatter dateFromString:[NSString stringWithFormat:@"Feb 28, 2013, %@", anotherTime]];
    
    return [reciever timeIntervalSinceDate:sender] > 0;
}

- (CGFloat)getHeightInCommentCell {
    
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    
    return [self sizeWithFont:font constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height;
}

@end
