//
//  CityGuideViewController.m
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import "CityGuideViewController.h"
#import "FoursquareManager.h"
#import "HOAnotationView.h"
#import "Weather.h"

@interface CityGuideViewController () {
    
    NSMutableArray * arrayOfArrayOfLocations;
    NSMutableArray * arrayOfArrayOfAnotations;
    
    BOOL inCategories;
    CityObjectType currentCategory;
}

@end

@implementation CityGuideViewController

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
    
    cityTableView.separatorColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:0.25];
    
    inCategories  = YES;
    [self centerMap];
    [self loadLocations];
    
    tempLabel.text = @"";
    [self setTime:current_time()];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self updateWeather];
}

-(void)setTime:(NSString *)time {
    
    clockLabel.text = time;
}

-(void)updateWeather {
    
    [Weather currentWeatherForLat:HOTEL_LATITUDE long:HOTEL_LONGITUDE OnCompletion:^(Weather *weatherInfo) {
        
        if (weatherInfo) {
            tempLabel.text = [NSString stringWithFormat:@"%@°", weatherInfo.temperature_f];
            tempIcon.image = [UIImage imageNamed:weatherInfo.iconSmallName];
        }
        
    }];
}

-(void)loadLocations {
    
    arrayOfArrayOfLocations = [@[[NSNull null], [NSNull null], [NSNull null], [NSNull null]] mutableCopy];
    arrayOfArrayOfAnotations = [@[[NSNull null], [NSNull null], [NSNull null], [NSNull null]] mutableCopy];
    
    for (int i = 0; i < 4; i++) {
        
        [FoursquareManager cityObject:i onCompletion:^(NSError *error, NSArray *locations) {
            
            if (!error) {
                
                
                [arrayOfArrayOfLocations replaceObjectAtIndex:i withObject:locations];
                
                NSMutableArray * anotations = [NSMutableArray array];
                [locations enumerateObjectsUsingBlock:^(CityLocation * location, NSUInteger idx, BOOL *stop) {
                    
                    HOAnotationView * anonView = [HOAnotationView anotationWithLat:location.latitude lng:location.longitude title:location.name subtitle:location.address];
                    [makView addAnnotation:anonView];
                    
                    [anotations addObject:anonView];
                }];
                
                [arrayOfArrayOfAnotations replaceObjectAtIndex:i withObject:anotations];
            }
            if (!inCategories && currentCategory == i) {
                NSIndexSet * set = [NSIndexSet indexSetWithIndex:0];
                [cityTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }
}

-(void)centerMap {
    
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(HOTEL_LATITUDE, HOTEL_LONGITUDE), 4000, 4000);
	[makView setRegion:region animated:YES];
    
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (!inCategories) {
        return 60;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (inCategories) {
        return 60;
    }
    
    return 77;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (inCategories)
        return nil;
    
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    
    UILabel * title = [[UILabel alloc] initWithFrame:header.bounds];
    title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    
    tableView.separatorColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:0.25];
    
    [header addSubview:title];
    
    switch (currentCategory) {
            
        case kRestaurant: {
            title.text = @"Restaurant";
            break;
        }
            
        case kBar: {
            title.text = @"Bar";
            break;
        }
            
        case kCafe: {
            title.text = @"Cafe";
            break;
        }
            
        case kTheater: {
            title.text = @"Theater";
            break;
        }
            
        default:
            break;
    }
    
    return header;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (inCategories) {
        
        return 4;
        
    } else {
        
        NSUInteger number = 0;
        
        if (arrayOfArrayOfAnotations[currentCategory] != [NSNull null]) {
            number = [arrayOfArrayOfLocations[currentCategory] count];
        }
        return number;
        
    }
    
    return  0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!inCategories) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.backgroundColor = [UIColor clearColor];
            
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
            cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
            
            UIView * selectedView = [[UIView alloc] initWithFrame:cell.bounds];
            selectedView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            cell.selectedBackgroundView = selectedView;
            
        }
        
        CityLocation * location = arrayOfArrayOfLocations[currentCategory][indexPath.row];
        
        cell.textLabel.text = location.name;
        cell.detailTextLabel.text = location.address;
        
        return cell;
        
    } else {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.backgroundColor = [UIColor clearColor];
            
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            UIView * selectedView = [[UIView alloc] initWithFrame:cell.bounds];
            selectedView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            cell.selectedBackgroundView = selectedView;
        }
        
        switch (indexPath.row) {
                
            case kRestaurant: {
                cell.textLabel.text = @"Restaurant";
                break;
            }
                
            case kBar: {
                cell.textLabel.text = @"Bar";
                break;
            }
                
            case kCafe: {
                cell.textLabel.text = @"Cafe";
                break;
            }
                
            case kTheater: {
                cell.textLabel.text = @"Theater";
                break;
            }
                
            default:
                break;
        
        }
        
        return cell;
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (inCategories) {
        
        currentCategory = (int)indexPath.row;
        inCategories = NO;
        [cityTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        
    } else {
        
        HOAnotationView * annotation = arrayOfArrayOfAnotations[currentCategory][indexPath.row];
        [makView selectAnnotation:annotation animated:YES];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1500, 1500);
        [makView setRegion:region animated:YES];
    }
}

#pragma mark - Map Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    MKPinAnnotationView * newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
    newAnnotation.pinColor = MKPinAnnotationColorRed;
    newAnnotation.animatesDrop = YES;
    newAnnotation.canShowCallout = YES;
    return newAnnotation;
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if (!inCategories) {
        
        for (int section = 0; section < arrayOfArrayOfAnotations.count; section++) {
            int row = [arrayOfArrayOfAnotations[currentCategory] indexOfObject:view.annotation];
            if (row != NSNotFound) {
                NSIndexPath * ip = [NSIndexPath indexPathForRow:row inSection:section];
                [cityTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                break;
            }
        }
    }

}


#pragma mark - IBActions

- (IBAction)backPressed:(id)sender {
    
    if  (inCategories) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        inCategories = YES;
        [cityTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
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
@end
