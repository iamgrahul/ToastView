//
//  Toast.h
//  ToastViewApp
//
//  Created by Rahul Gupta on 26/04/15.
//  Copyright (c) 2015 iSync India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toast : UIView
{
    UILabel *toastLabel;
}
+ (Toast*) getInstance;
-(void) appearWithMessage :(NSString *)mgs;

@end

@interface NSString (StringHelperToast)

- (CGRect)textRectWithFontSize:(CGFloat)size andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;

@end