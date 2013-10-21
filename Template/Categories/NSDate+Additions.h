//
//  NSDate+Additions.h
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (NSDate *)    today;
+ (NSString *)  formatTodayForFoursquareVersioning;

- (NSDate *)    midnight;
- (NSDate *)    roundToMultiplierOf:(int)multInMinute;
- (NSDate *)    dateByAddingTime:(NSString *)time;

- (NSString *)  formatDate;
- (NSString *)  formatTime;
- (NSString *)  formatDateAndTime;
- (NSString *)  formatDateForBirthday;

- (BOOL)        isPast;
- (BOOL)        inBetween:(NSDate *)date andDuration:(int)minute;

@end
