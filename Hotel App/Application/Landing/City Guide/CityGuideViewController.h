//
//  CityGuideViewController.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface CityGuideViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate> {
    
    __weak IBOutlet MKMapView *makView;
    __weak IBOutlet UITableView *cityTableView;
    
    
    __weak IBOutlet UIImageView *tempIcon;
    __weak IBOutlet UILabel *tempLabel;
    
    __weak IBOutlet UILabel *clockLabel;
}

@end
