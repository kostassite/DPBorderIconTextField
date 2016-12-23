//
//  DPBorderIconTextField.h
//  DPBorderIconTextField
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPBorderIconTextField : UIView{
    UIImageView *iconImageView;
    UITextField *textField;
}

@property (nonatomic) BOOL hasBorder;

@property (nonatomic) NSInteger borderWidth;

@property (nonatomic) BOOL hasRoundedCorners;

@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,strong) UIColor *borderColorActive;

@property (nonatomic,strong) UIImage *icon;
@property (nonatomic) NSInteger iconLeftInset;

@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,weak) id<UITextFieldDelegate> textFieldDelegate;

@end
