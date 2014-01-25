//
//  ChatMessage.m
//  jinli
//
//  Created by 金磊 on 14-1-25.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage

- (id)initWithFromId:(NSInteger)fromId avatarUrl:(NSString*)avatarUrl text:(NSString *)text sender:(NSString *)sender date:(NSDate *)date
{
    self = [super initWithText:text sender:sender date:date];
    if (self) {
        self.fromeId = fromId;
        self.avatarUrl = avatarUrl;
    }
    
    return self;
}

@end
