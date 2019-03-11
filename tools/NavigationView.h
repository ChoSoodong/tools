//
//  NavigationView.h
//  
//
//
//
//

#import <UIKit/UIKit.h>

/*************** 自定义导航栏 ****************/

@interface NavigationView : UIView

/** 导航栏标题文字 */
@property (nonatomic, copy) NSString *title;
/** 导航栏标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 导航栏标题view */
@property (nonatomic, strong) UIView *titleView;

/** 导航栏背景图片 */
@property (nonatomic, strong) UIImage *backgroundImage;
/** 导航栏背景透明度,不影响子控件 */
@property (nonatomic, assign) CGFloat backgroundAlpha;

/** 导航条背景透明度,不影响子控件 */
@property (nonatomic, assign) CGFloat barBackgroundAlpha;
/** 导航条背景色 */
@property (nonatomic, strong) UIColor *barBackgroudColor;

/** 状态条透明度 */
@property (nonatomic, assign) CGFloat statusBarAlpha;
/** 状态条颜色 */
@property (nonatomic, strong) UIColor *statusBarColor;

/** 分割线颜色 */
@property (nonatomic, strong) UIColor *sepLineColor;
/** 分割线是否隐藏 */
@property (nonatomic, assign,getter=isSepLineHidden) BOOL sepLineHidden;

/** 左边单个按钮 */
@property (nonatomic, strong) UIView *leftBarButtonItem;
/** 左边多个按钮 */
@property (nonatomic, strong) NSArray *leftBarButtonItems;

/** 右边单个按钮 */
@property (nonatomic, strong) UIView *rightBarButtonItem;
/** 右边多个按钮 */
@property (nonatomic, strong) NSArray *rightBarButtonItems;

@end

