//
//  Weather.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "Weather.h"
#import "AFNetworking.h"

static Weather * lastWeather = nil;
static NSTimeInterval lastUpdatedTimeInterval = 0;

#define MINUMUN_TIME_TO_NEXT_CALL 3600

@implementation Weather

+(void)currentWeatherForLat:(double)lat long:(double)lng OnCompletion:(void (^)(Weather *))block {
    
    if (block && lastWeather) {
        block(lastWeather);
    }
    
    //Check if the last call was less than one hour ago for preventing api over usage
    NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
    if (currentInterval - lastUpdatedTimeInterval < MINUMUN_TIME_TO_NEXT_CALL) {
        return;
    }
    
    NSString * endPoint = [NSString stringWithFormat:@"http://api.wunderground.com/api/3b480cc6a0939128/conditions/forecast/alert/q/%f,%f.json", lat, lng];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        Weather * currentWeather = nil;
        NSDictionary * response = responseObject[@"current_observation"];
        if (response) {
            
            currentWeather = [[Weather alloc] init];
            currentWeather.temperature = @([response[@"temp_c"] intValue]);
            currentWeather.temperature_f = @([response[@"temp_f"] intValue]);
            currentWeather.weatherType = response[@"weather"];
            
            NSString * icon = response[@"icon"];
            [currentWeather fillImageNameInfoForIcon:icon];
        }
        
        if (block) {
            
            lastWeather = currentWeather;
            lastUpdatedTimeInterval = [[NSDate date] timeIntervalSince1970];
            block (lastWeather);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (lastWeather) {
            block (nil);
        }
        
    }];
}

-(void)fillImageNameInfoForIcon:(NSString *)icon {
    
    if ([icon isEqualToString:@"chanceflurries"]) {
        
        self.iconName = @"raining_icon.png";
        self.iconSmallName = @"raining_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"chancerain"]) {
        
        self.iconName = @"snow_icon.png";
        self.iconSmallName = @"snow_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"chancesleet"]) {
        
        self.iconName = @"sleet_icon.png";
        self.iconSmallName = @"sleet_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"chancesnow"]) {
        
        self.iconName = @"snow_icon.png";
        self.iconSmallName = @"snow_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"chancetstorms"]) {
        
        self.iconName = @"raining_icon.png";
        self.iconSmallName = @"raining_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"clear"]) {
        
        self.iconName = @"sunny_icon.png";
        self.iconSmallName = @"sunny_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"cloudy"]) {
        
        self.iconName = @"cloudy_icon.png";
        self.iconSmallName = @"cloudy_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"flurries"]) {
        
        self.iconName = @"snow_icon.png";
        self.iconSmallName = @"snow_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"fog"]) {
        
        self.iconName = @"fog_icon.png";
        self.iconSmallName = @"fog_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"hazy"]) {
        
        self.iconName = @"wind_icon.png";
        self.iconSmallName = @"wind_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"mostlycloudy"]) {
        
        self.iconName = @"partly_cloudy_icon.png";
        self.iconSmallName = @"partly_cloudy_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"mostlysunny"]) {
        
        self.iconName = @"sunny_icon.png";
        self.iconSmallName = @"sunny_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"partlycloudy"]) {
        
        self.iconName = @"partly_cloudy_icon.png";
        self.iconSmallName = @"partly_cloudy_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"partlysunny"]) {
        
        self.iconName = @"partly_cloudy_icon.png";
        self.iconSmallName = @"partly_cloudy_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"sleet"]) {
        
        self.iconName = @"sleet_icon.png";
        self.iconSmallName = @"sleet_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"rain"]) {
        
        self.iconName = @"raining_icon.png";
        self.iconSmallName = @"raining_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"snow"]) {
        
        self.iconName = @"snow_icon.png";
        self.iconSmallName = @"snow_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"sunny"]) {
        
        self.iconName = @"clear_icon.png";
        self.iconSmallName = @"clear_icon_small.png";
        
    }
    else if ([icon isEqualToString:@"tstorms"]) {
        
        self.iconName = @"raining_icon.png";
        self.iconSmallName = @"raining_icon_small.png";
        
    }
}


@end
