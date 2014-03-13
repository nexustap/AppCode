//
//  BranchStoreViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-3-6.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BranchStoreViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
