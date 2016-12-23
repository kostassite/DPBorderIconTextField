//
//  DPBorderIconTextField.m
//  DPBorderIconTextField
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import "DPBorderIconTextField.h"

@interface DPBorderIconTextField ()<UITextFieldDelegate>{
    
}

@end

@implementation DPBorderIconTextField
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize placeholder = _placeholder;

-(id)init{
    if (self = [super init]) {
        [self loadDefaultValues];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultValues];
    }
    return self;
}

-(void)loadDefaultValues{
    self.hasBorder = YES;
    self.borderWidth = 1;
    self.borderColor = [UIColor blackColor];
    self.borderColorActive = [UIColor blueColor];
    
    self.hasRoundedCorners = YES;
    self.iconLeftInset = 18;
    self.icon = [UIImage imageNamed:@"unlock"];
    
    self.text = @"";
    self.placeholder = @"Add text";
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:17];
}

-(void)awakeFromNib{
    [self setupRoundedCorners];
    [self setupBorder];
    [self setupIcon];
    [self setupTextField];
    
    [super awakeFromNib];
}

#pragma mark - Setup Display

-(void)setupRoundedCorners{
    if (self.hasRoundedCorners) {
        [self.layer setCornerRadius:self.frame.size.height/2];
    }
}

-(void)setupBorder{
    if (self.hasBorder) {
        if (self.borderWidth == 0) {
            self.borderWidth = 1;
        }
        [self.layer setBorderColor:self.borderColor.CGColor];
        [self.layer setBorderWidth:self.borderWidth];
    }
}

-(void)setupIcon{
    iconImageView = [[UIImageView alloc]initWithImage:self.icon];
    [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    [iconImageView setFrame:CGRectMake(self.iconLeftInset, (self.frame.size.height - self.icon.size.height)/2, self.icon.size.width, self.icon.size.height)];
    [self addSubview:iconImageView];
}

-(void)setupTextField{
    textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 5, 2, self.frame.size.width -  CGRectGetMaxX(iconImageView.frame) + 15, self.frame.size.height - 4)];
    textField.placeholder = _placeholder;
    textField.text = _text;
    textField.textColor = _textColor;
    textField.font = _font;
    textField.delegate = self;
    
    [self updateBorderColorBasedOnTextLength];
    
    [self addSubview:textField];
}

#pragma mark - TextField Setters Getters

-(void)setText:(NSString *)text{
    _text = text;
    textField.text = text;
    [self updateBorderColorBasedOnTextLength];
}

-(NSString*)text{
    if (textField) {
        return textField.text;
    }
    return _text;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    textField.placeholder = placeholder;
}

-(NSString*)placeholder{
    if (textField) {
        return textField.placeholder;
    }
    return _placeholder;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    textField.textColor = textColor;
}

-(UIColor*)textColor{
    if (textField) {
        return textField.textColor;
    }
    return _textColor;
}

-(void)setFont:(UIFont *)font{
    _font = font;
    textField.font = font;
}

-(UIFont*)font{
    if (textField) {
        return textField.font;
    }
    return _font;
}

-(void)updateBorderColorBasedOnTextLength{
    if (textField.text.length>0) {
        self.layer.borderColor = self.borderColorActive.CGColor;
    }else{
        self.layer.borderColor = self.borderColor.CGColor;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)tf{
    if (!self.textFieldDelegate || ![self.textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return YES;
    }
    return [self.textFieldDelegate textFieldShouldBeginEditing:tf];
}

- (void)textFieldDidBeginEditing:(UITextField *)tf{
    self.layer.borderColor = self.borderColorActive.CGColor;
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.textFieldDelegate textFieldDidBeginEditing:tf];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)tf{
    if (!self.textFieldDelegate || ![self.textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return YES;
    }
    return [self.textFieldDelegate textFieldShouldEndEditing:tf];
}

- (void)textFieldDidEndEditing:(UITextField *)tf{
    [self updateBorderColorBasedOnTextLength];
    if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.textFieldDelegate textFieldDidEndEditing:tf];
    }
}

- (BOOL)textField:(UITextField *)tf shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (!self.textFieldDelegate || ![self.textFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return YES;
    }
    return [self.textFieldDelegate textField:tf shouldChangeCharactersInRange:range replacementString:string];
}

- (BOOL)textFieldShouldClear:(UITextField *)tf{
    if (!self.textFieldDelegate || ![self.textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return YES;
    }
    return [self.textFieldDelegate textFieldShouldClear:tf];
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf{
    if (!self.textFieldDelegate || ![self.textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return YES;
    }
    return [self.textFieldDelegate textFieldShouldReturn:tf];
}

@end
