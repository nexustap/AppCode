//
//  JSONURL.h
//  OrderMeal
//
//  Created by 宏创 on 14-2-19.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <Foundation/Foundation.h>

//1.用户注册
static NSString *register_url=@"njbcf-2013.oicp.net:28080/gfs/app/regist";
//2.用户登录
static NSString *login_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/login";
//3.获取所有商品类别
static NSString *goodstype_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/goodstype";
//4.版本更新
static NSString *version_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/version";
//5.获取区域（分店）信息
static NSString *region_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/region";
//6.送餐时间点
static NSString *ordertime_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/ordertime";
//7.获取积分信息
static NSString *points_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/points";
//8.获取商品列表
static NSString *regiongoods_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/regiongoods";
//9.获取用户购物车数据
static NSString *cartview_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/cartview";
//10.添加商品到购物车
static NSString *cartadd_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/cartadd";
//11.修改商品份数
static NSString *cartmerge_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/cartmerge";
//12.从购物车删除某商品
static NSString *cartGoodsDelete_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/cartGoodsDelete";
//13.非会员下单
static NSString *quickorderadd_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/quickorderadd";
//14.查询订单详情
static NSString *ordernum_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/ordernum";
//15.会员下单
static NSString *memSubmit_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/memSubmit";
//16.会员订单信息
static NSString *orderid_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/orderid";
//17.删除订单
static NSString *orderdel_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/orderdel";
//18.取消订单
static NSString *ordercancel_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/ordercancel";
//19.合并购物车
static NSString *cartListmerge_url=@"http://njbcf-2013.oicp.net:28080/gfs/app/cartListmerge";

@interface JSONURL : NSObject

@end
