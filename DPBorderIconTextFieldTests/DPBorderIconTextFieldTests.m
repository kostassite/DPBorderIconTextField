//
//  DPBorderIconTextFieldTests.m
//  DPBorderIconTextFieldTests
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DPBorderIconTextField.h"

@interface DPBorderIconTextFieldTests : XCTestCase{
    DPBorderIconTextField *textField;
}

@end

@implementation DPBorderIconTextFieldTests

- (void)setUp {
    [super setUp];
    textField = [[DPBorderIconTextField alloc]init];

}

- (void)tearDown {
    textField = nil;
    [super tearDown];
}

-(void)testThatBorderIsNotShownWhenHasBorderIsNo{
    textField.hasBorder = NO;
    [textField awakeFromNib];
    
    XCTAssertEqual(textField.layer.borderWidth, 0,@"Border width should be 0 when hasBorder is NO");
}

-(void)testThatBorderIsShownWhenHasBorderIsYes{
    textField.borderWidth = 2;
    textField.hasBorder = YES;
    [textField awakeFromNib];
    
    XCTAssertGreaterThan(textField.layer.borderWidth, 0,@"Border width should be more than 0 when hasBorder is YES");
}

-(void)testThatBorderWidthIsNotZeroWhenHasBorderIsYes{
    textField.borderWidth = 0;
    textField.hasBorder = YES;
    [textField awakeFromNib];
    
    XCTAssertGreaterThan(textField.layer.borderWidth, 0,@"Border width should be more than 0 when hasBorder is YES");
}

-(void)testThatBorderWidthIsSetFromProperty{
    textField.borderWidth = 10;
    textField.hasBorder = YES;
    [textField awakeFromNib];
    
    XCTAssertEqual(textField.layer.borderWidth, textField.borderWidth,@"Border width of layer should be equal to the property");
}

-(void)testThatHasRoundedCornerWhenPropertyIsYes{
    textField.hasRoundedCorners = YES;
    [textField awakeFromNib];
    
    XCTAssertEqual(textField.layer.cornerRadius, textField.frame.size.height/2,@"Corner radius should be equal to height/2");
}

-(void)testThatDoesntHasRoundedCornerWhenPropertyIsNo{
    textField.hasRoundedCorners = NO;
    [textField awakeFromNib];
    
    XCTAssertEqual(textField.layer.cornerRadius, 0,@"Corner radius should be equal to 0");
}

-(void)testThatBorderColorIsSameAsProperty{
    textField.hasBorder = YES;
    textField.borderColor = [UIColor redColor];
    [textField awakeFromNib];
    
    XCTAssertEqualObjects([UIColor colorWithCGColor:textField.layer.borderColor], textField.borderColor,@"Border color should be the same as property");
}

-(void)testThatIconIsSetCorrectIntoTheImageView{
    textField.icon = [UIImage imageNamed:@"lock"];
    [textField awakeFromNib];
    
    XCTAssertEqualObjects([[textField valueForKey:@"iconImageView"] image], textField.icon);
}

-(void)testThatIconImageViewHasCorrectInset{
    textField.icon = [UIImage imageNamed:@"lock"];
    textField.iconLeftInset = 10;
    [textField awakeFromNib];
    
    XCTAssertEqual([[textField valueForKey:@"iconImageView"] frame].origin.x, textField.iconLeftInset);
}

-(void)testThatTextFieldIsInitWithCorrectValues{
    
    textField.text = @"Test";
    textField.placeholder = @"Placeholder";
    textField.font = [UIFont boldSystemFontOfSize:11];
    textField.textColor = [UIColor redColor];
    
    [textField awakeFromNib];
    
    UITextField *tf = [textField valueForKey:@"textField"];
    
    XCTAssertEqualObjects(tf.text, textField.text,@"Text should be set from property");
    XCTAssertEqualObjects(tf.placeholder, textField.placeholder,@"Placeholder should be set from property");
    XCTAssertEqualObjects(tf.textColor, textField.textColor,@"TextColor should be set from property");
    XCTAssertEqualObjects(tf.font, textField.font,@"Font should be set from property");
}

-(void)testThatTextFieldGettersWorkWhenTextFieldNotAwakeFromNib{
    textField.text = @"Test";
    textField.placeholder = @"Placeholder";
    textField.font = [UIFont boldSystemFontOfSize:11];
    textField.textColor = [UIColor redColor];
    
    XCTAssertEqualObjects(textField.text,@"Test",@"Text should be set from property");
    XCTAssertEqualObjects(textField.placeholder,@"Placeholder",@"Placeholder should be set from property");
    XCTAssertEqualObjects(textField.textColor,[UIColor redColor],@"TextColor should be set from property");
    XCTAssertEqualObjects(textField.font,[UIFont boldSystemFontOfSize:11],@"Font should be set from property");
}

-(void)testThatTextFieldGettersWorkWhenTextFieldAwakeFromNib{
    textField.text = @"Test";
    textField.placeholder = @"Placeholder";
    textField.font = [UIFont boldSystemFontOfSize:11];
    textField.textColor = [UIColor redColor];
    
    [textField awakeFromNib];
    
    XCTAssertEqualObjects(textField.text,@"Test",@"Text should be set from property");
    XCTAssertEqualObjects(textField.placeholder,@"Placeholder",@"Placeholder should be set from property");
    XCTAssertEqualObjects(textField.textColor,[UIColor redColor],@"TextColor should be set from property");
    XCTAssertEqualObjects(textField.font,[UIFont boldSystemFontOfSize:11],@"Font should be set from property");
}

-(void)testThatTextFieldSettersUpdateTheTextField{
    textField.text = @"Test";
    textField.placeholder = @"Placeholder";
    textField.font = [UIFont boldSystemFontOfSize:11];
    textField.textColor = [UIColor redColor];
    
    [textField awakeFromNib];
    
    XCTAssertEqualObjects(textField.text,@"Test",@"Text should be set from property");
    XCTAssertEqualObjects(textField.placeholder,@"Placeholder",@"Placeholder should be set from property");
    XCTAssertEqualObjects(textField.textColor,[UIColor redColor],@"TextColor should be set from property");
    XCTAssertEqualObjects(textField.font,[UIFont boldSystemFontOfSize:11],@"Font should be set from property");
    
    textField.text = @"Test2";
    textField.placeholder = @"Placeholder2";
    textField.font = [UIFont boldSystemFontOfSize:22];
    textField.textColor = [UIColor greenColor];
    
    UITextField *tf = [textField valueForKey:@"textField"];
    
    XCTAssertEqualObjects(tf.text,@"Test2",@"Text should be updated from property");
    XCTAssertEqualObjects(tf.placeholder,@"Placeholder2",@"Placeholder should be updated from property");
    XCTAssertEqualObjects(tf.textColor,[UIColor greenColor],@"TextColor should be updated from property");
    XCTAssertEqualObjects(tf.font,[UIFont boldSystemFontOfSize:22],@"Font should be updated from property");
}

@end
