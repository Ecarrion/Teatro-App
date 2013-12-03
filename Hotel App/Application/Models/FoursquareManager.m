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

+(void)cityObject:(NSString *)cityType onCompletion:(void (^)(NSError *, NSArray *))block {
    
    NSString * endPoint = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=5QP2LIEQLOUSYUJILXBOLK5YG3DZFU2N3O1ADFP3VJBRW2V1&client_secret=YEB1ZU2KG41UFHCP2ZQOYVFNHGBZS2CHFL1QFXSDM4PXBMYG&radius=4800&categoryId=4bf58dd8d48988d163941735&q=%@&ll=%@,%@", @"restaurant", @"39.550763", @"-107.32467"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSMutableArray * locations = nil;
        NSError * error = nil;
        
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
