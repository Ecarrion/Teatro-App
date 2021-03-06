//
//  LandingViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/18/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "LandingViewController.h"
#import "Weather.h"

#import "DiningViewController.h"
#import "CityGuideViewController.h"

#import "AmenitiesViewController.h"

#define BUTTONS_CONTAINER_RECT_BIG CGRectMake(346, 187, 678, 393)
#define BUTTONS_CONTAINER_RECT_SMALL CGRectMake(683, 187, 678, 393)

#define TOGGLE_BUTTON_RECT_OPEN CGRectMake(304, 544, 23, 23)
#define TOGGLE_BUTTON_RECT_CLOSE CGRectMake(648, 544, 23, 23)

@interface LandingViewController () {
    
}

@end

@implementation LandingViewController

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
    
    [self.buttonsArray enumerateObjectsUsingBlock:^(UIButton * but, NSUInteger idx, BOOL *stop) {
        
        but.titleLabel.numberOfLines = 0;
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
    }];
    
    weatherLabel.text = @"";
    [self setTime:current_time()];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self updateWeather];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}


-(void)setTime:(NSString *)time {
    
    clockLabel.text = time;
}

-(void)updateWeather {
    
    [Weather currentWeatherForLat:HOTEL_LATITUDE long:HOTEL_LONGITUDE OnCompletion:^(Weather *weatherInfo) {
        
        if (weatherInfo) {
            weatherLabel.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature_f];
            tempIconImageView.image = [UIImage imageNamed:weatherInfo.iconSmallName];
        }
        
    }];
}

#pragma mark - IBActions

- (IBAction)toggleDescription:(id)sender {
    
    if (buttonContainer.frame.origin.x == BUTTONS_CONTAINER_RECT_BIG.origin.x) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            buttonContainer.frame = BUTTONS_CONTAINER_RECT_SMALL;
            buttonContainer.alpha = 0.5;
            buttonContainer.userInteractionEnabled = NO;
            
            [toggleButton setImage:[UIImage imageNamed:@"close_desc_button.png"] forState:UIControlStateNormal];
            toggleButton.frame = TOGGLE_BUTTON_RECT_CLOSE;
            
            description2.alpha = 1;
            
            
        } completion:nil];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            buttonContainer.frame = BUTTONS_CONTAINER_RECT_BIG;
            buttonContainer.alpha = 1;
            buttonContainer.userInteractionEnabled = YES;
            
            [toggleButton setImage:[UIImage imageNamed:@"open_desc_button.png"] forState:UIControlStateNormal];
            toggleButton.frame = TOGGLE_BUTTON_RECT_OPEN;
            
            description2.alpha = 0;
            
        } completion:nil];
    }
}

-(IBAction)spaPressed {
    
}

-(IBAction)eStorePressed {
    
}

-(IBAction)cityGuidePressed {
    
    CityGuideViewController * cgvc = [[CityGuideViewController alloc] init];
    [self.navigationController pushViewController:cgvc animated:YES];
}

-(IBAction)amenitiesPressed {
    
    AmenitiesViewController * avc = [[AmenitiesViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}

-(IBAction)otherLocationsPressed {
    
}

-(IBAction)diningLocationsPressed {
    
    DiningViewController * dvc = [[DiningViewController alloc] init];
    [self.navigationController pushViewController:dvc animated:YES];
    
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
