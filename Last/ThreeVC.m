//
//  ThreeVC.m
//  Last
//
//  Created by Mr郑 on 2018/12/20.
//  Copyright © 2018年 Mr郑. All rights reserved.
//

#import "ThreeVC.h"
#import "ZJLTool.h"


@interface ThreeVC ()

@property (weak, nonatomic) IBOutlet UILabel *la;


@end

@implementation ThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)testMethod:(id)sender {
    
    self.la.backgroundColor = RandomColor;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
