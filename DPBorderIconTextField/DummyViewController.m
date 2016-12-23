//
//  DummyViewController.m
//  DPBorderIconTextField
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import "DummyViewController.h"
#import "DPBorderIconTextField.h"

@implementation DummyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.borderIconTextField.textFieldDelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
