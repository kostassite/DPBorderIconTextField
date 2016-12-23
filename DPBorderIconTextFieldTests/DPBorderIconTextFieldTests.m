//
//  DPBorderIconTextFieldTests.m
//  DPBorderIconTextFieldTests
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DPBorderIconTextField.h"
#import <OCMock.h>

@interface DPBorderIconTextFieldTests : XCTestCase{
    DPBorderIconTextField<UITextFieldDelegate> *borderIconTextField;
}

@end

@implementation DPBorderIconTextFieldTests

- (void)setUp {
    [super setUp];
    borderIconTextField = (DPBorderIconTextField<UITextFieldDelegate> *)[[DPBorderIconTextField alloc]init];

}

- (void)tearDown {
    borderIconTextField = nil;
    [super tearDown];
}

#pragma mark - Border

-(void)testThatBorderIsNotShownWhenHasBorderIsNo{
    borderIconTextField.hasBorder = NO;
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqual(borderIconTextField.layer.borderWidth, 0,@"Border width should be 0 when hasBorder is NO");
}

-(void)testThatBorderIsShownWhenHasBorderIsYes{
    borderIconTextField.borderWidth = 2;
    borderIconTextField.hasBorder = YES;
    [borderIconTextField awakeFromNib];
    
    XCTAssertGreaterThan(borderIconTextField.layer.borderWidth, 0,@"Border width should be more than 0 when hasBorder is YES");
}

-(void)testThatBorderWidthIsNotZeroWhenHasBorderIsYes{
    borderIconTextField.borderWidth = 0;
    borderIconTextField.hasBorder = YES;
    [borderIconTextField awakeFromNib];
    
    XCTAssertGreaterThan(borderIconTextField.layer.borderWidth, 0,@"Border width should be more than 0 when hasBorder is YES");
}

-(void)testThatBorderWidthIsSetFromProperty{
    borderIconTextField.borderWidth = 10;
    borderIconTextField.hasBorder = YES;
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqual(borderIconTextField.layer.borderWidth, borderIconTextField.borderWidth,@"Border width of layer should be equal to the property");
}

-(void)testThatHasRoundedCornerWhenPropertyIsYes{
    borderIconTextField.hasRoundedCorners = YES;
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqual(borderIconTextField.layer.cornerRadius, borderIconTextField.frame.size.height/2,@"Corner radius should be equal to height/2");
}

-(void)testThatDoesntHasRoundedCornerWhenPropertyIsNo{
    borderIconTextField.hasRoundedCorners = NO;
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqual(borderIconTextField.layer.cornerRadius, 0,@"Corner radius should be equal to 0");
}

-(void)testThatBorderColorIsSameAsProperty{
    borderIconTextField.hasBorder = YES;
    borderIconTextField.borderColor = [UIColor redColor];
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColor,@"Border color should be the same as property");
}

#pragma mark - Icon

-(void)testThatIconIsSetCorrectIntoTheImageView{
    borderIconTextField.icon = [UIImage imageNamed:@"lock"];
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqualObjects([[borderIconTextField valueForKey:@"iconImageView"] image], borderIconTextField.icon);
}

-(void)testThatIconImageViewHasCorrectInset{
    borderIconTextField.icon = [UIImage imageNamed:@"lock"];
    borderIconTextField.iconLeftInset = 10;
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqual([[borderIconTextField valueForKey:@"iconImageView"] frame].origin.x, borderIconTextField.iconLeftInset);
}

#pragma mark - TextField

-(void)testThatTextFieldIsInitWithCorrectValues{
    
    borderIconTextField.text = @"Test";
    borderIconTextField.placeholder = @"Placeholder";
    borderIconTextField.font = [UIFont boldSystemFontOfSize:11];
    borderIconTextField.textColor = [UIColor redColor];
    
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    XCTAssertEqualObjects(tf.text, borderIconTextField.text,@"Text should be set from property");
    XCTAssertEqualObjects(tf.placeholder, borderIconTextField.placeholder,@"Placeholder should be set from property");
    XCTAssertEqualObjects(tf.textColor, borderIconTextField.textColor,@"TextColor should be set from property");
    XCTAssertEqualObjects(tf.font, borderIconTextField.font,@"Font should be set from property");
}

-(void)testThatTextFieldGettersWorkWhenTextFieldNotAwakeFromNib{
    borderIconTextField.text = @"Test";
    borderIconTextField.placeholder = @"Placeholder";
    borderIconTextField.font = [UIFont boldSystemFontOfSize:11];
    borderIconTextField.textColor = [UIColor redColor];
    
    XCTAssertEqualObjects(borderIconTextField.text,@"Test",@"Text should be set from property");
    XCTAssertEqualObjects(borderIconTextField.placeholder,@"Placeholder",@"Placeholder should be set from property");
    XCTAssertEqualObjects(borderIconTextField.textColor,[UIColor redColor],@"TextColor should be set from property");
    XCTAssertEqualObjects(borderIconTextField.font,[UIFont boldSystemFontOfSize:11],@"Font should be set from property");
}

-(void)testThatTextFieldGettersWorkWhenTextFieldAwakeFromNib{
    borderIconTextField.text = @"Test";
    borderIconTextField.placeholder = @"Placeholder";
    borderIconTextField.font = [UIFont boldSystemFontOfSize:11];
    borderIconTextField.textColor = [UIColor redColor];
    
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqualObjects(borderIconTextField.text,@"Test",@"Text should be set from property");
    XCTAssertEqualObjects(borderIconTextField.placeholder,@"Placeholder",@"Placeholder should be set from property");
    XCTAssertEqualObjects(borderIconTextField.textColor,[UIColor redColor],@"TextColor should be set from property");
    XCTAssertEqualObjects(borderIconTextField.font,[UIFont boldSystemFontOfSize:11],@"Font should be set from property");
}

-(void)testThatTextFieldSettersUpdateTheTextField{
    borderIconTextField.text = @"Test";
    borderIconTextField.placeholder = @"Placeholder";
    borderIconTextField.font = [UIFont boldSystemFontOfSize:11];
    borderIconTextField.textColor = [UIColor redColor];
    
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqualObjects(borderIconTextField.text,@"Test",@"Text should be set from property");
    XCTAssertEqualObjects(borderIconTextField.placeholder,@"Placeholder",@"Placeholder should be set from property");
    XCTAssertEqualObjects(borderIconTextField.textColor,[UIColor redColor],@"TextColor should be set from property");
    XCTAssertEqualObjects(borderIconTextField.font,[UIFont boldSystemFontOfSize:11],@"Font should be set from property");
    
    borderIconTextField.text = @"Test2";
    borderIconTextField.placeholder = @"Placeholder2";
    borderIconTextField.font = [UIFont boldSystemFontOfSize:22];
    borderIconTextField.textColor = [UIColor greenColor];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    XCTAssertEqualObjects(tf.text,@"Test2",@"Text should be updated from property");
    XCTAssertEqualObjects(tf.placeholder,@"Placeholder2",@"Placeholder should be updated from property");
    XCTAssertEqualObjects(tf.textColor,[UIColor greenColor],@"TextColor should be updated from property");
    XCTAssertEqualObjects(tf.font,[UIFont boldSystemFontOfSize:22],@"Font should be updated from property");
}

#pragma mark - TextField Border change

-(void)testBorderColorStartsNotActiveWhenHasNoText{
    borderIconTextField.text = @"";
    [borderIconTextField awakeFromNib];

    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColor,@"Border color should be the non active");
}

-(void)testBorderColorStartsActiveWhenHasText{
    borderIconTextField.text = @"Has Text";
    [borderIconTextField awakeFromNib];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColorActive,@"Border color should be the active");
}

-(void)testBorderColorChangesToActiveWhenSetText{
    borderIconTextField.text = @"";
    [borderIconTextField awakeFromNib];
    borderIconTextField.text = @"Has Text";
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColorActive,@"Border color should be the active");
}

-(void)testBorderColorChangesToInactiveWhenDeleteText{
    borderIconTextField.text = @"Has Text";
    [borderIconTextField awakeFromNib];
    borderIconTextField.text = @"";

    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColor,@"Border color should be the non active");
}

-(void)testBorderColorChangesToActiveWhenBeginEditing{
    borderIconTextField.text = @"";
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];

    [borderIconTextField textFieldDidBeginEditing:tf];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColorActive,@"Border color should be the active");
}

-(void)testBorderColorStaysActiveWhenBeginEditingAndHasAlreadyText{
    borderIconTextField.text = @"Has Text";
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    [borderIconTextField textFieldDidBeginEditing:tf];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColorActive,@"Border color should be the active");
}

-(void)testBorderColorChangesToInactiveWhenEndEditingAndHasNoText{
    borderIconTextField.text = @"";
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    [borderIconTextField textFieldDidEndEditing:tf];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColor,@"Border color should be the non active");
}

-(void)testBorderColorStaysActiveWhenEndEditingAndHasText{
    borderIconTextField.text = @"Has Text";
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    [borderIconTextField textFieldDidEndEditing:tf];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:borderIconTextField.layer.borderColor], borderIconTextField.borderColorActive,@"Border color should be the active");
}

-(void)testThatTextFieldRealDelegateMethodsArePassedToTextFieldDelegateProperty{
    id protocolMock = OCMProtocolMock(@protocol(UITextFieldDelegate));
    [borderIconTextField setTextFieldDelegate:protocolMock];
    
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];

    [borderIconTextField textFieldDidBeginEditing:tf];
    OCMVerify([protocolMock textFieldDidBeginEditing:tf]);
    
    [borderIconTextField textFieldDidEndEditing:tf];
    OCMVerify([protocolMock textFieldDidEndEditing:tf]);

    [borderIconTextField textFieldShouldBeginEditing:tf];
    OCMVerify([protocolMock textFieldShouldBeginEditing:tf]);
    
    [borderIconTextField textFieldShouldEndEditing:tf];
    OCMVerify([protocolMock textFieldShouldEndEditing:tf]);
    
    NSRange r = NSMakeRange(10, 1);
    NSString *repStr = @"Str";
    
    [borderIconTextField textField:tf shouldChangeCharactersInRange:r replacementString:repStr];
    OCMVerify([protocolMock textField:tf shouldChangeCharactersInRange:r replacementString:repStr]);
    
    [borderIconTextField textFieldShouldClear:tf];
    OCMVerify([protocolMock textFieldShouldClear:tf]);
    
    [borderIconTextField textFieldShouldReturn:tf];
    OCMVerify([protocolMock textFieldShouldReturn:tf]);
}

-(void)testThatTextFieldRealDelegateMethodsReturnYesWhenDelegateReturnYes{
    id protocolMock = OCMProtocolMock(@protocol(UITextFieldDelegate));
    [borderIconTextField setTextFieldDelegate:protocolMock];
    
    [borderIconTextField awakeFromNib];

    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    NSRange r = NSMakeRange(10, 1);
    NSString *repStr = @"Str";
    
    OCMStub([protocolMock textField:tf shouldChangeCharactersInRange:r replacementString:repStr]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldClear:tf]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldReturn:tf]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldBeginEditing:tf]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldEndEditing:tf]).andReturn(YES);
    
    
    BOOL v = [borderIconTextField textFieldShouldClear:tf];
    OCMVerify([protocolMock textFieldShouldClear:tf]);
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldReturn:tf];
    OCMVerify([protocolMock textFieldShouldReturn:tf]);
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldBeginEditing:tf];
    OCMVerify([protocolMock textFieldShouldBeginEditing:tf]);
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldEndEditing:tf];
    OCMVerify([protocolMock textFieldShouldEndEditing:tf]);
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textField:tf shouldChangeCharactersInRange:r replacementString:repStr];
    OCMVerify([protocolMock textField:tf shouldChangeCharactersInRange:r replacementString:repStr]);
    XCTAssertEqual(v, YES);
}

-(void)testThatTextFieldRealDelegateMethodsReturnNoWhenDelegateReturnNo{
    id protocolMock = OCMProtocolMock(@protocol(UITextFieldDelegate));
    [borderIconTextField setTextFieldDelegate:protocolMock];
    
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    NSRange r = NSMakeRange(10, 1);
    NSString *repStr = @"Str";
    
    OCMStub([protocolMock textField:tf shouldChangeCharactersInRange:r replacementString:repStr]).andReturn(NO);
    OCMStub([protocolMock textFieldShouldClear:tf]).andReturn(NO);
    OCMStub([protocolMock textFieldShouldReturn:tf]).andReturn(NO);
    OCMStub([protocolMock textFieldShouldBeginEditing:tf]).andReturn(NO);
    OCMStub([protocolMock textFieldShouldEndEditing:tf]).andReturn(NO);
    
    
    BOOL v = [borderIconTextField textFieldShouldClear:tf];
    OCMVerify([protocolMock textFieldShouldClear:tf]);
    XCTAssertEqual(v, NO);
    
    v = [borderIconTextField textFieldShouldReturn:tf];
    OCMVerify([protocolMock textFieldShouldReturn:tf]);
    XCTAssertEqual(v, NO);
    
    v = [borderIconTextField textFieldShouldBeginEditing:tf];
    OCMVerify([protocolMock textFieldShouldBeginEditing:tf]);
    XCTAssertEqual(v, NO);
    
    v = [borderIconTextField textFieldShouldEndEditing:tf];
    OCMVerify([protocolMock textFieldShouldEndEditing:tf]);
    XCTAssertEqual(v, NO);
    
    v = [borderIconTextField textField:tf shouldChangeCharactersInRange:r replacementString:repStr];
    OCMVerify([protocolMock textField:tf shouldChangeCharactersInRange:r replacementString:repStr]);
    XCTAssertEqual(v, NO);
}

-(void)testThatTextFieldRealDelegateMethodsReturnYesWhenNoDelegate{
    id protocolMock = OCMProtocolMock(@protocol(UITextFieldDelegate));
    
    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    NSRange r = NSMakeRange(10, 1);
    NSString *repStr = @"Str";
    
    OCMStub([protocolMock textField:tf shouldChangeCharactersInRange:r replacementString:repStr]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldClear:tf]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldReturn:tf]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldBeginEditing:tf]).andReturn(YES);
    OCMStub([protocolMock textFieldShouldEndEditing:tf]).andReturn(YES);
    
    
    BOOL v = [borderIconTextField textFieldShouldClear:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldReturn:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldBeginEditing:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldEndEditing:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textField:tf shouldChangeCharactersInRange:r replacementString:repStr];
    XCTAssertEqual(v, YES);
}

-(void)testThatTextFieldRealDelegateMethodsReturnYesWhenDelegateNotImplementedMethod{
    id emptyDelegate = OCMClassMock([NSObject class]);
    [borderIconTextField setTextFieldDelegate:emptyDelegate];

    [borderIconTextField awakeFromNib];
    
    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    NSRange r = NSMakeRange(10, 1);
    NSString *repStr = @"Str";
    
    BOOL v = [borderIconTextField textFieldShouldClear:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldReturn:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldBeginEditing:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textFieldShouldEndEditing:tf];
    XCTAssertEqual(v, YES);
    
    v = [borderIconTextField textField:tf shouldChangeCharactersInRange:r replacementString:repStr];
    XCTAssertEqual(v, YES);
}

-(void)testThatTextFieldRealDelegateNotCallDelegateMethodsThatAreNotImplemented{
    id emptyDelegate = OCMStrictClassMock([NSObject class]);
    [borderIconTextField setTextFieldDelegate:emptyDelegate];
    
    [borderIconTextField awakeFromNib];

    UITextField *tf = [borderIconTextField valueForKey:@"textField"];
    
    [borderIconTextField textFieldDidBeginEditing:tf];
    [borderIconTextField textFieldDidEndEditing:tf];
    [borderIconTextField textFieldShouldBeginEditing:tf];
    [borderIconTextField textFieldShouldEndEditing:tf];
    
    NSRange r = NSMakeRange(10, 1);
    NSString *repStr = @"Str";
    
    [borderIconTextField textField:tf shouldChangeCharactersInRange:r replacementString:repStr];
    [borderIconTextField textFieldShouldClear:tf];
    [borderIconTextField textFieldShouldReturn:tf];
}

@end
