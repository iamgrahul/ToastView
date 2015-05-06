//
//  ViewController.m
//  ToastViewApp
//
//  Created by Rahul Gupta on 25/04/15.
//  Copyright (c) 2015 iSync India. All rights reserved.
//

#import "ViewController.h"
#import "ToastView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textField;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showToast:(UIButton *)sender
{
    [self.view endEditing:YES];
    [[ToastView getInstance] displayToastWithMessage:textField.text];
}

@end