//
//  DiningViewController.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    kBreakfast,
    kLunch,
    kDinner
    
}FoodType;

@interface DiningViewController : UIViewController {
    
    __weak IBOutlet UITableView *foodTableView;
    __weak IBOutlet UILabel *tempLabel;
    __weak IBOutlet UIImageView *tempIcon;
    
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *segmentedButtons;


@end
