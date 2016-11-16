//
//  ViewController.h
//  MapKit_Example
//
//  Created by HealthOne on 16/11/16.
//  Copyright © 2016 akash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

