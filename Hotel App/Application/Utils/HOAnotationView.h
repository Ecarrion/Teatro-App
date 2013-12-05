//
//  HOAnotationView.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/4/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HOAnotationView : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+(HOAnotationView *)anotationWithLat:(double)lat lng:(double)lng title:(NSString *)title subtitle:(NSString *)subtitle;

@end
