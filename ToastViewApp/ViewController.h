//
//  ViewController.h
//  ToastViewApp
//
//  Created by Rahul Gupta on 25/04/15.
//  Copyright (c) 2015 iSync India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *toastButton;
- (IBAction)showToast:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end