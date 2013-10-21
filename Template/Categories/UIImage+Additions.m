//
//  UIImage+Additions.m
//  Template
//
//  Created by Wasik Mursalin on 10/10/13.
//
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (UIImage *)cropImage:(CGRect)bound {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bound);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

- (UIImage *)getSquareImage {
    
    CGFloat dimension = (self.size.width <= self.size.height)? self.size.width: self.size.height;
    CGFloat diff, pos;
    
    if(self.size.width <= self.size.height) {
        
        dimension = self.size.width;
        diff = self.size.height - self.size.width;
        pos = .2 * diff;
        
        return [self cropImage:CGRectMake(0, pos, dimension, dimension)];
    }
    else {
        
        dimension = self.size.height;
        diff = self.size.width - self.size.height;
        pos = .2 * diff;
        
        return [self cropImage:CGRectMake(pos, 0, dimension, dimension)];
    }
}

- (UIImage *)getFittedImageinWidth:(CGFloat)width {
    
    CGFloat scale = width / self.size.width;
    CGFloat height = scale * self.size.height;
    
    CGRect newBound = CGRectMake(0, 0, width, height);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], newBound);
    UIImage *scaledImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return scaledImage;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)radians {
    
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
