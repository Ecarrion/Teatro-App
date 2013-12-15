//
//  LandingViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "LockscreenViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Weather.h"

@interface LockscreenViewController () {
    
    NSDateFormatter * dateFormatter;
}

@end

@implementation LockscreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tempLabel.text = @"";
    temp_c_label.text = @"";
    tem_f_label.text = @"";
    
    //Style clock label
    clockLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    clockLabel.layer.shadowRadius = 2.f;
    clockLabel.layer.shadowOpacity = .4;
    clockLabel.layer.shadowOffset = CGSizeZero;
    clockLabel.layer.masksToBounds = NO;
    
    //Style temp label
    tempLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    tempLabel.layer.shadowRadius = 2.f;
    tempLabel.layer.shadowOpacity = .4;
    tempLabel.layer.shadowOffset = CGSizeZero;
    tempLabel.layer.masksToBounds = NO;
    
    //Style temp C label
    temp_c_label.layer.shadowColor = [[UIColor blackColor] CGColor];
    temp_c_label.layer.shadowRadius = 2.f;
    temp_c_label.layer.shadowOpacity = .4;
    temp_c_label.layer.shadowOffset = CGSizeZero;
    temp_c_label.layer.masksToBounds = NO;
    
    //Style temp F label
    tem_f_label.layer.shadowColor = [[UIColor blackColor] CGColor];
    tem_f_label.layer.shadowRadius = 2.f;
    tem_f_label.layer.shadowOpacity = .4;
    tem_f_label.layer.shadowOffset = CGSizeZero;
    tem_f_label.layer.masksToBounds = NO;
    
    [self setTime:current_time()];
    [self updateWeather];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

-(void)setTime:(NSString *)time {
    
    clockLabel.text = time;
    
    //Date
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE MMMM d',' yyyy"];
    }
    
    dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
}

-(void)updateWeather {
    
    [Weather currentWeatherForLat:HOTEL_LATITUDE long:HOTEL_LONGITUDE OnCompletion:^(Weather *weatherInfo) {
        
        if (weatherInfo) {
            
            tempLabel.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature_f];
            temp_c_label.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature];
            tem_f_label.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature_f];
            
            tempIconLabel.image = [UIImage imageNamed:weatherInfo.iconName];
        }
        
    }];
}

- (IBAction)toLandingPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sliderChanged:(id)sender {
    
    if (landingSlider.value < 1) {
        
        [landingSlider setValue:0 animated:YES];
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - memory

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        
        self.view = nil;
    }
    
    if (![self isViewLoaded]) {
        
        //Clean outlets here
        dateFormatter = nil;
    }
    
    //Clean rest of resources here eg:arrays, maps, dictionaries, etc
}

@end
