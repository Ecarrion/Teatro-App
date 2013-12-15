//
//  DiningViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "DiningViewController.h"
#import "FoodCell.h"
#import "Dish.h"

@interface DiningViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    FoodType currentFoodSection;
}

@property (nonatomic, strong) NSArray * breakfastFishes, * lunchDishes, * diningDishes;

@end

@implementation DiningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self foodSourcePressed:self.segmentedButtons.firstObject];
    [foodTableView registerNib:[UINib nibWithNibName:@"FoodCell" bundle:nil] forCellReuseIdentifier:@"FoodCell"];
    
    
    [Dish allDishesOnCompletion:^(NSArray *breakfastDishes, NSArray *lunchDishes, NSArray *dinnerDishes) {
       
        self.breakfastFishes = breakfastDishes;
        self.lunchDishes = lunchDishes;
        self.diningDishes = dinnerDishes;
        
        [foodTableView reloadData];
        
    }];
}

#pragma mark - IBAction

- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - IBAction

- (IBAction)foodSourcePressed:(id)sender {
    
    
    [self.segmentedButtons enumerateObjectsUsingBlock:^(UIButton * but, NSUInteger idx, BOOL *stop) {
        
        but.highlighted = NO;
        but.backgroundColor = [UIColor clearColor];
        
        if (but == sender) {
            currentFoodSection = idx;
            but.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        }
    }];
    
    
    [foodTableView reloadData];
}


#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int retVal = 0;
    
    switch (currentFoodSection) {
        
        case kBreakfast: {
            retVal = self.breakfastFishes.count;
            break;
        }
            
        case kLunch: {
            retVal = self.lunchDishes.count;
            break;
        }
            
        case kDinner: {
            retVal = self.diningDishes.count;
            break;
        }
            
        default:
            break;
    }
    
    return retVal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Dish * dish = nil;
    switch (currentFoodSection) {
            
        case kBreakfast: {
            dish = self.breakfastFishes[indexPath.row];
            break;
        }
            
        case kLunch: {
            dish = self.lunchDishes[indexPath.row];
            break;
        }
            
        case kDinner: {
            dish = self.diningDishes[indexPath.row];
            break;
        }
            
        default:
            break;
    }
    
    int height = 0;
    if (dish) {
        
        NSString * text = [dish.description stringByAppendingFormat:@"  %@ USD", dish.price];
        
        height = [text boundingRectWithSize:CELL_DESCRIPTION_MAX_SIZE options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : CELL_DESCRIPTION_FONT} context:nil].size.height;
        height += TOP_CELL_SPACING + BOTTOM_CELL_SPACING;
        
        if (height < CELL_MINIMUN_HEIGHT) {
            height = CELL_MINIMUN_HEIGHT;
        }
    }
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellID = @"FoodCell";
    FoodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    [cell prepareForReuse];
    cell.backgroundColor = [UIColor clearColor];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"food%d.png", indexPath.row % 6 + 1]];
    
    Dish * dish = nil;
    switch (currentFoodSection) {
            
        case kBreakfast: {
            dish = self.breakfastFishes[indexPath.row];
            break;
        }
            
        case kLunch: {
            dish = self.lunchDishes[indexPath.row];
            break;
        }
            
        case kDinner: {
            dish = self.diningDishes[indexPath.row];
            break;
        }
            
        default:
            break;
    }
    
    
    if (dish) {
        
        cell.dishLabel.text = dish.name;
        cell.dishDescriptionLabel.text = [dish.description stringByAppendingFormat:@"  %@ USD", dish.price];
        cell.dishDescriptionLabel.frame = CELL_DESCRIPTION_STANDAD_RECT;
        [cell.dishDescriptionLabel sizeToFit];
        
    }
    
    
    return cell;
}


#pragma mark - memory

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        
        self.view = nil;
    }
    
    if (![self isViewLoaded]) {
        
        //Clean outlets here
    }
    
    //Clean rest of resources here eg:arrays, maps, dictionaries, etc
}

@end
