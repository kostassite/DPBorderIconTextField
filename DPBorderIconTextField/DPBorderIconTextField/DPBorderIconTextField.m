//
//  DPBorderIconTextField.m
//  DPBorderIconTextField
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import "DPBorderIconTextField.h"

@interface DPBorderIconTextField ()<UITextFieldDelegate>{
    NSMutableArray *addedConstraints;
    BOOL inInterfaceBuilder; //used for design in InterfaceBuilder
}

@end

@implementation DPBorderIconTextField
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize placeholder = _placeholder;

-(id)init{
    if (self = [super init]) {
        [self setupViewElements];
        [self loadDefaultValues];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupViewElements];
        [self loadDefaultValues];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        inInterfaceBuilder = YES;
        [self setupViewElements];
        [self loadDefaultValues];
    }
    return self;
}

-(void)prepareForInterfaceBuilder{
    [self updateImageViewBasedOnLeftInsetAndIcon];
}

-(void)loadDefaultValues{
    self.hasBorder = YES;
    self.borderWidth = 1;
    self.borderColor = [UIColor blackColor];
    self.borderColorActive = [UIColor blueColor];
    
    self.hasRoundedCorners = YES;
    self.icon = nil;
    self.iconLeftInset = 18;
    
    self.text = @"";
    self.placeholder = @"";
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:17];
    
}

-(void)setupViewElements{
    self.translatesAutoresizingMaskIntoConstraints = inInterfaceBuilder;
    [self setupIconImageView];
    [self setupTextField];
    [self updateImageViewBasedOnLeftInsetAndIcon];
}

#pragma mark - Setup Display

-(void)setupIconImageView{
    iconImageView = [[UIImageView alloc]initWithImage:self.icon];
    [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:iconImageView];
}

-(void)setupTextField{
    textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 5, 2, self.frame.size.width -  CGRectGetMaxX(iconImageView.frame) - _iconLeftInset * 2, self.frame.size.height - 4)];
    textField.placeholder = _placeholder;
    textField.text = _text;
    textField.textColor = _textColor;
    textField.font = _font;
    textField.delegate = self;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:textField];
}

#pragma mark - IBInspectable Setters

-(void)setIconLeftInset:(NSInteger)iconLeftInset{
    _iconLeftInset = iconLeftInset;
    [self updateImageViewBasedOnLeftInsetAndIcon];
}

-(void)setIcon:(UIImage *)icon{
    _icon = icon;
    [self updateImageViewBasedOnLeftInsetAndIcon];
}

-(void)updateImageViewBasedOnLeftInsetAndIcon{
    [self removeConstraints:addedConstraints];

    self.translatesAutoresizingMaskIntoConstraints = inInterfaceBuilder;
    textField.translatesAutoresizingMaskIntoConstraints = inInterfaceBuilder;
    iconImageView.translatesAutoresizingMaskIntoConstraints = inInterfaceBuilder;
    
    if (_icon) {
        [iconImageView setImage:_icon];
        if (inInterfaceBuilder) {
            [iconImageView setFrame:CGRectMake(_iconLeftInset, (self.frame.size.height - _icon.size.height)/2, _icon.size.width, _icon.size.height)];
            [textField setFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 5, 2, self.frame.size.width -  CGRectGetMaxX(iconImageView.frame) - _iconLeftInset * 2, self.frame.size.height - 4)];
        }else{
            addedConstraints = [[NSMutableArray alloc]init];
            
            NSDictionary *viewsDict = NSDictionaryOfVariableBindings(textField,iconImageView);
            
            [addedConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftInset-[iconImageView(iconWidth)]-5-[textField]-leftInset-|" options:0 metrics:@{@"leftInset":@(_iconLeftInset),@"iconWidth":@(_icon.size.width)} views:viewsDict]];
            [addedConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconImageView(s)]" options:0 metrics:@{@"s":@(_icon.size.height)} views:viewsDict]];
            [addedConstraints addObject:[NSLayoutConstraint constraintWithItem:iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
            [addedConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[textField]-2-|" options:0 metrics:nil views:viewsDict]];
            
            [self addConstraints:addedConstraints];
            [self layoutIfNeeded];
        }
    }else{
        [iconImageView setImage:nil];
        
        if (inInterfaceBuilder) {
            [textField setFrame:CGRectMake(_iconLeftInset, 2, self.frame.size.width -  _iconLeftInset * 2, self.frame.size.height - 4)];
        }else{
            addedConstraints = [[NSMutableArray alloc]init];
            
            NSDictionary *viewsDict = NSDictionaryOfVariableBindings(textField);
            
            [addedConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftInset-[textField]-leftInset-|" options:0 metrics:@{@"leftInset":@(_iconLeftInset)} views:viewsDict]];
            [addedConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[textField]-2-|" options:0 metrics:nil views:viewsDict]];
            
            [self addConstraints:addedConstraints];
            [self layoutIfNeeded];
        }
    }
    
    if (_hasRoundedCorners) {
        [self.layer setCornerRadius:self.frame.size.height/2];
    }else{
        [self.layer setCornerRadius:0];
    }
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self updateBorderColorBasedOnTextLength];
}

-(void)setBorderColorActive:(UIColor *)borderColorActive{
    _borderColorActive = borderColorActive;
    [self updateBorderColorBasedOnTextLength];
}

-(void)setBorderWidth:(NSInteger)borderWidth{
    _borderWidth = borderWidth;
    [self.layer setBorderWidth:_borderWidth];
}

-(void)setHasRoundedCorners:(BOOL)hasRoundedCorners{
    _hasRoundedCorners = hasRoundedCorners;
    
    if (_hasRoundedCorners) {
        [self.layer setCornerRadius:self.frame.size.height/2];
    }else{
        [self.layer setCornerRadius:0];
    }
}

-(void)setHasBorder:(BOOL)hasBorder{
    _hasBorder = hasBorder;
    if (_hasBorder) {
        if (_borderWidth == 0) {
            _borderWidth = 1;
        }
        [self.layer setBorderColor:_borderColor.CGColor];
        [self.layer setBorderWidth:_borderWidth];
    }else{
        [self.layer setBorderWidth:0];
    }
}

#pragma mark - RightIcon Setters

-(void)setClearIcon:(UIImage *)clearIcon{
    _clearIcon = clearIcon;
    if (!_rightIcon) {
        [textField setRightViewMode:UITextFieldViewModeWhileEditing];
        [textField setRightView:[self clearBtnWithClearIcon:_clearIcon]];
    }
}

-(void)setRightIcon:(UIImage *)rightIcon{
    _rightIcon = rightIcon;
    [textField setRightViewMode:UITextFieldViewModeUnlessEditing];
    [textField setRightView:[[UIImageView alloc] initWithImage:rightIcon]];
}

-(void)setValidatedIcon:(UIImage *)validatedIcon{
    _validatedIcon = validatedIcon;
}

-(void)setUnvalidatedIcon:(UIImage *)unvalidatedIcon{
    _unvalidatedIcon = unvalidatedIcon;
}

-(UIButton*)clearBtnWithClearIcon:(UIImage*)icon{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    [btn setImage:icon forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)clearPressed:(id)sender{
    [textField setText:@""];
}

#pragma mark - Password

-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    [textField setSecureTextEntry:secureTextEntry];
}

-(void)setShowPasswordIcon:(UIImage *)showPasswordIcon{
    _showPasswordIcon = showPasswordIcon;
    [self setSecureTextEntry:YES];
    
    [textField setRightViewMode:UITextFieldViewModeAlways];
    [textField setRightView:[self toggleShowPasswordBtnWithIcon:_showPasswordIcon]];
}

-(void)setHidePasswordIcon:(UIImage *)hidePasswordIcon{
    _hidePasswordIcon = hidePasswordIcon;
}

-(UIButton*)toggleShowPasswordBtnWithIcon:(UIImage*)icon{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    [btn setImage:icon forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toggleShowPassword) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)toggleShowPassword{
    if (textField.isSecureTextEntry) {
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_hidePasswordIcon]];
    }else{
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_showPasswordIcon]];
    }
    textField.secureTextEntry = !textField.secureTextEntry;
}

#pragma mark - TextField Setters Getters

-(UITextField*)textField{
    return textField;
}

-(void)setText:(NSString *)text{
    textField.text = text;
    [self updateBorderColorBasedOnTextLength];
}

-(NSString*)text{
    return textField.text;
}

-(void)setPlaceholder:(NSString *)placeholder{
    textField.placeholder = placeholder;
}

-(NSString*)placeholder{
    return textField.placeholder;
}

-(void)setTextColor:(UIColor *)textColor{
    textField.textColor = textColor;
}

-(UIColor*)textColor{
    return textField.textColor;
}

-(void)setFont:(UIFont *)font{
    textField.font = font;
}

-(UIFont*)font{
    return textField.font;
}

-(void)updateBorderColorBasedOnTextLength{
    if (textField.text.length>0) {
        self.layer.borderColor =_borderColorActive.CGColor;
    }else{
        self.layer.borderColor = _borderColor.CGColor;
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
    if (_clearIcon) {
        [textField setRightViewMode:UITextFieldViewModeWhileEditing];
        [textField setRightView:[self clearBtnWithClearIcon:_clearIcon]];
    }else if (_rightIcon) {
        [textField setRightViewMode:UITextFieldViewModeUnlessEditing];
        [textField setRightView:[[UIImageView alloc] initWithImage:_rightIcon]];
    }else if (textField.isSecureTextEntry && _showPasswordIcon){
        [textField setRightViewMode:UITextFieldViewModeAlways];
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_showPasswordIcon]];
    }else if (!textField.isSecureTextEntry && _hidePasswordIcon){
        [textField setRightViewMode:UITextFieldViewModeAlways];
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_hidePasswordIcon]];
    }else{
        [textField setRightViewMode:UITextFieldViewModeNever];
        [textField setRightView:nil];
    }
    
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
    if (_rightIcon) {
        [textField setRightViewMode:UITextFieldViewModeUnlessEditing];
        [textField setRightView:[[UIImageView alloc] initWithImage:_rightIcon]];
    }else if (textField.isSecureTextEntry && _showPasswordIcon){
        [textField setRightViewMode:UITextFieldViewModeAlways];
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_showPasswordIcon]];
    }else if (!textField.isSecureTextEntry && _hidePasswordIcon){
        [textField setRightViewMode:UITextFieldViewModeAlways];
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_hidePasswordIcon]];
    }else{
        [textField setRightViewMode:UITextFieldViewModeNever];
        [textField setRightView:nil];
    }
    
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

#pragma mark - Validation

-(void)showValidationSucceed:(BOOL)succeed{
    [textField resignFirstResponder];
    
   
    if (succeed && _validatedIcon) {
        [textField setRightViewMode:UITextFieldViewModeUnlessEditing];
        [textField setRightView:[[UIImageView alloc]initWithImage:_validatedIcon]];
    }else if (!succeed && _unvalidatedIcon){
        [textField setRightViewMode:UITextFieldViewModeUnlessEditing];
        [textField setRightView:[[UIImageView alloc]initWithImage:_unvalidatedIcon]];
    }
}

-(void)clearValidationState{
    [textField resignFirstResponder];

    if (_rightIcon) {
        [self setRightIcon:_rightIcon];
    }else if (textField.isSecureTextEntry && _showPasswordIcon){
        [textField setRightViewMode:UITextFieldViewModeAlways];
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_showPasswordIcon]];
    }else if (!textField.isSecureTextEntry && _hidePasswordIcon){
        [textField setRightViewMode:UITextFieldViewModeAlways];
        [textField setRightView:[self toggleShowPasswordBtnWithIcon:_hidePasswordIcon]];
    }else{
        [textField setRightViewMode:UITextFieldViewModeNever];
        [textField setRightView:nil];
    }
}

@end
