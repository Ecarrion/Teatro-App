//
//  FoursquareManager.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityLocation.h"

typedef enum {
    
    kRestaurant,
    kCafe,
    kBar,
    kTheater
    
}CityObjectType;

@interface FoursquareManager : NSObject

+(void)cityObject:(CityObjectType )objectType onCompletion:(void(^)(NSError * error, NSArray * locations))block;

@end
