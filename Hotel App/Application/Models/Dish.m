//
//  Dish.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/11/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "Dish.h"

@implementation Dish


- (id)initWithJsonDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        self.name = dic[@"dish_name"];
        self.description = dic[@"dish_description"];
        self.price = dic[@"dish_price"];
    }
    
    return self;
}

+(void)allDishesonCompletion:(void(^)(NSArray * breakfastDishes, NSArray * lunchDishes, NSArray * dinnerDishes))block {
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"dining" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary * diningDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSMutableArray * mutableBreakfast = nil;
    NSMutableArray * mutableLunch = nil;
    NSMutableArray * mutableDinner = nil;
    
    if (diningDic) {
        
        NSArray * dishes = diningDic[@"breakfast"];
        for (NSDictionary * dishData in dishes) {
            
            Dish * dish = [[Dish alloc] initWithJsonDic:dishData];
            dish.type = BreakfastType;
            
            [mutableBreakfast addObject:dish];
            
        }
        
        
        dishes = diningDic[@"lunch"];
        for (NSDictionary * dishData in dishes) {
            
            Dish * dish = [[Dish alloc] initWithJsonDic:dishData];
            dish.type = LunchType;
            
            [mutableLunch addObject:dish];
            
        }
        
        dishes = diningDic[@"dinner"];
        for (NSDictionary * dishData in dishes) {
            
            Dish * dish = [[Dish alloc] initWithJsonDic:dishData];
            dish.type = DinnerType;
            
            [mutableDinner addObject:dish];
            
        }
    }
    
    if (block) {
        
        block (mutableBreakfast.copy, mutableLunch.copy, mutableDinner.copy);
    }
}


@end
