//
//  EUTextField.m
//  jinli
//
//  Created by 金磊 on 14-1-17.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "EUTextField.h"

@implementation EUTextField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //todo
    }
    
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    
    return CGRectInset( bounds , self.leftView.bounds.size.width + 10 , 0 );
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , self.leftView.bounds.size.width + 10 , 0 );
}

-(void)setLeftImage:(NSString *)imageName frame:(CGRect)rect
{
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:rect];
    leftImageView.image = [UIImage imageNamed:imageName];
    [self setLeftView:leftImageView];
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
