//
//  GCD_VC.m
//  House
//
//  Created by wang shiwen on 16/4/18.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import "GCD_VC.h"

@interface GCD_VC ()

@end

@implementation GCD_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //多线程
    
    //启动线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"启动子线程");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"启动主线程执行更新操作");
        });
    });
    
    //线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //线程1
    dispatch_group_async(group,queue , ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"子线程1");
    });
    //线程2
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:5.0];
        NSLog(@"子线程2");
    });
    //线程3
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"子线程3");
    });
    //完成任务通知
    dispatch_group_notify(group, queue, ^{
        NSLog(@"完成任务提示");
    });
    
    //测试只执行一次
    [self dispatch_one_fun];
    [self dispatch_one_fun];
    [self dispatch_one_fun];
    
    //线程执行多次代码
    dispatch_apply(5, queue, ^(size_t index){
        NSLog(@"批量运行程序:%zu",index);
    });
    
    
    //NSOperation 执行线程
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(operationRun:)
                                                                             object:@""];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    [operationQueue addOperation:operation];
    [operationQueue setMaxConcurrentOperationCount:5];
    
}

-(void)operationRun:(NSString *)url{
    NSLog(@"url:%@", url);
    
    [self performSelectorOnMainThread:@selector(finishOperation) withObject:nil waitUntilDone:YES];
}

-(void)finishOperation {
    NSLog(@"NSOperation 线程执行完毕.");
}


- (void)dispatch_one_fun
{
    //只执行一次
    static dispatch_once_t patchonce;
    dispatch_once(&patchonce, ^{
        NSLog(@"线程只执行一次");
    });
}

#pragma mark System Function

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
