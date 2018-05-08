//
//  ZXSegMenuCell.h
//  ZXSegmentMenu
//
//  Created by JuanFelix on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXSegMenuModel;

@interface ZXSegMenuModel: NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger unreadMsgCount;
@property (nonatomic, assign) BOOL showDot;

- (CGFloat)zx_rectWidth;

@end

@interface ZXSegMenuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *vTips;
@property (weak, nonatomic) IBOutlet UILabel *lbUnReadMsgCount;
@property (weak, nonatomic) IBOutlet UIView *vDot;

- (void)reloadData:(ZXSegMenuModel *)model;

@end
