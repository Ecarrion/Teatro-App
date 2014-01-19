//
//  FoodCell.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/8/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TOP_CELL_SPACING 32
#define BOTTOM_CELL_SPACING 4
#define CELL_MINIMUN_HEIGHT 124
#define CELL_DESCRIPTION_FONT [UIFont fontWithName:@"HelveticaNeue" size:16]
#define CELL_DESCRIPTION_MAX_SIZE CGSizeMake (461, 9999)
#define CELL_DESCRIPTION_STANDAD_RECT CGRectMake (181, 32, 461, 86)

@class FoodCell;

@protocol FoodCellDelegate <NSObject>

-(void)expandButtonPessed:(FoodCell *)cell;

@end


@interface FoodCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *dishLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandButton;
@property (weak, nonatomic) id <FoodCellDelegate> delegate;

@end


