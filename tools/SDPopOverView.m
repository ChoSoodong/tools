





#import "SDPopOverView.h"

#define PopView_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define PopView_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface SDPopOverView ()


@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) SDArrowDirection direction;

@end

@implementation SDPopOverView

-(instancetype)initWithOrigin:(CGPoint)origin Width:(CGFloat)width Height:(float)height Direction:(SDArrowDirection)direction
{
    if (self = [super initWithFrame:CGRectMake(0, 0, PopView_SCREEN_WIDTH, PopView_SCREEN_HEIGHT)])
    {
        //背景颜色为无色
        self.backgroundColor=[UIColor clearColor];
        
        //定义显示视图的参数
        self.origin = origin;
        self.height = height;
        self.width = width;
        self.direction = direction;
        
        self.backView=[[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        self.backView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:1];
        self.backView.layer.cornerRadius = 3;
        self.backView.layer.masksToBounds = YES;
        [self addSubview:self.backView];
      
    
    }

    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (_direction == SDArrowDirectionLeftUp) {
        
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX+5, startY-5);
        CGContextAddLineToPoint(context, startX+5, startY+5);
    }
    else if (_direction == SDArrowDirectionLeftMiddle)
    {
    
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX+5, startY-5);
        CGContextAddLineToPoint(context, startX+5, startY+5);
    
    }
    else if (_direction == SDArrowDirectionLeftDown)
    {

        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX+5, startY-5);
        CGContextAddLineToPoint(context, startX+5, startY+5);
        
    }
    else if (_direction == SDArrowDirectionRightUp)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX-5, startY-5);
        CGContextAddLineToPoint(context, startX-5, startY+5);
        
    }
    else if (_direction == SDArrowDirectionRightMiddle)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX-5, startY-5);
        CGContextAddLineToPoint(context, startX-5, startY+5);
        
    }
    else if (_direction == SDArrowDirectionRightDown)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX-5, startY-5);
        CGContextAddLineToPoint(context, startX-5, startY+5);
        
    }
    else if (_direction == SDArrowDirectionUpLeft)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
        
    }
    else if (_direction == SDArrowDirectionUpMiddle)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
    }
    else if (_direction == SDArrowDirectionUpRight)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
        
    }
    else if (_direction == SDArrowDirectionDownLeft)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX - 5, startY -5);
        CGContextAddLineToPoint(context, startX +5, startY-5);
        
    }
    else if (_direction == SDArrowDirectionDownMiddle)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX - 5, startY -5);
        CGContextAddLineToPoint(context, startX +5, startY-5);
        
    }
    else if (_direction == SDArrowDirectionDownRight)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX - 5, startY -5);
        CGContextAddLineToPoint(context, startX +5, startY-5);
        
    }
   
    CGContextClosePath(context);
    [self.backView.backgroundColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
 

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.backView]) {
        [self dismiss];
    }
}

-(void)popView
{
    NSArray *result=[self.backView subviews];
    for (UIView *view in result) {
        
        view.hidden=YES;
        
    }
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    //动画效果弹出
    self.alpha = 0;
    
    
    if (_direction == SDArrowDirectionLeftUp) {
        self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y-20, self.width,self. height);
        }completion:^(BOOL finished) {
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
        }];
        
        
    }
    else if (_direction == SDArrowDirectionLeftMiddle)
    {
        self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y-self.height/2, self.width,self. height);

        }completion:^(BOOL finished) {
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
        }];
    }
    else if (_direction == SDArrowDirectionLeftDown)
    {
        self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y-self.height+20, self.width,self. height);
        }completion:^(BOOL finished) {
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
        }];
        
    }
    else if (_direction == SDArrowDirectionRightUp)
    {
        self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y-20, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionRightMiddle)
    {
        self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y-self.height/2, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionRightDown)
    {
        self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y-self.height+20, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionUpLeft)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-20, self.origin.y+5, self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionUpMiddle)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-self.width/2, self.origin.y+5, self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionUpRight)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+20, self.origin.y+5, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionDownLeft)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y-5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-20, self.origin.y-5, self.width,-self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionDownMiddle)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y-5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-self.width/2, self.origin.y-5, self.width,-self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction == SDArrowDirectionDownRight)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y-5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-self.width+20, self.origin.y-5, self.width,-self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }

}

-(void)dismiss{
    
    NSArray *result=[self.backView subviews];
    for (UIView *view in result) {
        
        [view removeFromSuperview];

    }
    
         //动画效果淡出
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
                 
        }
    }];
     


}

@end

