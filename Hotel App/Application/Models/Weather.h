//
//  Weather.h
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSNumber * temperature;
@property (nonatomic, strong) NSNumber * temperature_f;
@property (nonatomic, strong) NSString * weatherType;
@property (nonatomic, strong) NSString * iconName;
@property (nonatomic, strong) NSString * iconSmallName;

+(void)currentWeatherForLat:(double)lat long:(double)lng OnCompletion:(void(^)(Weather * weatherInfo))block;

@end
