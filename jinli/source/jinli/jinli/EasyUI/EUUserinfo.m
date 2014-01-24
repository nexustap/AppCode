//
//  EUUserinfo.m
//  jinli
//
//  Created by 金磊 on 14-1-18.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "EUUserinfo.h"

static NSString *USERINFO_KEY = @"userinfo";

@interface EUUserinfo ()
{
    NSDictionary *_data;
}

@end

@implementation EUUserinfo

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _data = data;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_data forKey:USERINFO_KEY];
    }

    return self;
}

- (id)initByRead
{
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _data = [userDefaults objectForKey:USERINFO_KEY];
    }
    return self;
}

- (BOOL)isLogon
{
    if (_data && [_data count] > 0) {
        return YES;
    }
    
    return NO;
}

- (void)signOut
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USERINFO_KEY];
    _data = nil;
}

- (id)objectForKeyedSubscript:(id)key
{
    if (_data != nil && [_data valueForKey:key]) {
        return _data[key];
    }
    
    return nil;
}


@end
