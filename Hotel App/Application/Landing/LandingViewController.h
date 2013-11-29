//
//  LandingViewController.h
//  Hotel App
//
//  Created by Ernesto Carrión on 11/18/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingViewController : UIViewController {
    
    __weak IBOutlet UILabel *clockLabel;
    __weak IBOutlet UILabel *weatherLabel;
    
    
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsArray;


@end
