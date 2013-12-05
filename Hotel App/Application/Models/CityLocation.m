//
//  CityLocation.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "CityLocation.h"

@implementation CityLocation

-(id)initWithFoursquareData:(NSDictionary *)fqData {
    
    self = [super init];
    if (self) {
        
        self.name = fqData[@"name"];
        self.address = fqData[@"location"][@"address"];
        
        self.latitude = [fqData[@"location"][@"lat"] doubleValue];
        self.longitude = [fqData[@"location"][@"lng"] doubleValue];
    }
    
    return self;
}

@end
