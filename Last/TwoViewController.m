//
//  TwoViewController.m
//  Last
//
//  Created by Mr郑 on 2017/6/27.
//  Copyright © 2017年 Mr郑. All rights reserved.
//

#define itemW (KScreenW-150)/4

#import "TwoViewController.h"
#import "ZJLTool.h"
#import "ZJLTextField.h"


@interface TwoViewController ()<ZJLTextFieldDelegate>

@property (strong, nonatomic) ZJLTextField* tf1;
@property (strong, nonatomic) ZJLTextField* tf2;
@property (strong, nonatomic) ZJLTextField* tf3;
@property (strong, nonatomic) ZJLTextField* tf4;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tf1 = [self getMyTextFieldWithX:30 WithTag:10];
    [self.view addSubview:self.tf1];
    [self.tf1 becomeFirstResponder];
    self.tf2 = [self getMyTextFieldWithX:60+itemW WithTag:11];
    [self.view addSubview:self.tf2];
    self.tf3 = [self getMyTextFieldWithX:90+2*itemW WithTag:12];
    [self.view addSubview:self.tf3];
    self.tf4 = [self getMyTextFieldWithX:120+3*itemW WithTag:13];
    [self.view addSubview:self.tf4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMethod) name:UITextFieldTextDidChangeNotification object:nil];
}

- (ZJLTextField*)getMyTextFieldWithX:(NSInteger)x WithTag:(NSInteger)tag{
    
    ZJLTextField* tf = [[ZJLTextField alloc] initWithFrame:CGRectMake(x, 150, itemW, itemW)];
    tf.zjlDelegate = self;
    tf.tag = tag;
    tf.textAlignment = NSTextAlignmentCenter;
    tf.tintColor = [UIColor clearColor];
    tf.backgroundColor = [UIColor lightGrayColor];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    return tf;
}

- (void)zjlTextFieldDidDeleteWithTF:(ZJLTextField*)zjlTF{
    
    if (zjlTF.tag==10) {
        
    }else if (zjlTF.tag==11){
        
        self.tf1.text = nil;
        [self.tf1 becomeFirstResponder];
    }else if (zjlTF.tag==12){
        
        self.tf2.text = nil;
        [self.tf2 becomeFirstResponder];
    }else if (zjlTF.tag==13){
        
        self.tf3.text = nil;
        [self.tf3 becomeFirstResponder];
    }
}

- (void)notificationMethod{
    
    if (self.tf1.text.length==1){
        
        [self.tf2 becomeFirstResponder];
    }else if (self.tf1.text.length>1){
        
        self.tf1.text = [self.tf1.text substringFromIndex:1];
        [self.tf2 becomeFirstResponder];
    }
    
    if (self.tf2.text.length==1) {
        
        [self.tf3 becomeFirstResponder];
    }else if (self.tf2.text.length>1){
        
        self.tf2.text = [self.tf2.text substringFromIndex:1];
        [self.tf3 becomeFirstResponder];
    }
    
    if (self.tf3.text.length==1) {
        
        [self.tf4 becomeFirstResponder];
    }else if (self.tf3.text.length>1){
        
        self.tf3.text = [self.tf3.text substringFromIndex:1];
        [self.tf4 becomeFirstResponder];
    }
    
    if (self.tf1.text.length==0) {
        
        [self.tf1 becomeFirstResponder];
    }else if (self.tf2.text.length==0){
        
        [self.tf2 becomeFirstResponder];
    }else if (self.tf3.text.length==0){
        
        [self.tf3 becomeFirstResponder];
    }else if (self.tf4.text.length==0){
        
        [self.tf4 becomeFirstResponder];
    }
    
    if (self.tf1.text.length==1 && self.tf2.text.length==1 && self.tf3.text.length==1 && self.tf4.text.length==1) {
        
        [self.view endEditing:YES];
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"加载中...";
        hud.animationType = MBProgressHUDAnimationZoom;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            sleep(5);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}


@end
