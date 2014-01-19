//
//  FoodCell.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/8/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

-(void)prepareForReuse {
    
    self.iconView.image = nil;
    self.dishLabel.text = @"";
    self.dishDescriptionLabel.text = @"";
}


-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (IBAction)expandButtonPressed:(id)sender {
    
    [self.delegate expandButtonPessed:self];
}


@end
