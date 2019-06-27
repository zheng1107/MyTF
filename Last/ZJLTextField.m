//
//  MyTextField.m
//
//  Created by Mr郑 on 2017/6/28.
//  Copyright © 2017年 Mr郑. All rights reserved.
//

#import "ZJLTextField.h"

@implementation ZJLTextField

- (void)deleteBackward {
    [super deleteBackward];
    
    if ([_zjlDelegate respondsToSelector:@selector(zjlTextFieldDidDeleteWithTF:)]){
        [_zjlDelegate zjlTextFieldDidDeleteWithTF:self];
    }
}

@end
