//
//  ChatMessage.h
//  jinli
//
//  Created by 金磊 on 14-1-25.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "JSMessage.h"

@interface ChatMessage : JSMessage

@property (nonatomic) NSInteger fromeId;
@property (nonatomic, strong) NSString *avatarUrl;

- (id)initWithFromId:(NSInteger)fromId avatarUrl:(NSString*)avatarUrl text:(NSString *)text sender:(NSString *)sender date:(NSDate *)date;
@end
