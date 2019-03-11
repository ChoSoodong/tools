//
//  SDKeyboardNumberCell.m
//  RYNumberKeyboardDemo
//
//  Created by xialan on 2019/2/19.
//  Copyright © 2019 Resory. All rights reserved.
//

#import "SDKeyboardNumberCell.h"

@interface SDKeyboardNumberCell()



@end

@implementation SDKeyboardNumberCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        _itemBtn = [[UIButton alloc] init];
        _itemBtn.backgroundColor =  KeyBoard_RGB(0, 104, 136);
        [_itemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_itemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _itemBtn.titleLabel.font = [UIFont systemFontOfSize:21];
        [_itemBtn setTitle:@"" forState:UIControlStateNormal];
        [_itemBtn addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_itemBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.itemBtn.frame = self.contentView.bounds;
}

-(void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    
    [_itemBtn setTitle:btnTitle forState:UIControlStateNormal];
}

-(void)itemButtonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(keyboardNumberCell:button:)]) {
        [self.delegate keyboardNumberCell:self button:sender];
    }
}

@end
