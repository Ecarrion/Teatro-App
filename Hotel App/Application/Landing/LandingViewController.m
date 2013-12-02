//
//  LandingViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 11/18/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "LandingViewController.h"
#import "Weather.h"

#define BUTTONS_CONTAINER_RECT_BIG CGRectMake(346, 187, 678, 393)
#define BUTTONS_CONTAINER_RECT_SMALL CGRectMake(683, 187, 678, 393)

#define TOGGLE_BUTTON_RECT_OPEN CGRectMake(281, 539, 46, 30)
#define TOGGLE_BUTTON_RECT_CLOSE CGRectMake(620, 539, 46, 30)

@interface LandingViewController () {
    
    NSDateFormatter * clockFormater;
    NSTimer * clockTimer;
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
    
    clockFormater = [[NSDateFormatter alloc] init];
    [clockFormater setDateFormat:@"H:mm"];
    
    [self updateTimer];
    [self updateWeather];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSTimeInterval todayInterval = [[NSDate date] timeIntervalSince1970]; //Today in seconds
    int remainingForMinute  = 60 - ((int)todayInterval % 60);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(remainingForMinute * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [clockTimer invalidate];
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
}

-(void)updateWeather {
    
    [Weather currentWeatherForLat:17.3820420 long:78.48172729999999 OnCompletion:^(Weather *weatherInfo) {
        
        if (weatherInfo) {
            weatherLabel.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature];
        }
        
    }];
}

- (IBAction)toggleDescription:(id)sender {
    
    if (buttonContainer.frame.origin.x == BUTTONS_CONTAINER_RECT_BIG.origin.x) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            buttonContainer.frame = BUTTONS_CONTAINER_RECT_SMALL;
            buttonContainer.alpha = 0.5;
            buttonContainer.userInteractionEnabled = NO;
            
            toggleButton.frame = TOGGLE_BUTTON_RECT_CLOSE;
            
            description2.alpha = 1;
            
            
        } completion:nil];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            buttonContainer.frame = BUTTONS_CONTAINER_RECT_BIG;
            buttonContainer.alpha = 1;
            buttonContainer.userInteractionEnabled = YES;
            
            toggleButton.frame = TOGGLE_BUTTON_RECT_OPEN;
            
            description2.alpha = 0;
            
        } completion:nil];
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
    }
    
    //Clean rest of resources here eg:arrays, maps, dictionaries, etc
}

-(void)dealloc {
    
    [clockTimer invalidate];
    clockTimer = nil;
}

@end
