//
//  Toast.m
//  ToastViewApp
//
//  Created by Rahul Gupta on 26/04/15.
//  Copyright (c) 2015 iSync India. All rights reserved.
//

#define ToastFontSize   16.0
#define ToastTextFont   [UIFont fontWithName:@"Helvetica Neue" size:16.0]
#define ToastShowDuration 1.0;
#define ToastHideDuration 2;

#import "Toast.h"
#import "AppDelegate.h"

@implementation Toast

static Toast *toast = nil;

+ (Toast*) getInstance
{
    @synchronized(self)
    {
        if (toast == nil)
        {
            toast = [[self alloc] init];
        }
        return toast;
    }
    return nil;
}

-(void) appearWithMessage :(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [self setFrameForMessage:message];
    [self addSubview:toastLabel];
    
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    [self fadeIn];
    [self fadeOut];
}

-(void) fadeIn
{
    [UIView beginAnimations: @"Fade In" context:nil];
    // wait for time before begin
    [UIView setAnimationDelay:0];
    // druation of animation
    [UIView setAnimationDuration:1.0];
    self.alpha = 1;
    [UIView commitAnimations];
}

-(void) fadeOut
{
    int duration = 2;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:duration animations:^{
            self.alpha = 0.0;
        }completion:^(BOOL finished){
            [self removeFromSuperview];
            [self removeFromSuperview];
        }];
    });
}

-(UILabel *) setFrameForMessage :(NSString *)message
{
    CGRect mainFrame = [UIScreen mainScreen].applicationFrame;
    toastLabel = [[UILabel alloc] init];
    [toastLabel setText:message];
    toastLabel.numberOfLines = 100;
    [toastLabel setTextAlignment:NSTextAlignmentLeft];
    toastLabel.adjustsFontSizeToFitWidth = NO;
    [toastLabel setAlpha:0.0];
    [toastLabel setBackgroundColor:[UIColor darkGrayColor]];
    [self setRoundWithLayer:toastLabel cornerRadius:4.0 borderWidth:0.4 borderColor:[UIColor darkGrayColor] maskBounds:YES];
    CGRect toastFrame = toastLabel.frame;
    toastFrame = [message textRectWithFontSize:ToastFontSize andMaxWidth:mainFrame.size.width - 20 andMaxHeight:200];
    toastFrame = [self calculateOriginForToast:toastFrame];
    [toastLabel setFrame:toastFrame];
    
    return toastLabel;
}

- (void) setRoundWithLayer:(UIView*) aLayer cornerRadius:(CGFloat) aRadius borderWidth:(CGFloat) aWidth borderColor:(UIColor*) aColor maskBounds:(BOOL) aBool
{
    // Round rect and border color
    [aLayer.layer setBorderColor: [aColor CGColor]];
    [aLayer.layer setBorderWidth: aWidth];
    [aLayer.layer setMasksToBounds:aBool];
    [aLayer.layer setCornerRadius:aRadius];
}

-(CGRect) calculateOriginForToast :(CGRect)toastFrame
{
    CGRect mainFrame = [UIScreen mainScreen].applicationFrame;
    CGFloat ww = toastFrame.size.width;
    CGFloat hh = toastFrame.size.height;
    CGRect aRect = CGRectMake(((mainFrame.size.width)-ww)/2, (mainFrame.size.height + hh) - 100, ww, hh);
    
    return aRect;
}

@end

@implementation NSString (StringHelperToast)

#pragma mark - For Text Rect
- (CGRect)textRectWithFontSize:(CGFloat)size andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight
{
    CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:size]};
    CGRect expectedLabelSize = [self boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    return expectedLabelSize;
}

@end
