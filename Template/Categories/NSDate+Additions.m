//
//  NSDate+Additions.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+ (NSDate *) today {
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    date = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:date]];
    
    return date;
}

+ (NSString *)formatTodayForFoursquareVersioning {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dateFormatter setLocale:uslocale];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSDate *) midnight {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [dateFormatter setLocale:uslocale];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@, 12:00 AM", [self formatDate]]];
    
    return date;
}

- (NSDate *) roundToMultiplierOf:(int)multInMinute {
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSMinuteCalendarUnit fromDate:self];
    NSUInteger minute = [components minute];
    
    return [self dateByAddingTimeInterval:(multInMinute - (minute % multInMinute)) * 60];
}

- (NSDate *) dateByAddingTime:(NSString *)time {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [dateFormatter setLocale:uslocale];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@, %@", [self formatDate], time]];
    
    return date;
}

- (NSString *) formatDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dateFormatter setLocale:uslocale];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *) formatTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dateFormatter setLocale:uslocale];
    
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *) formatDateAndTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dateFormatter setLocale:uslocale];
    
    NSMutableString *stringRepr = [[NSMutableString alloc] init];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [stringRepr appendFormat:@"%@, ", [dateFormatter stringFromDate:self]];
    
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    
    [stringRepr appendFormat:@"%@", [dateFormatter stringFromDate:self]];
    
    return stringRepr;
}

- (NSString *)formatDateForBirthday {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"MM/dd/YYYY";
    
    return [formatter stringFromDate:self];
}

- (BOOL) isPast {
    
    return [self timeIntervalSinceDate:[NSDate date]] < 0;
}

- (BOOL) inBetween:(NSDate *)date andDuration:(int)minute {
    
    return ([self timeIntervalSinceDate:date] >= 0 && [self timeIntervalSinceDate:[date dateByAddingTimeInterval:minute * 60]] < 0);
}

@end
