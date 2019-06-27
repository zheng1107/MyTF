//
//  ZJLSheetView.h
//
//  Created by Mr郑 on 2017/6/24.
//  Copyright © 2017年 Mr郑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJLSheetView;
@protocol zjlSheetViewDelegate <NSObject>

-(void)zjlSheetView:(ZJLSheetView* )sheetView selectTag:(NSInteger )index;

@end

@interface ZJLSheetView : UIView

-(instancetype)initWithContentArray:(NSArray *)contenArray delegate:(id)delegate;
-(void)show;
-(void)hide;


@end
