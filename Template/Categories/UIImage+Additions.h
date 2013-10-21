//
//  UIImage+Additions.h
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

- (UIImage *)cropImage:(CGRect)bound;
- (UIImage *)getSquareImage;
- (UIImage *)getFittedImageinWidth:(CGFloat)width;
- (UIImage *)imageRotatedByDegrees:(CGFloat)radians;

@end
