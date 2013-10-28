//
//  RotateView.m
//  tuoyuan
//
//  Created by tyson on 13-7-9.
//  Copyright (c) 2013年 Yunda. All rights reserved.
//

#import "RotateView.h"
#import "math.h"
#import "yundaData.h"
#import "Constants.h"

@implementation RotateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        isStretched = NO;  //默认水晶是未展开的，是一个圆环的状态
        isStartSecondStretchedAnimation = NO;
        isSecondItemStrecthed = NO;
        crystalItemNum = 1;
        itemHeightArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)willRemoveSubview:(UIView *)subview
{
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
}

- (void)ShowSecondView
{
    [self showSecondViewWithItemButton:nil];
}

- (void)showSecondViewWithItemButton:(UIButton *)sender
{
    currentItemNum = sender.tag - 1;
    //若水晶还没有展开，先执行展开动画，再延时显示展开二级水晶动画
    if (!isSecondItemStrecthed) {
        isSecondItemStrecthed = YES;
        //移除一级详情视图
        if (detailMessageView) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showSecondMsg" object:nil];
            [detailMessageView removeFromSuperview];
            detailMessageView = nil;
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"Curl" context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        
        CGFloat x_move = btn[currentBtnCount].frame.origin.x - 200;
        btn[currentBtnCount].frame = CGRectMake(x_move, btn[currentBtnCount].frame.origin.y, btn[currentBtnCount].frame.size.width, btn[currentBtnCount].frame.size.height);
        
        [UIView commitAnimations];
        [self performSelector:@selector(insertSecondView) withObject:nil afterDelay:0.5];
    } else {
        [self insertSecondView];
    }
}

//显示展开二级水晶动画
- (void)insertSecondView
{
    if (secondCrystal) {
        [secondCrystal removeFromSuperview];
        secondCrystal = nil;
    }
    NSNumber *y_num = [NSNumber numberWithFloat:(itemBtn[currentItemNum].frame.origin.y + 50)];
    secondCrystal = [[SecondCrystalDetailView alloc] initWithFrame:CGRectMake(120, 120, 650, 520) CountItems:currentItemNum ItemHeightNumber:y_num];
    secondCrystal.backgroundColor = [UIColor clearColor];
    
    [self addSubview:secondCrystal];
    [self sendSubviewToBack:secondCrystal];
}

- (void)sliderClicked:(UISlider *)sender
{
    [self removeAllDetailView];
    isStretched = NO;
    if (sender.tag == 0x01) {
        if (sender.value > firstSlider_temp_value) {
            spin_angle += 0.01;
        } else {
            spin_angle -= 0.01;
        }
        firstSlider_temp_value = sender.value;
    } else if (sender.tag == 0x02){
        if (sender.value > secondSlider_temp_value) {
            step_angle += 0.05;
        } else {
            step_angle -= 0.05;
        }
        secondSlider_temp_value = sender.value;
    }
    [self setNeedsDisplay];
}

- (void)itemBtnClicked:(UIButton *)sender
{
    [self showSecondViewWithItemButton:sender];
}

- (void)addNewDetailView:(NSInteger)detailItemsNum
{
    crystalItemNum = detailItemsNum;
    //itemBtn
    for (int j = 0; j < crystalItemNum; j ++) {
        if (itemBtn[j] == nil) {
            itemBtn[j] = [UIButton buttonWithType:UIButtonTypeCustom];
            [itemBtn[j] addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [itemBtn[j] setTitle:[NSString stringWithFormat:@"名称%d",j+1] forState:UIControlStateNormal];
            itemBtn[j].backgroundColor = [UIColor clearColor];
            itemBtn[j].tag = j + 1;
            [itemBtn[j] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn[currentBtnCount] addSubview:itemBtn[j]];
        }
        CGFloat x_interval = btn[currentBtnCount].frame.size.width/2 - 45;
        CGFloat y_interval = btn[currentBtnCount].frame.size.height/detailItemsNum - 10;
        itemBtn[j].frame = CGRectMake(x_interval, 50 + j*y_interval, 100, 30);
        [itemHeightArray addObject:[NSNumber numberWithFloat:itemBtn[j].frame.origin.y]];
    }
    if (detailMessageView) {
        detailMessageView = nil;
    }
    detailMessageView = [[DetailMessageView alloc] initWithFrame:CGRectMake(100, 100, 500, 500) CountItems:crystalItemNum ItemHeightArray:itemHeightArray];
    detailMessageView.backgroundColor = [UIColor clearColor];
    [self addSubview:detailMessageView];
    [self sendSubviewToBack:detailMessageView];   //将detailMessageView放到层最后面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowSecondView) name:@"showSecondMsg" object:nil];
    
    //弹出一个弹出视图
    //    if (detail == nil) {
    //        detail = [[DetailViewController alloc] init];
    //    }
    //    if (popover == nil) {
    //        popover = [[UIPopoverController alloc] initWithContentViewController:detail];
    //    }
    //    popover.delegate = self;
    //    popover.popoverContentSize = CGSizeMake(200, 350);
    //    [popover presentPopoverFromRect:CGRectMake(400, 300, 200, 400) inView:self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (void)btnClicked:(CrystalButton *)sender
{
    //若计时器还没停止，停止计时器
    if (_activeTimer) {
        [_activeTimer invalidate];
        _activeTimer = nil;
    }
    
    //如果点击的button的角度与最前面（90度/(M_PI/2)）的角度相减的差值在0.1以内，表示点中了最前面的，此时执行下面的动画
    if (fabs(sender.rotateData.radion - M_PI/2.0) <= 0.1) {
        if (!isStretched) {
            [self showCrystalStretchAnimation:sender];
        } else {
            [self removeAllDetailView];
        }
    } else {
        //若点击的不是最前面的，并且此时水晶是展开的状态，则执行水晶展开时的移动动画,并且被点击的水晶移动到最前面
        //目前实现的动画效果分两步
        if (isStretched) {
            //第一步：若点击的不是最前面的，并且此时水晶是展开的状态，则先回复到圆环状态，并执行圆环运动动画
            [self removeAllDetailView];
            
            currentBtnCount = sender.tag - 1;
            _activeTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                            target:self
                                                          selector:@selector(handleRotateShowTimer:)
                                                          userInfo:nil
                                                           repeats:YES];
            NSRunLoop * main=[NSRunLoop currentRunLoop];
            [main addTimer:_activeTimer forMode:NSRunLoopCommonModes];
            //第二步：延迟0.2秒后执行展开的动画
            isStartSecondStretchedAnimation = YES;
        }
        else
        {
            //若点击的不是最前面的，并且此时水晶不是展开的状态，则执行圆环运动动画
            [self removeAllDetailView];
            
            currentBtnCount = sender.tag - 1;
            _activeTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                            target:self
                                                          selector:@selector(handleRotateShowTimer:)
                                                          userInfo:nil
                                                           repeats:YES];
            NSRunLoop * main=[NSRunLoop currentRunLoop];
            [main addTimer:_activeTimer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)crystalStretch
{
    isStartSecondStretchedAnimation = NO;
    for (int i = 0; i < TOTLECRYSTALNUM; i ++) {
        if (fabs(btn[i].rotateData.radion - M_PI/2.0) <= 0.1)   //遍历查找角度为M_PI/2.0的水晶（即在最前面的水晶），然后执行展开动画
        {
            [self showCrystalStretchAnimation:btn[i]];
            break;
        }
    }
}

//显示水晶展开的动画
- (void)showCrystalStretchAnimation:(CrystalButton *)sender
{
    isStretched = YES;   //设置展开标志为真
    for (int i = 0; i < TOTLECRYSTALNUM; i ++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"Curl" context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        
        //若不是最前面的水晶，则移到最上面并缩小
        if (i != sender.tag - 1) {
            CGFloat intervalx = 120;
            if (btn[i].rotateData.radion >= 0 && btn[i].rotateData.radion < M_PI/2.0)
            {
                CGRect rect = CGRectMake(intervalx*btn[i].rotateData.radion + 550, 20*btn[i].rotateData.radion + 40, btn[i].frame.size.width/2, btn[i].frame.size.height/2);
                btn[i].frame = rect;
            }
            else if (btn[i].rotateData.radion >= M_PI/2.0 && btn[i].rotateData.radion < M_PI)
            {
                CGRect rect = CGRectMake(intervalx*btn[i].rotateData.radion - 200, 100 - 20*btn[i].rotateData.radion, btn[i].frame.size.width/2, btn[i].frame.size.height/2);
                btn[i].frame = rect;
            }
            else if (btn[i].rotateData.radion >= M_PI && btn[i].rotateData.radion < M_PI*3/2.0)
            {
                CGRect rect = CGRectMake(intervalx*btn[i].rotateData.radion - 200, 100 - 20*btn[i].rotateData.radion, btn[i].frame.size.width/2, btn[i].frame.size.height/2);
                btn[i].frame = rect;
            }
            else if (btn[i].rotateData.radion >= M_PI*3/2.0 && btn[i].rotateData.radion < M_PI*2.0)
            {
                CGRect rect = CGRectMake(intervalx*btn[i].rotateData.radion - 200, 20*btn[i].rotateData.radion - 90, btn[i].frame.size.width/2, btn[i].frame.size.height/2);
                btn[i].frame = rect;
            }
        } else {
            //最前面的水晶移到中间位置并放大
            CGRect rect = CGRectMake(sender.frame.origin.x - 70, sender.frame.origin.y - 250, sender.frame.size.width*2, sender.frame.size.height*2);
            sender.frame = rect;
            [self addNewDetailView:6];
        }
        [UIView commitAnimations];
    }
}

- (void)removeAllDetailView
{
    //将水晶上的button的文字移除掉
    for (int j = 0; j < crystalItemNum; j ++) {
        if (itemBtn[j]) {
            [itemBtn[j] removeFromSuperview];
            itemBtn[j] = nil;
        }
    }
    if (secondCrystal) {
        [secondCrystal removeFromSuperview];
        secondCrystal  = nil;
    }
    if (detailMessageView) {
        [detailMessageView removeFromSuperview];
        detailMessageView = nil;
    }
    [self crystalRevertAnimation];
}

//水晶回复到原来的样子
- (void)crystalRevertAnimation
{
    isSecondItemStrecthed = NO;
    isStretched = NO;  //设置水晶展开状态为假
    for (int i = 0; i < TOTLECRYSTALNUM; i ++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"Curl" context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        
        CGFloat widthandheight = 80*EYESIGHT_DIS/fabs(EYESIGHT_DIS - btn[i].rotateData.z);  //宽高
        btn[i].frame = CGRectMake(400 + btn[i].rotateData.x - widthandheight/2, 250 + btn[i].rotateData.y - widthandheight/2, widthandheight, widthandheight*2);
        
        [UIView commitAnimations];
    }
}

- (void)handleRotateShowTimer:(NSTimer *)sender
{
    CGFloat tempAngle = (M_PI/2.0 - btn[currentBtnCount].rotateData.radion);
    if (fabs(tempAngle) > 0.1) {
        //角度值超过2*M_PI之后，减掉2*M_PI
        if (fabs(tempAngle) > 2*M_PI || fabs(step_angle) > 2*M_PI) {
            if (fabs(tempAngle) > 2*M_PI ) {
                tempAngle = (fabs(tempAngle) - 2*M_PI)*(tempAngle > 0 ? 1: -1);
            }
            step_angle = (fabs(step_angle) - 2*M_PI)*(step_angle > 0 ? 1: -1);
        }
        //实现0-180度时顺时针转，180-360度逆时针转的动画
        step_angle += ((tempAngle >= 0 || (tempAngle >= -M_PI*3/2.0 && tempAngle < -M_PI))?1:-1)*0.1;
        [self setNeedsDisplay];
    } else {
        //动画完成之后停止计时器
        [sender invalidate];
        if (isStartSecondStretchedAnimation) {
            [self performSelector:@selector(crystalStretch) withObject:nil afterDelay:0.2];
        }
    }
    NSLog(@"tempAngle = %f,step_angle = %f",tempAngle,step_angle);
}

- (void)layoutSubviews
{
    //添加两个UISlider，控制水晶的三维动画
    if (firstSlider == nil) {
        firstSlider = [[UISlider alloc] initWithFrame:CGRectMake(650, 570, 200, 50)];
        [firstSlider addTarget:self action:@selector(sliderClicked:) forControlEvents:UIControlEventValueChanged];
        firstSlider.tag = 0x02;
        firstSlider.minimumValue = 0.0;//下限
        firstSlider.maximumValue = 50.0;//上限
        firstSlider.value = 0.0;
        firstSlider_temp_value = firstSlider.value;
        [self addSubview:firstSlider];
    }
    if (secondSlider == nil) {
        secondSlider = [[UISlider alloc] initWithFrame:CGRectMake(650, 630, 200, 50)];
        [secondSlider addTarget:self action:@selector(sliderClicked:) forControlEvents:UIControlEventValueChanged];
        secondSlider.tag = 0x01;
        secondSlider.minimumValue = 0.0;//下限
        secondSlider.maximumValue = 50.0;//上限
        secondSlider.value = 0.0;
        secondSlider_temp_value = secondSlider.value;
        //让slider旋转90度
        //        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2.0);
        //        secondSlider.transform = rotation;
        
        [self addSubview:secondSlider];
    }
}

- (void)drawRect:(CGRect)rect
{
    //绘制一个椭圆
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGRect aRect= CGRectMake(80, 80, 560, 300);
    //    CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
    //    CGContextSetLineWidth(context, 3.0);
    //    CGContextAddEllipseInRect(context, aRect);
    //    CGContextDrawPath(context, kCGPathStroke);
    
    [self setCircleAnimation:RADIUS TotleCellNum:TOTLECRYSTALNUM Step_Angle:step_angle Spin_Angle:(spin_angle + 0.1)];
}

- (void)setCircleAnimation:(CGFloat)radius          //大圆的半径
              TotleCellNum:(NSInteger)totleCellNum  //大圆上水晶的总数
                Step_Angle:(CGFloat)step_Angle      //每次计数转过的角度
                Spin_Angle:(CGFloat)spin_Angle      //向屏幕内翻转的角度,若为0则显示为平面的
{
    for (int i = 0; i < totleCellNum; i ++) {
        if (btn[i] == nil) {
            btn[i] = [CrystalButton buttonWithType:UIButtonTypeCustom];
            [btn[i] addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn[i].tag = i+1;
            [btn[i] setBackgroundImage:[UIImage imageNamed:@"pic.png"] forState:UIControlStateNormal];
            btn[i].backgroundColor = [UIColor clearColor];
            [btn[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:btn[i]];
        }
        if (btn[i].rotateData == nil) {
            btn[i].rotateData = [[RotateData alloc] init];
        }
        btn[i].rotateData.radion = 2.0*M_PI*(totleCellNum - i)/(totleCellNum + .0) + step_Angle - M_PI*3/2.0;  //step_angle是旋转的角度
        
        //重新设置角度的大小，确保radion的范围在0-2*M_PI之间
        int mod = btn[i].rotateData.radion/(2.0*M_PI);
        if (btn[i].rotateData.radion < 0) {
            btn[i].rotateData.radion -= (mod - 1)*2.0*M_PI;
        } else if (btn[i].rotateData.radion >= 0) {
            btn[i].rotateData.radion -= mod*2.0*M_PI;
        }
        
        [btn[i] setTitle:[NSString stringWithFormat:@"%d",/*btn[i].rotateData.radion*/i+1] forState:UIControlStateNormal];
        CGFloat x = radius*cos(btn[i].rotateData.radion);
        //        btn[i].rotateData.x = radius*cos(btn[i].rotateData.radion);
        btn[i].rotateData.y = radius*sin(btn[i].rotateData.radion)*cos(2.0*M_PI*spin_Angle);
        btn[i].rotateData.z = radius*sin(btn[i].rotateData.radion)*sin(2.0*M_PI*spin_Angle);  //计算视图大小的z坐标
        btn[i].rotateData.x = x + (x*(btn[i].rotateData.z)/(EYESIGHT_DIS + btn[i].rotateData.z));
        CGFloat widthandheight = 80*EYESIGHT_DIS/fabs(EYESIGHT_DIS - btn[i].rotateData.z);  //宽高
        btn[i].frame = CGRectMake(400 + btn[i].rotateData.x - widthandheight/2, 250 + btn[i].rotateData.y - widthandheight/2, widthandheight, widthandheight*2);
    }
    //由于描画的先后顺序导致两边的水晶遮挡效果不合理，故在下面进行微调
    for (int i = 0; i < totleCellNum; i ++) {
        if (btn[i].rotateData.radion <= 2*M_PI/TOTLECRYSTALNUM) {
            if (i == TOTLECRYSTALNUM - 1) {
                [self sendSubviewToBack:btn[i]];  //将该视图放到视图层的最前面
                [self sendSubviewToBack:btn[0]];
            } else {
                [self sendSubviewToBack:btn[i]];
                [self sendSubviewToBack:btn[i + 1]];
            }
        } else if (btn[i].rotateData.radion <= M_PI) {
            if (i == TOTLECRYSTALNUM - 1) {
                [self bringSubviewToFront:btn[i]];  //将该视图放到视图层的最后面
                [self bringSubviewToFront:btn[0]];
            } else {
                [self bringSubviewToFront:btn[i]];
                [self bringSubviewToFront:btn[i + 1]];
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end

@implementation RotateData

@synthesize x,y,z,rotate_angle,radion;

- (void)draw
{
    
}

@end

@implementation CrystalButton
@synthesize rotateData;

@end

@implementation DetailViewController

- (id)init
{
    if (self = [super init]) {
        detailTable = [[UITableView alloc] init];
        detailTable.delegate = self;
        detailTable.dataSource = self;
        [self.view addSubview:detailTable];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    detailTable.frame = CGRectMake(5, 5, 200, 320);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"detailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"selected = %d",[indexPath row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
@end