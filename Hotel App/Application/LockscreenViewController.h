//
//  LandingViewController.h
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockscreenViewController : UIViewController {
    
    __weak IBOutlet UILabel *clockLabel;
    __weak IBOutlet UILabel *tempLabel;
    __weak IBOutlet UILabel *dateLabel;
    
    __weak IBOutlet UIImageView *iconLabel;
    __weak IBOutlet UILabel *tem_f_label;
    __weak IBOutlet UILabel *temp_c_label;
    __weak IBOutlet UIImageView *tempIconLabel;
    
    __weak IBOutlet UISlider *landingSlider;
    
}

@end
