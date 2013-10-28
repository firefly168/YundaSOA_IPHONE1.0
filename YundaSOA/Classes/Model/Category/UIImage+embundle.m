//
//  UIImage+embundle.m
//  YundaSOA
//
//  Created by sam on 13-6-6.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import "UIImage+embundle.h"

@implementation UIImage (embundle)

BOOL isRetina()
{
	return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2);
}

+ (UIImage *)imageBundleNamed:(NSString *)imageName
{
    UIImage *image = nil;
    if (isRetina())
    {
        NSString *xImageName = nil;
        NSRange pointRange = [imageName rangeOfString:@"."];
        
        if (pointRange.location != NSNotFound)
        {
            xImageName = [NSString stringWithFormat:@"%@@2x.png",[imageName substringToIndex:pointRange.location]];
            //            NSLog(@"xImageName::%@",xImageName);
        }
        
        NSString *path = getMyBundlePath(xImageName);
        image =  [UIImage imageWithContentsOfFile:path];
        if (image)
        {
            return image;
        }
    }
    
    NSString *path = getMyBundlePath(imageName);
    image =  [UIImage imageWithContentsOfFile:path];
    
    return  image;
}

@end
