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

@property (nonatomic) UIColor *borderColor;
@property (nonatomic) UIColor *borderColorActive;

@property (nonatomic) UIImage *icon;
@property (nonatomic) NSInteger iconLeftInset;

@property (nonatomic) UIFont *font;
@property (nonatomic) NSString *placeholder;
@property (nonatomic) NSString *text;
@property (nonatomic) UIColor *textColor;

@end
