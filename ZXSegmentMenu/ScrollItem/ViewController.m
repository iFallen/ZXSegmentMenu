//
//  ViewController.m
//  ZXSegmentMenu
//
//  Created by JuanFelix on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import "ViewController.h"
#import "ZXSegmentMenu.h"
#import "ZXTestViewController.h"

@interface ViewController () <ZXSegmentMenuDelegate,ZXSegmentMenuDataSource>

@property (nonatomic,strong) NSArray * arrTitle;
@property (nonatomic,strong) ZXSegmentMenu * segMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _arrTitle = @[@"ViewController",@"View",@"Show Dot",@"A",@"Message Count",@"Label",@"Long Long Long Long Long Long Text",@"你是谁",@"果然是法国",@"晓不得"];
    _segMenu = [[ZXSegmentMenu alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 64) menuHeight:40 menuCountAtOnePage:0 parentController:self];
    _segMenu.delegate = self;
    _segMenu.datasource = self;
    [self.view addSubview:_segMenu];
}



- (void)zxSegmentMenu:(ZXSegmentMenu *)menu selectedAtIndex:(NSInteger)index {
    NSLog(@"Selected At %ld",index);
}

- (NSInteger)numberOfCountInSegmentMenu:(ZXSegmentMenu *)menu {
    return _arrTitle.count;
}

- (BOOL)zxSegmentMenu:(ZXSegmentMenu *)menu showDotAtIndex:(NSInteger)index {
    if (index == 2) {
        return true;
    }
    return false;
}

- (NSString *)zxSegmentMenu:(ZXSegmentMenu *)menu titleFowIndex:(NSInteger)index {
    return _arrTitle[index];
}

- (NSInteger)zxSegmentMenu:(ZXSegmentMenu *)menu unreadMsgCountAtIndex:(NSInteger)index {
    if (index == 4) {
        return 28;
    }
    return 0;
}

- (UIView *)zxSegmentMenu:(ZXSegmentMenu *)menu viewAtIndex:(NSInteger)index {
    if (index == 1) {
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = UIColor.lightGrayColor;
        return view;
    } else if (index == 0) {
        ZXTestViewController * testVc = [[ZXTestViewController alloc] init];
        return testVc.view;
    }
    UILabel * lb = [[UILabel alloc] init];
    lb.backgroundColor = UIColor.whiteColor;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = [NSString stringWithFormat:@"Page %ld",index];
    return lb;
}

@end
