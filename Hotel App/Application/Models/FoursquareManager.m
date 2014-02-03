//
//  FoursquareManager.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "FoursquareManager.h"
#import "AFNetworking.h"

@implementation FoursquareManager

+(void)cityObject:(CityObjectType)objectType onCompletion:(void (^)(NSError *, NSArray *))block {
    
    NSString * categoryID = @"";
    NSString * type = @"";
    NSString * radius = @"0";
    
    switch (objectType) {
            
        case kRestaurant: {
            
            categoryID = @"4bf58dd8d48988d1c4941735";
            type = @"restaurant";
            radius = @"3000";
            
            break;
        }
            
        case kCafe: {
            
            categoryID = @"4bf58dd8d48988d16d941735";
            type = @"cafe";
            radius = @"3000";
            
            break;
        }
            
        case kBar: {
            
            categoryID = @"4bf58dd8d48988d116941735";
            type = @"bar";
            radius = @"3000";
            
            break;
        }
            
        case kTheater: {
            
            categoryID = @"4bf58dd8d48988d137941735";
            type = @"theater";
            radius = @"3000";
            
            break;
        }
            
        default:
            break;
    }
    
    NSString * endPoint = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=5QP2LIEQLOUSYUJILXBOLK5YG3DZFU2N3O1ADFP3VJBRW2V1&client_secret=YEB1ZU2KG41UFHCP2ZQOYVFNHGBZS2CHFL1QFXSDM4PXBMYG&radius=%@&categoryId=%@&q=%@&ll=%f,%f&v=20140202", radius, categoryID, type, HOTEL_LATITUDE, HOTEL_LONGITUDE];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSMutableArray * locations = [NSMutableArray array];
        NSError * error = nil;
        
        NSArray * items = responseObject[@"response"][@"venues"];
        [items enumerateObjectsUsingBlock:^(NSDictionary * fqData, NSUInteger idx, BOOL *stop) {
            
            [locations addObject:[[CityLocation alloc] initWithFoursquareData:fqData]];
            
            if (idx >= 10)
                *stop = YES;
        
        }];
        
        if (block) {
            block(error, locations.copy);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block) {
            block(error, nil);
        }
    }];
}

@end
