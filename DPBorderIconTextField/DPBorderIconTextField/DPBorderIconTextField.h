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
}

@property (nonatomic) BOOL hasBorder;

@property (nonatomic) NSInteger borderWidth;

@property (nonatomic) BOOL hasRoundedCorners;

@property (nonatomic) UIColor *borderColor;

@property (nonatomic) UIImage *icon;
@property (nonatomic) NSInteger iconLeftInset;

@end
