






#import "SDNumberKeyboard.h"
#import "SDKeyboardNumberCell.h"


@interface SDNumberKeyboard ()<UIKeyInput,UICollectionViewDelegate,
                                UICollectionViewDataSource,
                            SDKeyboardNumberCellDelegate>



/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** flowlayout */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


/** bottom view */
@property (nonatomic, strong) UIView *bottomView;
/** delete */
@property (nonatomic, strong) UIButton *deleteButton;
/** finish */
@property (nonatomic, strong) UIButton *finishButton;

/** 数组 */
@property (nonatomic, strong) NSArray *numbersArray;


@end

@implementation SDNumberKeyboard

- (instancetype)initWithInputType:(SDKeyBoardInputType)inputType{
  
    if(self = [super init]){
        
        _numbersArray = @[@"1",@"0",@".",@"5",
                          @"9",@"4",@"2",@"8",
                          @"3",@"X",@"7",@"6"
                          ];

        self.frame = CGRectMake(0, 0, SYS_DEVICE_WIDTH, 216);
        self.backgroundColor = KeyBoard_RGB(204, 204, 204);

        
        [self addSubview:self.collectionView];
        [self addSubview:self.bottomView];
        

        self.inputType = inputType;
    }
    
    return self;
}

- (void)setInterval:(NSNumber *)interval{
    
    _interval = interval;
}

- (void)setInputType:(SDKeyBoardInputType)inputType{

    _inputType = inputType;
    
    switch (inputType)
    {
        // 浮点数键盘
        case SDKeyBoardFloatInputType:
        {
            
            _numbersArray = @[@"1",@"0",@".",@"5",
                              @"9",@"4",@"2",@"8",
                              @"3",@"",@"7",@"6"
                              ];
            
            [self.collectionView reloadData];

            break;
        }
        // 身份证键盘
        case SDKeyBoardIDCardInputType:
        {
            
            _numbersArray = @[@"1",@"0",@"",@"5",
                              @"9",@"4",@"2",@"8",
                              @"3",@"X",@"7",@"6"
                              ];
            [self.collectionView reloadData];

            break;
        }
        // 数字键盘
        default:
        {
            
            _numbersArray = @[@"1",@"0",@"",@"5",
                              @"9",@"4",@"2",@"8",
                              @"3",@"",@"7",@"6"
                              ];
            [self.collectionView reloadData];

            break;
        }
    }
}





- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout)
    {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 0.5;
        _flowLayout.minimumLineSpacing = 0.5;
        
    }
    return _flowLayout;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 170) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.delaysContentTouches = NO;
        //注册cell
        [_collectionView registerClass:[SDKeyboardNumberCell class] forCellWithReuseIdentifier:@"keyboardCellId"];
        
    }
    return _collectionView;
}


#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _numbersArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SDKeyboardNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"keyboardCellId" forIndexPath:indexPath];
    
    cell.btnTitle = _numbersArray[indexPath.item];
    cell.delegate = self;
    return cell;

    
}
#pragma mark - cell 大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (SYS_DEVICE_WIDTH - 0.5*4)/4;
    CGFloat height = (170 - 0.5*3)/3;
    
    return CGSizeMake(width,height);
    
    
}



-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), SYS_DEVICE_WIDTH, 216-170);
        
        
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.frame = CGRectMake(0, 0,(SYS_DEVICE_WIDTH-0.5)*0.5, _bottomView.frame.size.height);
        _deleteButton.backgroundColor = [UIColor whiteColor];
        // 设置图片
        [_deleteButton setImage:[UIImage imageNamed:@"SDNumbeKeyboard.bundle/image/keyboard_delete.png"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_deleteButton];
        
        
        _finishButton = [[UIButton alloc] init];
        _finishButton.frame = CGRectMake(CGRectGetMaxX(_deleteButton.frame)+0.5, 0,(SYS_DEVICE_WIDTH-0.5)*0.5, _bottomView.frame.size.height);
        _finishButton.backgroundColor = [UIColor whiteColor];
        // 设置图片
        [_finishButton setTitleColor:KeyBoard_RGB(0, 104, 136) forState:UIControlStateNormal];
        [_finishButton setTitle:@"确认" forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_finishButton];
        
        
    }
    return _bottomView;
}

#pragma mark - 删除
-(void)deleteButtonClick:(UIButton *)sender{
    
    // 删除
    if(self.textInput.text.length > 0)
        [self.textInput deleteBackward];
}
#pragma mark - 确认
-(void)finishButtonClick:(UIButton *)sender{
    
    // 确认
    [self.textInput resignFirstResponder];
}

-(void)keyboardNumberCell:(SDKeyboardNumberCell *)cell button:(UIButton *)button{
    
    NSString *btnTitle = button.titleLabel.text;
    
    
    // 小数点
    if ([btnTitle isEqualToString:@"."]) {
        
        if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."]){
            
            [self.textInput insertText:@"."];
        }
        
    // 身份证X
    }else if([btnTitle isEqualToString:@"X"]){
        
        if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"X"]){
            
            [self.textInput insertText:@"X"];
        }
    

     // 数字
    }else{
        
        [self.textInput insertText:btnTitle];
        
        if(self.interval && (self.textInput.text.length+1) % ([self.interval integerValue] + 1) == 0){
            [self.textInput insertText:@" "];
        }
        
    }
    

    
    
}



@end
