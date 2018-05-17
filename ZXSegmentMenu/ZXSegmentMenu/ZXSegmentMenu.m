//
//  ZXSegmentMenu.m
//  ZXSegmentMenu
//
//  Created by JuanFelix on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import "ZXSegmentMenu.h"
#import "ZXSegMenuCell.h"
#define ZX_IS_iPhoneX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


@interface ZXSegmentMenu () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (nonatomic,weak) UIViewController * parentController;
@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) CGFloat zxWidth;
@property (nonatomic, assign) CGFloat zxHeight;
@property (nonatomic, assign) CGFloat zxContentHeight;
@property (nonatomic,strong) NSMutableArray<ZXSegMenuModel *> * arrMenuModel;
@property (nonatomic,strong) NSMutableArray<UIView *> * childViews;
@property (nonatomic,strong) NSMutableArray<UIViewController *> * childViewControllers;
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, assign) NSInteger menuCountAtOnePage;

@property (nonatomic,strong) UIView * sLine;

@end

@implementation ZXSegmentMenu

- (instancetype)initWithFrame:(CGRect)frameA
                   menuHeight:(CGFloat)menuHeight
           menuCountAtOnePage:(NSInteger)mCount
             parentController:(UIViewController *)pVC{
    CGFloat navBarHeight = 0;
    CGFloat tabBarHeight = 0;
    if (frameA.size.height == UIScreen.mainScreen.bounds.size.height) {
        if (pVC.navigationController) {
            navBarHeight = pVC.navigationController.navigationBar.frame.size.height;
            navBarHeight += 20;
        }
        if (pVC.tabBarController && pVC.tabBarController.tabBar.window) {
            tabBarHeight = pVC.tabBarController.tabBar.frame.size.height;
        }
        if (ZX_IS_iPhoneX) {
            navBarHeight += 24;
        }
    }
    self.zxHeight = frameA.size.height - navBarHeight - tabBarHeight;
    self.zxWidth = frameA.size.width;
    CGRect tempFrame = CGRectMake(frameA.origin.x, frameA.origin.y, self.zxWidth, self.zxHeight);
    if (self = [super initWithFrame: tempFrame]) {
        self.arrMenuModel = nil;
        self.childViews = nil;
        self.childViewControllers = nil;
        self.menuHeight = menuHeight;
        self.zxContentHeight = self.zxHeight - menuHeight;
        self.dataCount = 0;
        self.parentController = pVC;
        self.selectedIndex = 0;
        self.menuCountAtOnePage = mCount;
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.ccvList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.zxWidth, menuHeight) collectionViewLayout:layout];
        self.ccvList.backgroundColor = UIColor.whiteColor;
        [self.ccvList registerNib:[UINib nibWithNibName:@"ZXSegMenuCell" bundle:nil] forCellWithReuseIdentifier:@"ZXSegMenuCell"];
        self.ccvList.showsVerticalScrollIndicator = false;
        self.ccvList.showsHorizontalScrollIndicator = false;
        self.ccvList.delegate = self;
        self.ccvList.dataSource = self;
        
        [self addSubview:self.ccvList];
        
        self.zxContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, menuHeight, self.zxWidth, self.zxContentHeight)];
        self.zxContentView.showsVerticalScrollIndicator = false;
        self.zxContentView.showsHorizontalScrollIndicator = false;
        self.zxContentView.bounces = false;
        self.zxContentView.delegate = self;
        self.zxContentView.pagingEnabled = true;
        [self addSubview:self.zxContentView];
        
        _sLine = [[UIView alloc] initWithFrame:CGRectMake(5, menuHeight, _zxWidth - 10, 0.5)];
        _sLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_sLine];
        
    }
    return self;
}

- (void)setDatasource:(id<ZXSegmentMenuDataSource>)datasource {
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData {
    if (self.arrMenuModel) {
        [self.arrMenuModel removeAllObjects];
        self.arrMenuModel = nil;
    }
    if (self.childViews) {
        for (UIView * view in self.childViews) {
            [view removeFromSuperview];
        }
        [self.childViews removeLastObject];
        self.childViews = nil;
    }
    if (self.childViewControllers) {
        for (UIViewController * vc in self.childViewControllers) {
            [vc removeFromParentViewController];
        }
        [self.childViewControllers removeAllObjects];
        self.childViewControllers = nil;
    }
    self.arrMenuModel = [NSMutableArray array];
    self.childViews = [NSMutableArray array];
    self.childViewControllers = [NSMutableArray array];
    if (_datasource) {
        self.dataCount = [_datasource numberOfCountInSegmentMenu:self];
        self.zxContentView.contentSize = CGSizeMake(self.zxWidth * self.dataCount, self.zxContentHeight);
        for (int i = 0; i < self.dataCount; i++) {
            ZXSegMenuModel * model = [[ZXSegMenuModel alloc] init];
            model.name = [_datasource zxSegmentMenu:self titleFowIndex:i];
            if (_datasource && [_datasource respondsToSelector:@selector(zxSegmentMenu:unreadMsgCountAtIndex:)]) {
                model.unreadMsgCount = [_datasource zxSegmentMenu:self unreadMsgCountAtIndex:i];
            } else {
                model.unreadMsgCount = 0;
            }
            if (_datasource && [_datasource respondsToSelector:@selector(zxSegmentMenu:showDotAtIndex:)]) {
                model.showDot = [_datasource zxSegmentMenu:self showDotAtIndex:i];
            } else {
                model.showDot = false;
            }
            [self.arrMenuModel addObject:model];
            UIView * tempView = [_datasource zxSegmentMenu:self viewAtIndex:i];
            CGRect frame = CGRectMake(self.zxWidth * i, 0, self.zxWidth, self.zxContentHeight);
            tempView.frame = frame;
            [self.zxContentView addSubview:tempView];
            [self.childViews addObject:tempView];
            if (tempView && [tempView.nextResponder isKindOfClass:[UIViewController class]] && tempView.nextResponder != self.parentController) {
                [self.childViewControllers addObject:(UIViewController *)tempView.nextResponder];
                [self.parentController addChildViewController:(UIViewController *)tempView.nextResponder];
            }
        }
        
    }
    [self.ccvList reloadData];
    if (self.selectedIndex < self.dataCount) {
        [self.ccvList selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (_delegate && [_delegate respondsToSelector:@selector(zxSegmentMenu:selectedAtIndex:)]) {
        [_delegate zxSegmentMenu:self selectedAtIndex:selectedIndex];
    }
    if (self.selectedIndex < self.dataCount) {
        [self.ccvList selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

#pragma mark - UIColletionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
//    if (_delegate && [_delegate respondsToSelector:@selector(zxSegmentMenu:selectedAtIndex:)]) {
//        [_delegate zxSegmentMenu:self selectedAtIndex:indexPath.row];
//    }
    self.zxContentView.contentOffset = CGPointMake(self.zxWidth * indexPath.row, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXSegMenuCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZXSegMenuCell" forIndexPath:indexPath];
    if (self.arrMenuModel) {
        ZXSegMenuModel * model = self.arrMenuModel[indexPath.row];
        [cell reloadData:model];
    }
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.arrMenuModel) {
        return self.arrMenuModel.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.arrMenuModel) {
        if (_menuCountAtOnePage > 0) {
            return CGSizeMake(self.zxWidth / _menuCountAtOnePage, self.menuHeight);
        } else {
            ZXSegMenuModel * model = self.arrMenuModel[indexPath.row];
            return CGSizeMake(model.zx_rectWidth, self.menuHeight);
        }
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.zxContentView) {
        CGPoint offset = scrollView.contentOffset;
        NSInteger page = floor((offset.x + self.zxWidth / 2) / self.zxWidth);
        if (page != self.selectedIndex) {
            [self.ccvList selectItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] animated:true scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
            self.selectedIndex = page;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

@end
