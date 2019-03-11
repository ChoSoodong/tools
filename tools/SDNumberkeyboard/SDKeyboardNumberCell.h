//
//  SDKeyboardNumberCell.h
//  RYNumberKeyboardDemo
//
//  Created by xialan on 2019/2/19.
//  Copyright © 2019 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KeyBoard_RGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KeyBoard_RGB(r,g,b)               KeyBoard_RGBA(r,g,b,1.0)


@class SDKeyboardNumberCell;

@protocol SDKeyboardNumberCellDelegate<NSObject>

-(void)keyboardNumberCell:(SDKeyboardNumberCell *)cell button:(UIButton *)button;

@end


@interface SDKeyboardNumberCell : UICollectionViewCell


/** button */
@property (nonatomic, strong) UIButton *itemBtn;

/** title */
@property (nonatomic, copy) NSString *btnTitle;

/** 代理属性 */
@property (nonatomic, weak) id<SDKeyboardNumberCellDelegate> delegate;

@end

