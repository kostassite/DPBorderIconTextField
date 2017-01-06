//
//  DPBorderIconTextFieldPasswordTests.m
//  DPBorderIconTextField
//
//  Created by Kostas on 5/1/17.
//  Copyright © 2017 Kostas Antonopoulos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DPBorderIconTextField.h"
#import "OCMock.h"

@interface DPBorderIconTextFieldPasswordTests : XCTestCase{
    DPBorderIconTextField<UITextFieldDelegate> *borderIconTextField;
    UIImage *showPassIcon;
    UIImage *hidePassIcon;
    
    UIImage *iconMock;
}

@end

@implementation DPBorderIconTextFieldPasswordTests

- (void)setUp {
    [super setUp];

    showPassIcon = OCMClassMock([UIImage class]);
    hidePassIcon = OCMClassMock([UIImage class]);
    
    iconMock = OCMClassMock([UIImage class]);

    borderIconTextField = OCMPartialMock((DPBorderIconTextField<UITextFieldDelegate> *)[[DPBorderIconTextField alloc]initWithFrame:CGRectMake(0, 0, 100, 50)]);
}

- (void)tearDown {
    borderIconTextField = nil;
    showPassIcon = nil;
    hidePassIcon = nil;
    
    iconMock = nil;
    
    [super tearDown];
}

-(void)testThatSetShowPasswordIconSetShowPasswordIconWithButtonWithAlwaysMode{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];

    [borderIconTextField setShowPasswordIcon:showPassIcon];
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:showPassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatSetShowPasswordIconSetAlsoTheSetSecureTextField{
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    OCMVerify([borderIconTextField setSecureTextEntry:YES]);
}

-(void)testThatSetHidePasswordIconWorksAndNotSettingsAnything{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setHidePasswordIcon:hidePassIcon];

    OCMReject([tf setRightView:[OCMArg any]]);
}

-(void)testThatToggleShowPasswordTogglesTheIconsAndSetsThemAsButtons{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];

    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];

    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:showPassIcon],@"Right View should have the showPassIcon as image of the button");
    [borderIconTextField toggleShowPassword];
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:hidePassIcon],@"Right View should have the hidePassIcon as image of the button");
    [borderIconTextField toggleShowPassword];
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:showPassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatToggleShowPasswordTogglesPasswordSecureText{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    
    XCTAssertTrue(tf.isSecureTextEntry,@"Should start as secure");
    [borderIconTextField toggleShowPassword];
    XCTAssertTrue(!tf.isSecureTextEntry,@"Should toggle to not secure");
    [borderIconTextField toggleShowPassword];
    XCTAssertTrue(tf.isSecureTextEntry,@"Should toggle to secure");
}

-(void)testThatSetSecureTextEntrySetTheTextFieldsProperty{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    XCTAssertFalse(tf.isSecureTextEntry);
    [borderIconTextField setSecureTextEntry:YES];
    XCTAssertTrue(tf.isSecureTextEntry);
}

-(void)testThatShowValidatedSucceedYesShowsTheValidatedIconWhileNotEditingWhenHaveShowPassIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    [borderIconTextField setValidatedIcon:iconMock];
    [borderIconTextField setUnvalidatedIcon:iconMock];
    [borderIconTextField showValidationSucceed:YES];

    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:iconMock],@"Right View should have the iconMock");
}

-(void)testThatClearValidationStateShowsShowPassIconWhenIsSecureTextEntryAndHasIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    [borderIconTextField setValidatedIcon:iconMock];
    [borderIconTextField setUnvalidatedIcon:iconMock];
    [borderIconTextField showValidationSucceed:NO];
    [borderIconTextField clearValidationState];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:showPassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatClearValidationStateShowsHidePassIconWhenIsNotSecureTextEntryAndHasIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    [borderIconTextField setValidatedIcon:iconMock];
    [borderIconTextField setUnvalidatedIcon:iconMock];
    [borderIconTextField toggleShowPassword];
    [borderIconTextField showValidationSucceed:NO];
    [borderIconTextField clearValidationState];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:hidePassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatWhenValidatedAndStartEditingShowsShowPassIconWhenIsSecureTextEntryAndHasIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    [borderIconTextField setValidatedIcon:iconMock];
    [borderIconTextField setUnvalidatedIcon:iconMock];
    [borderIconTextField showValidationSucceed:NO];
    [borderIconTextField textFieldDidBeginEditing:tf];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:showPassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatWhenValidatedAndStartEditingShowsHidePassIconWhenIsNotSecureTextEntryAndHasIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    [borderIconTextField setValidatedIcon:iconMock];
    [borderIconTextField setUnvalidatedIcon:iconMock];
    [borderIconTextField toggleShowPassword];
    [borderIconTextField showValidationSucceed:NO];
    [borderIconTextField textFieldDidBeginEditing:tf];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:hidePassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatWhenDidEndEditingShowsShowPassIconWhenIsSecureTextEntryAndHasIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];

    [borderIconTextField textFieldDidEndEditing:tf];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:showPassIcon],@"Right View should have the showPassIcon as image of the button");
}

-(void)testThatWhenDidEndEditingShowsHidePassIconWhenIsNotSecureTextEntryAndHasIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setShowPasswordIcon:showPassIcon];
    [borderIconTextField setHidePasswordIcon:hidePassIcon];
    [borderIconTextField toggleShowPassword];

    [borderIconTextField textFieldDidEndEditing:tf];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:hidePassIcon],@"Right View should have the showPassIcon as image of the button");
}

@end
