//
//  LandingViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/17/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "LockscreenViewController.h"
#import "Weather.h"

@interface LockscreenViewController () {
    
    NSDateFormatter * clockFormater;
    NSTimer * clockTimer;
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
    
    clockFormater = [[NSDateFormatter alloc] init];
    [clockFormater setDateFormat:@"H:mm"];
    
    tempLabel.text = @"";
    
    [self updateTimer];
    [self updateWeather];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSTimeInterval todayInterval = [[NSDate date] timeIntervalSince1970]; //Today in seconds
    int remainingForMinute  = 60 - ((int)todayInterval % 60);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(remainingForMinute * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        clockTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [self updateTimer];
        
    });
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [clockTimer invalidate];
    clockTimer = nil;
}


-(void)updateTimer {
    
    //Clock
    NSString * dateStr = [clockFormater stringFromDate:[NSDate date]];
    clockLabel.text = dateStr;
    
    
    //Date
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE MMMM d',' yyyy"];
    }
    
    dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
}

-(void)updateWeather {
    
    [Weather currentWeatherForLat:17.3820420 long:78.48172729999999 OnCompletion:^(Weather *weatherInfo) {
        
        if (weatherInfo) {
            tempLabel.text = [NSString stringWithFormat:@"%@ º", weatherInfo.temperature];
        }
        
    }];
}

- (IBAction)toLandingPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)dealloc {
    
    [clockTimer invalidate];
    clockTimer = nil;
}

@end
