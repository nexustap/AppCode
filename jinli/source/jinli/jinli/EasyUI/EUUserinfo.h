//
//  EUUserinfo.h
//  jinli
//
//  Created by 金磊 on 14-1-18.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  用户信息保存和读取
 */
@interface EUUserinfo : NSObject

/*!
 *  用户信息保存初始化
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithData:(NSDictionary*)data;

/*!
 *  用户信息读取初始化。
 *
 *  @return <#return value description#>
 */
- (id)initByRead;

/*!
 *  判断是否登录成功
 *
 *  @return <#return value description#>
 */
- (BOOL)isLogon;

- (void)signOut;

/*!
 *  初始化成功后，通过userinfo[key]读取具体信息
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (id)objectForKeyedSubscript:(id)key;

@end
