//
//  ZJLSheetView.m
//
//  Created by Mr郑 on 2017/6/24.
//  Copyright © 2017年 Mr郑. All rights reserved.
//
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width  //  设备的宽度

#define ScreenHeight [UIScreen mainScreen].bounds.size.height //   设备的高度

#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define COLOR5 [UIColor colorWithRed:238/255.00f green:238/255.00f blue:238/255.00f alpha:1.0]

#import "ZJLSheetView.h"

@interface ZJLSheetView()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic, weak) id<zjlSheetViewDelegate> delegate;
@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation ZJLSheetView

-(instancetype)initWithContentArray:(NSArray *)contenArray delegate:(id)delegate{
    if (self=[super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor=WINDOW_COLOR;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancle:)]];
        self.delegate=delegate;
        self.contentArray=contenArray;
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 180)];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backGroundView];
    
    for (int i=0;i<self.contentArray.count;i++ ) {
        if (i<self.contentArray.count) {
            
            UIButton* button = [[UIButton alloc] init];
            if (i==self.contentArray.count-1) {
                button.frame = CGRectMake(0, 45*i, ScreenWidth, 44);
            }else{
                button.frame = CGRectMake(0, 45*i, ScreenWidth, 44);
            }
            
            if (self.contentArray) {
                NSString *buttonTitle=self.contentArray[i];
                if (![buttonTitle isEqual:[NSNull null]]) {
                    [button setTitle:buttonTitle forState:UIControlStateNormal];
                }
            }
            button.tag=i+1;
            [button setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.backGroundView addSubview:button];
            
            if (i == self.contentArray.count-1) {
                
                UIView *sepView2 = [[UIView alloc] initWithFrame:CGRectMake(0, i*44, ScreenWidth, 1)];
                sepView2.backgroundColor = [UIColor lightGrayColor];
                [self.backGroundView addSubview:sepView2];
            }else{
                
                UIView *sepView2 = [[UIView alloc] initWithFrame:CGRectMake(0, i*44, ScreenWidth, 1)];
                sepView2.backgroundColor = COLOR5;
                [self.backGroundView addSubview:sepView2];
            }
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-45*self.contentArray.count, [UIScreen mainScreen].bounds.size.width, self.contentArray.count*45)];
    } completion:^(BOOL finished) {
    }];
}


/*选择计划外随访类型的选择框*/
- (void)show {
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
}

/*隐藏计划外随访类型的选择框*/
- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.contentArray.count*45)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*取消按钮*/
//- (void)cancleAction
//{
//    [self hide];
//}

/*点击按钮*/
-(void)clickButton:(id)sender {
    UIButton *button=(UIButton *)sender;
    NSInteger tag=button.tag;
    if (self.delegate !=nil &&[self.delegate respondsToSelector:@selector(zjlSheetView:selectTag:)]) {
        [self.delegate zjlSheetView:self selectTag:tag];
        [self hide];
    }
}

/*点击取消灰色部分*/
-(void)tapCancle:(id)sender {
    [self hide];
}

@end
