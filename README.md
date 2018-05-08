### `ZXSegmentMenu View`



#####  `效果图`

|等宽|自然宽度|滚动|
|:----:|:----:|:----:|
|menuCountAtOnePage = 2|menuCountAtOnePage = 0|menuCountAtOnePage = 0|
|![1](https://github.com/iFallen/ZXSegmentMenu/raw/master/image/1.png)|![2](https://github.com/iFallen/ZXSegmentMenu/raw/master/image/2.png)|![3](https://github.com/iFallen/ZXSegmentMenu/raw/master/image/3.png)|

#####  `Test`

```
_segMenu = [[ZXSegmentMenu alloc] initWithFrame:frame menuHeight:40 menuCountAtOnePage:0 parentController:self];
_segMenu.delegate = self;
_segMenu.datasource = self;
[self.view addSubview:_segMenu];
```

- `menuHeight`: 菜单高度
-  `menuCountAtOnePage `：大于0 时，菜单宽 = size / mCount 。等于0时 菜单宽 = 自然宽度
-  `parentController `：用于addChildViewController

##### `ZXSegmentMenuDataSource`

```
@required
- (NSInteger)numberOfCountInSegmentMenu:(ZXSegmentMenu *)menu;
- (NSString *)zxSegmentMenu:(ZXSegmentMenu *)menu titleFowIndex:(NSInteger)index;
- (UIView *)zxSegmentMenu:(ZXSegmentMenu *)menu viewAtIndex:(NSInteger)index;

@optional
//是否有红点
- (BOOL)zxSegmentMenu:(ZXSegmentMenu *)menu showDotAtIndex:(NSInteger)index;
//未读消息
- (NSInteger)zxSegmentMenu:(ZXSegmentMenu *)menu unreadMsgCountAtIndex:(NSInteger)index;

```

##### `ZXSegmentMenuDelegate`

```
- (void)zxSegmentMenu:(ZXSegmentMenu *)menu selectedAtIndex:(NSInteger)index;
```

#####  `关于样式`

>
样式可在 `ZXSegMenuCell` 中修改
>
定义太多样式的意义不大，每个人需求不一样。
这里只是给个思路吧，有很多东西可以完善。比如，重用、自动布局。