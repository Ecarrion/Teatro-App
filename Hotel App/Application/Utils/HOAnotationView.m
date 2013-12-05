//
//  HOAnotationView.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/4/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "HOAnotationView.h"

@implementation HOAnotationView


+(HOAnotationView *)anotationWithLat:(double)lat lng:(double)lng title:(NSString *)title subtitle:(NSString *)subtitle {
    
    HOAnotationView * anonView = [[HOAnotationView alloc] init];
    anonView.coordinate = CLLocationCoordinate2DMake(lat, lng);
    anonView.title = title;
    anonView.subtitle = subtitle;
    
    
    return anonView;
    
}

@end
