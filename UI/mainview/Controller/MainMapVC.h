//
//  MainMapVC.h
//  House
//
//  Created by wang shiwen on 15/8/28.
//  Copyright (c) 2015年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomViewController.h"
#import "BMapKit.h"

@interface MainMapVC : CustomViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>{
    
    IBOutlet BMKMapView* _mapView;
    
    BMKLocationService* _locService;
    
}

-(IBAction)startLocation:(id)sender;

@end
