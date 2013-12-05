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

@interface CityGuideViewController () {
    
    NSMutableArray * arrayOfArrayOfLocations;
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
    
    [self centerMap];
    [self loadLocations];
}

-(void)loadLocations {
    
    arrayOfArrayOfLocations = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        
        [FoursquareManager cityObject:i onCompletion:^(NSError *error, NSArray *locations) {
            
            if (!error) {
                if (arrayOfArrayOfLocations.count >= i) {
                    [arrayOfArrayOfLocations insertObject:locations atIndex:i];
                } else {
                    [arrayOfArrayOfLocations addObject:locations];
                }
                
                
                [locations enumerateObjectsUsingBlock:^(CityLocation * location, NSUInteger idx, BOOL *stop) {
                    
                    HOAnotationView * anonView = [HOAnotationView anotationWithLat:location.latitude lng:location.longitude title:location.name subtitle:location.address];
                    [makView addAnnotation:anonView];
                    
                }];
            }
            
            [cityTableView reloadData];
        }];
    }
}

-(void)centerMap {
    
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(HOTEL_LATITUDE, HOTEL_LONGITUDE), 10000, 10000);
	[makView setRegion:region animated:YES];
    
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return arrayOfArrayOfLocations.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString * title = @"";
    
    switch (section) {
            
        case kRestaurant: {
            title = @"Restaurant";
            break;
        }
            
        case kBar: {
            title = @"Bar";
            break;
        }
            
        case kCafe: {
            title = @"Cafe";
            break;
        }
            
        case kTheater: {
            title = @"Theater";
            break;
        }
            
        default:
            break;
    }
    
    return title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayOfArrayOfLocations[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    CityLocation * location = arrayOfArrayOfLocations[indexPath.section][indexPath.row];
    
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = location.address;
    
    return cell;
}

#pragma mark - Map Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    MKPinAnnotationView * newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
    newAnnotation.pinColor = MKPinAnnotationColorRed;
    newAnnotation.animatesDrop = YES;
    newAnnotation.canShowCallout = NO;
    return newAnnotation;
    
}


#pragma mark - IBActions

- (IBAction)backPressed:(id)sender {
    
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
