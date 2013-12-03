//
//  CityGuideViewController.h
//  Hotel App
//
//  Created by Ernesto Carrión on 12/2/13.
//  Copyright (c) 2013 Hotel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface CityGuideViewController : UIViewController {
    
    __weak IBOutlet MKMapView *makView;
}

@end
