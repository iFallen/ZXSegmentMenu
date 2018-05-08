//
//  ZXSegMenuCell.m
//  ZXSegmentMenu
//
//  Created by JuanFelix on 2018/5/8.
//  Copyright © 2018年 screson. All rights reserved.
//

#import "ZXSegMenuCell.h"
#define ZX_HILIGHTED_COLOR  [UIColor colorWithRed:255 / 255.0 green:210 / 255.0 blue:0 alpha:1.0]
#define ZX_RED_COLOR        [UIColor colorWithRed:208 / 255.0 green:32 / 255.0 blue:32 / 255.0 alpha:1.0]

@implementation ZXSegMenuModel

- (CGFloat)zx_rectWidth {
    if (_name && _name.length) {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        //    CGSizeMake(100, MAXFLOAT)
        CGSize textSize = [_name boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
        if (textSize.width < 40) {
            textSize.width = 40;
        }
        return textSize.width + 20;
    }
    return 60;
}

@end

@implementation ZXSegMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = UIColor.clearColor;
    self.lbTitle.text = @"";
    self.vTips.backgroundColor = ZX_HILIGHTED_COLOR;
    [self.vTips setHidden:true];
    
    self.lbUnReadMsgCount.layer.cornerRadius = 10;
    self.lbUnReadMsgCount.layer.masksToBounds = true;
    self.lbUnReadMsgCount.backgroundColor = ZX_RED_COLOR;
    [self.lbUnReadMsgCount setHidden:true];
    
    self.vDot.layer.cornerRadius = 5;
    self.vDot.layer.masksToBounds = true;
    self.vDot.backgroundColor = ZX_RED_COLOR;
    [self.vDot setHidden:true];
}


- (void)reloadData:(ZXSegMenuModel *)model {
    self.lbTitle.text = @"";
    [self.lbUnReadMsgCount setHidden:true];
    [self.vDot setHidden:true];
    if (model) {
        self.lbTitle.text = model.name;
        if (model.unreadMsgCount > 0) {
            [self.vDot setHidden:true];
            [self.lbUnReadMsgCount setHidden:false];
            if (model.unreadMsgCount > 99) {
                self.lbUnReadMsgCount.text = @"99+";
            } else {
                self.lbUnReadMsgCount.text = [NSString stringWithFormat:@"%ld",model.unreadMsgCount];
            }
        } else if (model.showDot) {
            [self.vDot setHidden:false];
            [self.lbUnReadMsgCount setHidden:true];
        }
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [_vTips setHidden:false];
        self.lbTitle.textColor = ZX_HILIGHTED_COLOR;
    } else {
        [_vTips setHidden:true];
        self.lbTitle.textColor = UIColor.darkTextColor;
    }
}

@end
