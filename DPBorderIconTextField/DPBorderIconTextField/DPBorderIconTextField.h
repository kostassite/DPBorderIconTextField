//
//  DPBorderIconTextField.h
//  DPBorderIconTextField
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface DPBorderIconTextField : UIView <UITextFieldDelegate>{
    UIImageView *iconImageView;
    UITextField *textField;
}

@property (nonatomic) IBInspectable BOOL hasBorder;

@property (nonatomic) IBInspectable NSInteger borderWidth;

@property (nonatomic) IBInspectable BOOL hasRoundedCorners;
@property (nonatomic) IBInspectable NSUInteger roundedCornersRadius; // default = 0, if zero then is equal to height/2 


@property (nonatomic,strong) IBInspectable UIColor *borderColor;
@property (nonatomic,strong) IBInspectable UIColor *borderColorActive;
@property (nonatomic,strong) IBInspectable UIColor *borderValidatedColor;
@property (nonatomic,strong) IBInspectable UIColor *borderInvalidatedColor;

@property (nonatomic,strong) IBInspectable UIImage *icon;
@property (nonatomic,strong) IBInspectable UIImage *iconActive;
@property (nonatomic) IBInspectable NSInteger iconLeftInset;

@property (nonatomic,strong) IBInspectable UIImage *clearIcon;

@property (nonatomic,strong) IBInspectable UIImage *rightIcon;
@property (nonatomic,strong) IBInspectable UIImage *validatedIcon;
@property (nonatomic,strong) IBInspectable UIImage *unvalidatedIcon;

@property (nonatomic,getter=isSecureTextEntry) IBInspectable BOOL secureTextEntry;
@property (nonatomic,strong) IBInspectable UIImage *showPasswordIcon;
@property (nonatomic,strong) IBInspectable UIImage *hidePasswordIcon;

@property (nonatomic,strong) IBInspectable UIFont *font;
@property (nonatomic,strong) IBInspectable NSString *placeholder;
@property (nonatomic,strong) IBInspectable NSString *text;
@property (nonatomic,strong) IBInspectable UIColor *textColor;

@property (nonatomic,weak) IBOutlet id<UITextFieldDelegate> textFieldDelegate;


-(UITextField*)textField;

-(void)showValidationSucceed:(BOOL)succeed withResignFirstResponder:(BOOL)resignFirstResponder;
-(void)clearValidationState;

-(void)toggleShowPassword;

@end
