//
//  FoodCell.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/8/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *dishLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishDescriptionLabel;

@end


