//
//  CoreText_VC.m
//  House
//
//  Created by wang shiwen on 16/4/15.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "CoreText_VC.h"
#import "CoreTextView.h"

@interface CoreText_VC ()

@end

@implementation CoreText_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CoreTextView *view = [[CoreTextView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
