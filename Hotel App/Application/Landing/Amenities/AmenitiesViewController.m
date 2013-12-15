//
//  AmenitiesViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/5/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "AmenitiesViewController.h"
#import "Weather.h"

@interface AmenitiesViewController ()

@end

@implementation AmenitiesViewController

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
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self updateWeather];
}

-(void)updateWeather {
    
    [Weather currentWeatherForLat:HOTEL_LATITUDE long:HOTEL_LONGITUDE OnCompletion:^(Weather *weatherInfo) {
        
        if (weatherInfo) {
            tempLabel.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature_f];
            tempIcon.image = [UIImage imageNamed:weatherInfo.iconSmallName];
        }
        
    }];
}

#pragma mark - IBAction

- (IBAction)goBackPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
