//
//  AcitivityNavBarView.m
//  jinli
//
//  Created by 金磊 on 14-1-10.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "AcitivityNavBarView.h"

@interface AcitivityNavBarView()
{
    NSArray *_buttons;
}

@property (nonatomic, weak) IBOutlet UIButton *btn1;
@property (nonatomic, weak) IBOutlet UIButton *btn2;
@property (nonatomic, weak) IBOutlet UIButton *btn3;
@property (nonatomic, weak) IBOutlet UIButton *btn4;

@end

@implementation AcitivityNavBarView

-(id)initWithCoder:(NSCoder *)aDecoder
{    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        self.selectedButtonIndex = 0;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    _buttons = @[_btn1, _btn2, _btn3, _btn4];
    
    for (UIButton *button in _buttons) {
        [button addTarget:self action:@selector(didValueChanged:) forControlEvents:UIControlEventTouchDown];
    }
}

#pragma mark - private method

- (void)didValueChanged:(id)sender
{
    
    self.selectedButtonIndex = [_buttons indexOfObject:sender];
    
    for (UIButton *button in _buttons) {
        if ([button isEqual:sender]) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    
    //通知事件动作，即:IBAction
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
