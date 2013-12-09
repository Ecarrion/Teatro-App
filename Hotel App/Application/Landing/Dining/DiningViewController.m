//
//  DiningViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "DiningViewController.h"
#import "FoodCell.h"

@interface DiningViewController () <UITableViewDataSource, UITableViewDelegate>

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
}

#pragma mark - IBAction

- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - IBAction

- (IBAction)foodSourcePressed:(id)sender {
    
    for (UIButton * but  in self.segmentedButtons) {
        but.highlighted = NO;
        
        if (but == sender) {
            dispatch_async(dispatch_get_main_queue(), ^{
                but.highlighted = YES;
            });
        }
    }
}


#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellID = @"FoodCell";
    FoodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    [cell prepareForReuse];
    cell.backgroundColor = [UIColor clearColor];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"food%d.png", indexPath.row % 6 + 1]];
    cell.dishLabel.text = @"Something";
    cell.dishDescriptionLabel.text = @"More Something More Something More Something More Something More Something More Something More Something More Something More Something More Something";
    
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
