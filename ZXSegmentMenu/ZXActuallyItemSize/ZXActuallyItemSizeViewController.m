//
//  ZXActuallyItemSizeViewController.m
//  ZXSegmentMenu
//
//  Created by screson on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import "ZXActuallyItemSizeViewController.h"
#import "ZXSegmentMenu.h"

@interface ZXActuallyItemSizeViewController ()<ZXSegmentMenuDelegate,ZXSegmentMenuDataSource>

@property (nonatomic,strong) ZXSegmentMenu * segMenu;

@end

@implementation ZXActuallyItemSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _segMenu = [[ZXSegmentMenu alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 64) menuHeight:40 menuCountAtOnePage:0 parentController:self];
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
        return @"头条";
    }
    return @"那些都不是真的";
}

- (UIView *)zxSegmentMenu:(ZXSegmentMenu *)menu viewAtIndex:(NSInteger)index {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = UIColor.lightGrayColor;
    if (index == 1) {
        view.backgroundColor = UIColor.grayColor;
    }
    return view;
}



@end
