//
//  ZXSegmentMenu.h
//  ZXSegmentMenu
//
//  Created by JuanFelix on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXSegmentMenu;

@protocol ZXSegmentMenuDelegate <NSObject>
- (void)zxSegmentMenu:(ZXSegmentMenu *)menu selectedAtIndex:(NSInteger)index;
@end

@protocol ZXSegmentMenuDataSource <NSObject>

@required
- (NSInteger)numberOfCountInSegmentMenu:(ZXSegmentMenu *)menu;
- (NSString *)zxSegmentMenu:(ZXSegmentMenu *)menu titleFowIndex:(NSInteger)index;
- (UIView *)zxSegmentMenu:(ZXSegmentMenu *)menu viewAtIndex:(NSInteger)index;

@optional
- (BOOL)zxSegmentMenu:(ZXSegmentMenu *)menu showDotAtIndex:(NSInteger)index;
- (NSInteger)zxSegmentMenu:(ZXSegmentMenu *)menu unreadMsgCountAtIndex:(NSInteger)index;

@end

@interface ZXSegmentMenu : UIView


@property (nonatomic,weak) id<ZXSegmentMenuDelegate> delegate;
@property (nonatomic,weak) id<ZXSegmentMenuDataSource> datasource;

@property (nonatomic,strong) UICollectionView * ccvList;
@property (nonatomic,strong) UIScrollView * zxContentView;

@property (nonatomic,assign) NSInteger selectedIndex;


/**
 Init

 @param frame frame
 @param menuHeight topMenuHeight
 @param mCount menuCount At One Page (if mCount> 0 ,menuWidht = frame.size.width / mCount, else actually width)
 @param pVC paranset viewcontrolelr (use to add childviewcontroller)
 @return -
 */
- (instancetype)initWithFrame:(CGRect)frame
                   menuHeight:(CGFloat)menuHeight
           menuCountAtOnePage:(NSInteger)mCount
             parentController:(UIViewController *)pVC;
- (void)reloadData;

@end
