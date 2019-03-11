//
//  NavigationView.m
//
//
//
//
//

#import "NavigationView.h"

#define KBAR_HEIGHT 60  //本项目为60  正常状态为44
#define KSTATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#define KSpace 16

@interface NavigationView()

/** 状态栏 */
@property (nonatomic, strong) UIView *statusBar;
/** 导航栏 */
@property (nonatomic, strong) UIView *navigationBar;
/** 整个导航栏背景图片 */
@property (nonatomic, strong) UIImageView *naviBackgroundImageView;
/** 导航栏标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 导航栏底部分割线 默认不显示 */
@property (nonatomic, strong) UIView *sepLineView;

/** 记录left之前view 用于计算x */
@property (nonatomic, strong) UIView *previousLeftView;
/** 记录right之前view 用于计算x */
@property (nonatomic, strong) UIView *previousRightView;

@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        /** 整个导航栏背景图片 */
        _naviBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _naviBackgroundImageView.backgroundColor = [UIColor clearColor];
        _naviBackgroundImageView.userInteractionEnabled = YES;
        [self addSubview:_naviBackgroundImageView];
        
        /** 状态栏 */
        //当正在视频通话 , 打电话 , 开热点时 状态栏高度变为40.0f
        CGFloat bar_height = KSTATUS_BAR_HEIGHT == 40.0f ? KSTATUS_BAR_HEIGHT - 20.0f : KSTATUS_BAR_HEIGHT;
        _statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, bar_height)];
        _statusBar.backgroundColor = [UIColor clearColor];
        [_naviBackgroundImageView addSubview:_statusBar];
        
        /** 导航条 */
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_statusBar.frame), frame.size.width, KBAR_HEIGHT)];
        _navigationBar.backgroundColor = [UIColor clearColor];
        [_naviBackgroundImageView addSubview:_navigationBar];
        
        /** 导航栏 --- 标题 */
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:KNaviTitleFont];
        _titleLabel.textColor = KNaviTitleColor;
        [_navigationBar addSubview:_titleLabel];
        
         /** 导航栏 --- 分割线 */
        _sepLineView = [[UIView alloc] initWithFrame:CGRectMake(0,_navigationBar.height-1, _navigationBar.width, 1)];
        _sepLineView.backgroundColor = [UIColor lightGrayColor];
        _sepLineView.hidden = YES;
        [_navigationBar addSubview:_sepLineView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

}


#pragma mark - set

/**
 底部分割线颜色
 */
-(void)setSepLineColor:(UIColor *)sepLineColor{
    _sepLineColor = sepLineColor;
    
    _sepLineView.backgroundColor = sepLineColor;
}

/**
 底部分割线是否隐藏
 */
-(void)setSepLineHidden:(BOOL)sepLineHidden{
    _sepLineHidden = sepLineHidden;
    
    _sepLineView.hidden = sepLineHidden;
}

/**
 状态条颜色
 */
-(void)setStatusBarColor:(UIColor *)statusBarColor{
    _statusBarColor = statusBarColor;
    
    _statusBar.backgroundColor = statusBarColor;
}

/**
 状态条透明度
 */
-(void)setStatusBarAlpha:(CGFloat)statusBarAlpha{
    _statusBarAlpha = statusBarAlpha;
    
    _statusBar.backgroundColor = [_statusBar.backgroundColor colorWithAlphaComponent:statusBarAlpha];
}


/**
 导航条背景颜色
 */
-(void)setBarBackgroudColor:(UIColor *)barBackgroudColor{
    _barBackgroudColor = barBackgroudColor;
    
    _navigationBar.backgroundColor = barBackgroudColor;
}
/**
 导航条背景透明度
 */
-(void)setBarBackgroundAlpha:(CGFloat)barBackgroundAlpha{
    _barBackgroundAlpha = barBackgroundAlpha;

    self.navigationBar.backgroundColor = [self.navigationBar.backgroundColor colorWithAlphaComponent:barBackgroundAlpha];
}

/**
 导航栏背景图片
 */
-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    
    _naviBackgroundImageView.image = backgroundImage;
}

-(void)setBackgroundAlpha:(CGFloat)backgroundAlpha{
    _backgroundAlpha = backgroundAlpha;
    
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:backgroundAlpha];
}

/**
 导航栏标题
 */
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    
    CGFloat lab_w = _titleLabel.frame.size.width;
    CGFloat lab_h = _titleLabel.frame.size.height;
    CGFloat lab_x = (_navigationBar.frame.size.width - lab_w)*0.5;
    CGFloat lab_y = (_navigationBar.frame.size.height - lab_h)*0.5;
    _titleLabel.frame = CGRectMake(lab_x, lab_y, lab_w, lab_h);
    
}
/**
 导航栏标题颜色
 */
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    
    _titleLabel.textColor = titleColor;
}


/**
 导航栏标题view
 */
-(void)setTitleView:(UIView *)titleView{
    _titleView = titleView;
    
    CGFloat view_w = titleView.frame.size.width;
    CGFloat view_h = titleView.frame.size.height;
    CGFloat view_x = (_navigationBar.frame.size.width - view_w)*0.5;
    CGFloat view_y = (_navigationBar.frame.size.height - view_h)*0.5;
    titleView.frame = CGRectMake(view_x, view_y, view_w, view_h);
    [self.navigationBar addSubview:titleView];
    
}



/**
 左边单个按钮
 */
-(void)setLeftBarButtonItem:(UIView *)leftBarButtonItem{
    _leftBarButtonItem = leftBarButtonItem;
    [leftBarButtonItem sizeToFit];
    CGFloat width = leftBarButtonItem.frame.size.width;
    CGFloat height = leftBarButtonItem.frame.size.height;
    CGFloat x = KSpace;
    CGFloat y = (_navigationBar.frame.size.height - height) * 0.5;

    leftBarButtonItem.frame = CGRectMake(x, y, width, height);
    [_navigationBar addSubview:leftBarButtonItem];

}
/**
 左边多个按钮
 */
-(void)setLeftBarButtonItems:(NSArray *)leftBarButtonItems{
    _leftBarButtonItems = leftBarButtonItems;
    
    for (NSInteger i = 0; i < leftBarButtonItems.count; i++) {
        UIView *leftView = leftBarButtonItems[i];
        [leftView sizeToFit];
        
        CGFloat width = leftView.frame.size.width;
        CGFloat height = leftView.frame.size.height;
        CGFloat x = 0.0;
        if (i == 0) {
            x = KSpace;
        }else{
            x = (CGRectGetMaxX(_previousLeftView.frame)+8);
        }
        CGFloat y = (_navigationBar.frame.size.height - height) * 0.5;
        
        leftView.frame = CGRectMake(x, y, width, height);
        [_navigationBar addSubview:leftView];
        
         _previousLeftView = leftView;
       
        
        
    }
    
}


/**
 右边单个按钮
 */
-(void)setRightBarButtonItem:(UIView *)rightBarButtonItem{
    _rightBarButtonItem = rightBarButtonItem;
    [rightBarButtonItem sizeToFit];
    CGFloat width = rightBarButtonItem.frame.size.width;
    CGFloat height = rightBarButtonItem.frame.size.height;
    CGFloat x = _navigationBar.frame.size.width - KSpace - width;
    CGFloat y = (_navigationBar.frame.size.height - height) * 0.5;
    
    rightBarButtonItem.frame = CGRectMake(x, y, width, height);
    [_navigationBar addSubview:rightBarButtonItem];

}
/**
 右边多个按钮
 */
-(void)setRightBarButtonItems:(NSArray *)rightBarButtonItems{
    _rightBarButtonItems = rightBarButtonItems;
    for (NSInteger i = 0; i < rightBarButtonItems.count; i++) {
        UIView *rightView = rightBarButtonItems[i];
        [rightView sizeToFit];
        
        CGFloat width = rightView.frame.size.width;
        CGFloat height = rightView.frame.size.height;
        CGFloat x = 0.0;
        if (i == 0) {
            x = _navigationBar.frame.size.width - KSpace - width;
        }else{
            x = _previousRightView.frame.origin.x - 16 - width;
        }
        CGFloat y = (_navigationBar.frame.size.height - height) * 0.5;
        
        rightView.frame = CGRectMake(x, y, width, height);
        [_navigationBar addSubview:rightView];
    
        _previousRightView = rightView;
    }
}



@end
