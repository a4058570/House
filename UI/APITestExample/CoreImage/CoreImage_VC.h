//
//  CoreImage_VC.h
//  House
//
//  Created by wang shiwen on 16/4/18.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreImage_VC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;

- (IBAction)applyFilter:(id)sender;
- (IBAction)resetImage;

@end
