//
//  ViewController.m
//  MapKit_Example
//
//  Created by HealthOne on 16/11/16.
//  Copyright © 2016 akash. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D sourceLocation = CLLocationCoordinate2DMake(40.759011, -73.984472);
    CLLocationCoordinate2D destinationLocation = CLLocationCoordinate2DMake(40.748441, -73.985564);
    
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc]initWithCoordinate:sourceLocation addressDictionary:nil];
    MKPlacemark *destnationPlacemark = [[MKPlacemark alloc]initWithCoordinate:destinationLocation addressDictionary:nil];
    
    MKMapItem *sourceMapItem = [[MKMapItem alloc]initWithPlacemark:sourcePlacemark];
    MKMapItem *destinaionMapItem = [[MKMapItem alloc]initWithPlacemark:destnationPlacemark];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    request.source = sourceMapItem;
    request.destination = destinaionMapItem;
    request.transportType = MKDirectionsTransportTypeAutomobile;
    
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Could not fetch directions- %@", error);
         }
         else
         {
             for (MKRoute *route in response.routes)
             {
                 [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
                 
                 MKMapRect frame = route.polyline.boundingMapRect;
                 [self.mapView setRegion:MKCoordinateRegionForMapRect(frame)];
                 
                 NSLog(@"Route Instructions-\n");
                 for (MKRouteStep *step in route.steps)
                 {
                     NSLog(@"%@", step.instructions);
                 }
             }
         }
     }];
   
    // Show Annotations
    MKPointAnnotation *sourceAnnotation = [[MKPointAnnotation alloc]init];
    sourceAnnotation.title = @"Times Square";
    sourceAnnotation.coordinate = sourceLocation;
    
    MKPointAnnotation *destinationAnnotation = [[MKPointAnnotation alloc]init];
    destinationAnnotation.title = @"Empire State Building";
    sourceAnnotation.coordinate = destinationLocation;
    
    [self.mapView showAnnotations:@[sourceAnnotation, destinationAnnotation] animated:YES];
}

#pragma mark - MapKit Delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 5.0;
    return renderer;
}


@end
