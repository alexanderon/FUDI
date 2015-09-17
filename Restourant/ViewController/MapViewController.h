//
//  MapViewController.h
//  Restourant
//
//  Created by RAHUL on 9/4/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AnnotationView.h"



@interface MapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UIView *customView1;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomView;
- (IBAction)btnDetailClick:(id)sender;

@property NSMutableArray *arrVanues;
@property NSDictionary *dictVanue;
//@property NSMutableArray *arrLocation;
//@property NSMutableArray *arrAdress;


- (IBAction)btnBack:(id)sender;

@end
