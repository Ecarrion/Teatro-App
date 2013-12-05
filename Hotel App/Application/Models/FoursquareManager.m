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
    
    switch (objectType) {
            
        case kRestaurant: {
            
            categoryID = @"4bf58dd8d48988d1c4941735";
            type = @"restaurant";
            
            break;
        }
            
        case kCafe: {
            
            categoryID = @"4bf58dd8d48988d16d941735";
            type = @"cafe";
            
            break;
        }
            
        case kBar: {
            
            categoryID = @"4bf58dd8d48988d116941735";
            type = @"bar";
            
            break;
        }
            
        case kTheater: {
            
            categoryID = @"";
            type = @"theater";
            
            break;
        }
            
        default:
            break;
    }
    
    NSString * endPoint = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=5QP2LIEQLOUSYUJILXBOLK5YG3DZFU2N3O1ADFP3VJBRW2V1&client_secret=YEB1ZU2KG41UFHCP2ZQOYVFNHGBZS2CHFL1QFXSDM4PXBMYG&radius=4800&categoryId=%@&q=%@&ll=%f,%f", categoryID, type, HOTEL_LATITUDE, HOTEL_LONGITUDE];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSMutableArray * locations = [NSMutableArray array];
        NSError * error = nil;
        
        NSArray * items = responseObject[@"response"][@"groups"][0][@"items"];
        [items enumerateObjectsUsingBlock:^(NSDictionary * fqData, NSUInteger idx, BOOL *stop) {
            
            [locations addObject:[[CityLocation alloc] initWithFoursquareData:fqData]];
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
