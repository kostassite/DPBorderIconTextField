//
//  DPBorderIconTextFieldRightIconTests.m
//  DPBorderIconTextField
//
//  Created by Kostas on 4/1/17.
//  Copyright © 2017 Kostas Antonopoulos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DPBorderIconTextField.h"
#import "OCMock.h"

@interface DPBorderIconTextFieldRightIconTests : XCTestCase{
    DPBorderIconTextField<UITextFieldDelegate> *borderIconTextField;
    UIImage *clearIcon;
    UIImage *rightIcon;
    UIImage *validIcon;
    UIImage *unvalidIcon;
}

@end

@interface DPBorderIconTextField (Tests){
    
}

-(void)clearPressed:(id)sender;

@end

@implementation DPBorderIconTextFieldRightIconTests

- (void)setUp {
    [super setUp];

    clearIcon = OCMClassMock([UIImage class]);
    rightIcon = OCMClassMock([UIImage class]);
    validIcon = OCMClassMock([UIImage class]);
    unvalidIcon = OCMClassMock([UIImage class]);
    
    borderIconTextField = OCMPartialMock((DPBorderIconTextField<UITextFieldDelegate> *)[[DPBorderIconTextField alloc]initWithFrame:CGRectMake(0, 0, 100, 50)]);
}

- (void)tearDown {
    borderIconTextField = nil;
    clearIcon = nil;
    rightIcon = nil;
    validIcon = nil;
    unvalidIcon = nil;
    
    [super tearDown];
}

-(void)testThatSetRightIconEnablesRightViewUnlessEditingAndSetsTheIcon{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];

    [borderIconTextField setRightIcon:rightIcon];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
}

-(void)testThatSetClearIconEnablesRightViewWhileEditingAndSetsTheIcon{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    [borderIconTextField setClearIcon:clearIcon];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeWhileEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:clearIcon],@"Right View should have the clearIcon as image of the button");
}

-(void)testThatSetBothClearAndRightIconShowsThemCorrect{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
   
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField setClearIcon:clearIcon];

    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
    
    [borderIconTextField textFieldDidBeginEditing:tf];
   
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeWhileEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:clearIcon],@"Right View should have the clearIcon as image of the button");
    
    [borderIconTextField textFieldDidEndEditing:tf];
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
}

-(void)testThatSetBothRightAndClearIconShowsThemCorrect{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
   
    [borderIconTextField setClearIcon:clearIcon];
    [borderIconTextField setRightIcon:rightIcon];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
    
    [borderIconTextField textFieldDidBeginEditing:tf];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeWhileEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:clearIcon],@"Right View should have the clearIcon as image of the button");
    
    [borderIconTextField textFieldDidEndEditing:tf];
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
}

-(void)testThatTapCustomClearIconClearsTheTextField{
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    [tf setText:@"Text"];
    
    [borderIconTextField setClearIcon:clearIcon];
    
    UIButton *clearBtn = (UIButton*) tf.rightView;
    XCTAssertNotNil(clearBtn,@"Should have clearBtn as rightView");
    XCTAssertEqual([[clearBtn allTargets] count], 1,@"Should have a target");
    
    [borderIconTextField clearPressed:clearBtn];
    XCTAssertEqualObjects(tf.text, @"",@"Text should be clear");
}

-(void)testThatShowValidatedSucceedDoingNothingWhenYesNoValidatedIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);

    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    OCMReject([tf setRightView:[OCMArg any]]);
}

-(void)testThatShowValidatedSucceedDoingNothingWhenNoAndNoUnvalidatedIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField showValidationSucceed:NO withResignFirstResponder:NO];
    OCMReject([tf setRightView:[OCMArg any]]);
}

-(void)testThatShowValidatedSucceedYesShowsTheValidatedIconWhileNotEditingWhenNilRightIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);

    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:YES];

    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:validIcon],@"Right View should have the validIcon");
}

-(void)testThatShowValidatedSucceedYesShowsTheValidatedIconWhileNotEditingWhenNilRightIconAndResignIsNO{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:validIcon],@"Right View should have the validIcon");
}

-(void)testThatShowValidatedSucceedYesShowsTheValidatedIconWhileNotEditingWhenNotNilRightIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:YES];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:validIcon],@"Right View should have the validIcon");
}

-(void)testThatShowValidatedSucceedYesShowsTheValidatedIconWhileNotEditingWhenNotNilRightIconAndResignIsNO{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:validIcon],@"Right View should have the validIcon");
}

-(void)testThatShowValidatedSucceedNoShowsTheUnvalidatedIconWhileNotEditingWhenNilRightIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField showValidationSucceed:NO withResignFirstResponder:NO];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:unvalidIcon],@"Right View should have the unvalidIcon");
}

-(void)testThatShowValidatedSucceedYesShowsTheUnvalidatedIconWhileNotEditingWhenNotNilRightIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField showValidationSucceed:NO withResignFirstResponder:NO];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeAlways);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:unvalidIcon],@"Right View should have the unvalidIcon");
}

-(void)testThatClearValidationStateHidesRightViewWhenNilRightIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField showValidationSucceed:NO withResignFirstResponder:NO];
    [borderIconTextField clearValidationState];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeNever);
    XCTAssertNil(tf.rightView,@"RightView should be nil cause no rightIcon");
}

-(void)testThatClearValidationStateShowsRightIconWhenNotNilRightIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField showValidationSucceed:NO withResignFirstResponder:NO];
    [borderIconTextField clearValidationState];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
}

-(void)testThatWhenValidatedAndStartEditingShowsTheClearBtnIfClearBtnNotNil{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField setClearIcon:clearIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    
    [borderIconTextField textFieldDidBeginEditing:tf];
    
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeWhileEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIButton class]],@"Right View should be an UIButton");
    XCTAssertTrue([[[(UIButton*)tf.rightView imageView] image] isEqual:clearIcon],@"Right View should have the clearIcon as image of the button");
}

-(void)testThatWhenValidatedAndStartEditingShowsRightIconIfClearBtnNil{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField setRightIcon:rightIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    
    [borderIconTextField textFieldDidBeginEditing:tf];
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeUnlessEditing);
    XCTAssertTrue([tf.rightView isKindOfClass:[UIImageView class]],@"Right View should be an UIImageView");
    XCTAssertTrue([[(UIImageView*)tf.rightView image] isEqual:rightIcon],@"Right View should have the rightIcon");
}

-(void)testThatWhenValidatedAndStartEditingShowsNilRightIconIfNotRightIconAndNotClearIcon{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField setValidatedIcon:validIcon];
    [borderIconTextField setUnvalidatedIcon:unvalidIcon];
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    
    [borderIconTextField textFieldDidBeginEditing:tf];
    XCTAssertEqual(tf.rightViewMode, UITextFieldViewModeNever);
    XCTAssertNil(tf.rightView,@"RightView should be nil cause no rightIcon");
}

-(void)testThatShowValidatedSucceedDismissKeyboardIfResignFirstResponderIsYes{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);

    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:YES];
    
    OCMVerify([tf resignFirstResponder]);
}

-(void)testThatShowValidatedSucceedDoesntDismissKeyboardIfResignFirstResponderIsNO{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField showValidationSucceed:YES withResignFirstResponder:NO];
    
    OCMReject([tf resignFirstResponder]);
}

-(void)testThatClearValidationStateDismissKeyboard{
    UITextField *tf = OCMPartialMock([borderIconTextField valueForKey:@"textField"]);
    
    [borderIconTextField clearValidationState];
    
    OCMVerify([tf resignFirstResponder]);
}


@end
