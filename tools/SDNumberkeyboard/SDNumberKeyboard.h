






#import <UIKit/UIKit.h>

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                 //屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                //屏幕长度

typedef NS_ENUM(NSUInteger, SDKeyBoardInputType) {
    SDKeyBoardIntInputType,        // 整数键盘
    SDKeyBoardFloatInputType,      // 浮点数键盘
    SDKeyBoardIDCardInputType,     // 身份证键盘
};

@interface SDNumberKeyboard : UIView

@property (nonatomic, weak) UITextField<UITextInput> *textInput;
@property (nonatomic, assign) SDKeyBoardInputType inputType;        // 键盘类型
@property (nonatomic, strong) NSNumber *interval;           // 每隔多少个数字空一格

- (id)initWithInputType:(SDKeyBoardInputType)inputType;


@end
