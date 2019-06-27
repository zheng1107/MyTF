//
//  MyTextField.h
//
//  Created by Mr郑 on 2017/6/28.
//  Copyright © 2017年 Mr郑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJLTextField;

@protocol ZJLTextFieldDelegate <NSObject>

- (void)zjlTextFieldDidDeleteWithTF:(ZJLTextField*)zjlTF;

@end

@interface ZJLTextField : UITextField<UIKeyInput>

@property (weak, nonatomic) id<ZJLTextFieldDelegate> zjlDelegate;

@end
