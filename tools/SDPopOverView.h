






#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger,SDArrowDirection){

    //箭头位置
    SDArrowDirectionLeftUp = 1,//左上
    SDArrowDirectionLeftMiddle,//左中
    SDArrowDirectionLeftDown,//左下
    
    SDArrowDirectionRightUp,//右上
    SDArrowDirectionRightMiddle,//右中
    SDArrowDirectionRightDown,//右下
    
    SDArrowDirectionUpLeft,//上左
    SDArrowDirectionUpMiddle,//上中
    SDArrowDirectionUpRight,//上右
    
    SDArrowDirectionDownLeft,//下左
    SDArrowDirectionDownMiddle,//下中
    SDArrowDirectionDownRight,//下右

};

@interface SDPopOverView : UIView

//将要显示的内容(如label img...) 添加在 backView 上
@property (nonatomic, strong) UIView *backView;

-(instancetype)initWithOrigin:(CGPoint)origin Width:(CGFloat)width Height:(float)height Direction:(SDArrowDirection)direction;//初始化

-(void)popView;//弹出视图
-(void)dismiss;//隐藏视图

@end
