//
//  CityLocation.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityLocation : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

-(id)initWithFoursquareData:(NSDictionary *)fqData;

@end
