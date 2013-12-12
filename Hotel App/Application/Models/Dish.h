//
//  Dish.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/11/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    BreakfastType,
    LunchType,
    DinnerType
    
}DishType;

@interface Dish : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * description;
@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, assign) DishType type;

- (id)initWithJsonDic:(NSDictionary *)dic;
+(void)allDishesOnCompletion:(void(^)(NSArray * breakfastDishes, NSArray * lunchDishes, NSArray * dinnerDishes))block;

@end
