//
//  HoleyView.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/15/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "HoleyRightPanelView.h"

@implementation HoleyRightPanelView

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    UIImage * image = [UIImage imageNamed:@"right-blurry.png"];
    [image drawInRect:rect];
    
    [[UIColor clearColor] setFill];
    UIRectFill(CGRectMake(0, 50, 650, 2));
}


@end
