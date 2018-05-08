//
//  ZXEqualMenuItemViewController.m
//  ZXSegmentMenu
//
//  Created by JuanFelix on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import "ZXEqualMenuItemViewController.h"
#import "ZXSegmentMenu.h"
#import "ZXTestViewController.h"

@interface ZXEqualMenuItemViewController ()<ZXSegmentMenuDelegate,ZXSegmentMenuDataSource>

@property (nonatomic,strong) ZXSegmentMenu * segMenu;

@end

@implementation ZXEqualMenuItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _segMenu = [[ZXSegmentMenu alloc] initWithFrame:UIScreen.mainScreen.bounds menuHeight:40 menuCountAtOnePage:2 parentController:self];
    _segMenu.delegate = self;
    _segMenu.datasource = self;
    [self.view addSubview:_segMenu];
}
#pragma mark -

- (void)zxSegmentMenu:(ZXSegmentMenu *)menu selectedAtIndex:(NSInteger)index {
    NSLog(@"Selected At %ld",index);
}

- (NSInteger)numberOfCountInSegmentMenu:(ZXSegmentMenu *)menu {
    return 2;
}

- (NSString *)zxSegmentMenu:(ZXSegmentMenu *)menu titleFowIndex:(NSInteger)index {
    if (index == 0) {
        return @"消息";
    }
    return @"通知";
}

- (NSInteger)zxSegmentMenu:(ZXSegmentMenu *)menu unreadMsgCountAtIndex:(NSInteger)index {
    if (index == 0) {
        return 1289;
    }
    return 0;
}

- (BOOL)zxSegmentMenu:(ZXSegmentMenu *)menu showDotAtIndex:(NSInteger)index {
    if (index == 1) {
        return true;
    }
    return false;
}

- (UIView *)zxSegmentMenu:(ZXSegmentMenu *)menu viewAtIndex:(NSInteger)index {
    if (index == 0) {
        ZXTestViewController *  test = [[ZXTestViewController alloc] init];
        return test.view;
    }
    UIDatePicker * dp = [[UIDatePicker alloc] init];
    dp.backgroundColor = UIColor.whiteColor;
    return dp;
}

@end
