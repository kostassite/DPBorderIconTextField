//
//  DPBorderIconTextField.m
//  DPBorderIconTextField
//
//  Created by Kostas on 22/12/16.
//  Copyright © 2016 Kostas Antonopoulos. All rights reserved.
//

#import "DPBorderIconTextField.h"

@implementation DPBorderIconTextField

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.hasBorder = YES;
        self.borderWidth = 1;
        self.hasRoundedCorners = YES;
        self.iconLeftInset = 18;
        self.icon = [UIImage imageNamed:@"unlock"];
    }
    return self;
}

-(void)awakeFromNib{
    [self setupRoundedCorners];
    [self setupBorder];
    [self setupIcon];
    
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

@end
