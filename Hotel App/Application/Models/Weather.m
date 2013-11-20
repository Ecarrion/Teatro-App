//
//  Weather.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "Weather.h"
#import "AFNetworking.h"

@implementation Weather

+(void)currentWeatherForLat:(double)lat long:(double)lng OnCompletion:(void (^)(Weather *))block {
    
    NSString * endPoint = [NSString stringWithFormat:@"http://api.wunderground.com/api/3b480cc6a0939128/conditions/forecast/alert/q/%f,%f.json", lat, lng];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        Weather * currentWeather = nil;
        NSDictionary * response = responseObject[@"current_observation"];
        if (response) {
            
            currentWeather = [[Weather alloc] init];
            currentWeather.temperature = response[@"temp_c"];
            currentWeather.weatherType = responseObject[@"weather"];
        }
        
        if (block) {
            block (currentWeather);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block) {
            block (nil);
        }
        
    }];
}


@end
