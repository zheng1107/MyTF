//
//  ViewController.m
//  Last
//
//  Created by Mr郑 on 2017/6/27.
//  Copyright © 2017年 Mr郑. All rights reserved.
//

#import "ViewController.h"
#import "ZJLTool.h"
#import "ThreeVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RandomColor;
    self.btn.backgroundColor = [UIColor lightGrayColor];
    self.btn.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMethod) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)notificationMethod{
    
    if (self.phoneTF.text.length<11) {
        
        [self.phoneTF becomeFirstResponder];
    }else if (self.phoneTF.text.length==11){
        
        BOOL match = [ZJLTool valiMobile:self.phoneTF.text];
        if (match) {
            
            [self.phoneTF resignFirstResponder];
            self.btn.backgroundColor = [UIColor brownColor];
            self.btn.enabled = YES;
        }else{
            
            self.btn.backgroundColor = [UIColor lightGrayColor];
            self.btn.enabled = NO;
        }
    }else{
        
        [self.phoneTF resignFirstResponder];
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (IBAction)testBtnClicked:(UIButton *)sender {
    
    //[ZJLTool popMBProgressHUDNoticeWithHUDType:2 andNoticeStr:@"test" andInView:self.view];
    
//    ThreeVC* vc = [[ThreeVC alloc] initWithNibName:@"cccVC" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
    //[self testGlobal];
    //[self testSerier];
    //[self testXXX];
    [self testMain];
}

- (void)testGlobal{
    
    NSLog(@"...........111");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        [self test222];
        NSLog(@"---main01---%@",[NSThread currentThread]);
    });
    NSLog(@"...........222");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        [self test333];
        NSLog(@"---main02---%@",[NSThread currentThread]);
    });
    NSLog(@"...........333");
    
}

- (void)test222{
    
    NSLog(@"---AAA01---%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"---aaa01---%@",[NSThread currentThread]);
        NSLog(@"---aaa02---%@",[NSThread currentThread]);
        NSLog(@"---aaa03---%@",[NSThread currentThread]);
    });
    
    NSLog(@"---AAA02---%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"---aaa04---%@",[NSThread currentThread]);
        NSLog(@"---aaa05---%@",[NSThread currentThread]);
        NSLog(@"---aaa06---%@",[NSThread currentThread]);
    });
}

- (void)test333{
    
    NSLog(@"---BBB01---%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"---bbb01---%@",[NSThread currentThread]);
        NSLog(@"---bbb02---%@",[NSThread currentThread]);
        NSLog(@"---bbb03---%@",[NSThread currentThread]);
    });
    
    NSLog(@"---BBB02---%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"---bbb04---%@",[NSThread currentThread]);
        NSLog(@"---bbb05---%@",[NSThread currentThread]);
        NSLog(@"---bbb06---%@",[NSThread currentThread]);
    });
}

- (void)testSerier{
    
    NSLog(@"---000---%@",[NSThread currentThread]);
    dispatch_async(dispatch_queue_create("串行01", DISPATCH_QUEUE_SERIAL), ^{
        sleep(1);
        NSLog(@"---aaa01---%@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"---aaa02---%@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"---aaa03---%@",[NSThread currentThread]);
    });
    
    dispatch_async(dispatch_queue_create("串行02", DISPATCH_QUEUE_SERIAL), ^{
        sleep(1);
        NSLog(@"---aaa04---%@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"---aaa05---%@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"---aaa06---%@",[NSThread currentThread]);
    });
}

- (void)testXXX{
    dispatch_async(dispatch_queue_create("串行01", DISPATCH_QUEUE_SERIAL), ^{
        NSLog(@"1111");
        sleep(1);
        [self testYYY];
    });
}

- (void)testYYY{
    dispatch_sync(dispatch_queue_create("串行01", DISPATCH_QUEUE_SERIAL), ^{
        sleep(1);
        NSLog(@"2222");
    });
}

- (void)testMain{
    dispatch_async(dispatch_queue_create("串行01", DISPATCH_QUEUE_SERIAL), ^{
        NSLog(@"---aaa01---%@",[NSThread currentThread]);
        sleep(1);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"---aaa02---%@",[NSThread currentThread]);
        });
    });
}

@end
