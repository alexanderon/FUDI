//
//  MapViewController.m
//  Restourant
//
//  Created by RAHUL on 9/4/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "MapViewController.h"
#import "DetailViewController.h"
#import "Annotation.h"


@interface MapViewController ()


@property (strong, nonatomic)CLLocationManager *locationManger;
@property (strong,nonatomic)NSString *currentName;
@property (strong,nonatomic)NSString *currentLocation;
@property (strong,nonatomic)NSString *currentAdress;
@property (strong,nonatomic)NSString *currentusersCount;

@end

@implementation MapViewController

@synthesize map;
@synthesize arr;
@synthesize vanue;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //gesture recognizer
 
    
   
    for(int i=0;i<arr.count;i++){
         
                vanue =[arr objectAtIndex:i];
                self.currentName =[NSString stringWithFormat:@"%@",[vanue objectForKey:@"name"]];
                
                NSDictionary *location =[vanue objectForKey:@"location"];
                
                NSString *lat =[location valueForKey:@"lat"];
                NSString *lng =[location valueForKey:@"lng"];
                
                double lattitude =[lat doubleValue];
                double longitude=[lng doubleValue];
         
                CLLocationCoordinate2D coord =CLLocationCoordinate2DMake(lattitude, longitude);
         
        
        {
            MKPointAnnotation *annot =[[MKPointAnnotation alloc]init];
            [annot setCoordinate:coord];
            annot.title=[NSString stringWithFormat:@"%d",i];
            NSLog(@"%d",i);
            [self.map addAnnotation:annot];

        }
        
/*           // Place Annotation Point
         MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
           //Setting Sample location Annotation
          annotation1.title= [NSString stringWithFormat:@"%d",i];
         NSLog(@"%d",i);
         [annotation1 setCoordinate:coord];
         //Add cordinates
         [self.map addAnnotation:annotation1];*/
         
         }
  
    
    {
        self.locationManger=[[CLLocationManager alloc]init];
        
        if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManger requestWhenInUseAuthorization];
        }
        
        self.map.delegate=self;
        self.locationManger.delegate=self;
        self.locationManger.desiredAccuracy=kCLLocationAccuracyBest;
        [self.locationManger startUpdatingLocation];
        self.map.showsUserLocation=YES;
        
    }

    
}


#pragma mark -user location

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000, 5000);
    [self.map setRegion:[self.map regionThatFits:region] animated:YES];
}



#pragma mark -adding annotation

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  //  self.map.showsUserLocation=YES;

    [manager stopUpdatingLocation];
 
  //  NSLog(@"%@==== %d",_arrLocation,(int)_arrLocation.count);

   
}

#pragma mark  - custom  view design

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[annotation class]])
    {
        // Try to dequeue an existing pin view first.
        AnnotationView*    pinView = (AnnotationView*)[mapView                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[AnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.image=[UIImage imageNamed:@"sel_map.png"];
            pinView.tag=[annotation.title integerValue];
            
        }
      
        
        return pinView;
    }
    
    return nil;
  
    
}



-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{

    //[mapView deselectAnnotation:view.annotation animated:YES];
    
    
    if([view isKindOfClass:[AnnotationView class]]){
        NSLog(@"%d",(int)view.tag);
        
        
        
        vanue =[arr objectAtIndex:view.tag];
        self.currentName =[NSString stringWithFormat:@"%@",[vanue objectForKey:@"name"]];
        
   
        {
            NSDictionary *location =[vanue objectForKey:@"location"];
            NSMutableArray *adress=(NSMutableArray *)[[location objectForKey:@"formattedAddress"]mutableCopy];
            NSString * formattedAddress ;
            formattedAddress=[adress componentsJoinedByString:@" "];
            self.currentAdress =formattedAddress;
        }
        
        {
            NSDictionary *stats =[vanue objectForKey:@"stats"];
            self.currentusersCount=[stats valueForKey:@"usersCount"];
            NSLog(@"%@",self.currentusersCount);
            
        }
        
        self.lblCustomView.text =self.currentName;
        
        
        [view addSubview:self.customView1];
       
    addSubview:self.customView1.center = CGPointMake(self.customView1.bounds.size.width*0.1f, -self.customView1.bounds.size.height*0.5f);
        
    }
      

}




- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)callButtonClicked:(id)sender{
    
  /*  DetailViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    controller.vanue=vanue;
    controller.lblname=self.currentName;
    controller.lbladress=self.currentAdress;
    controller.lblcheckinsCount =[NSString stringWithFormat:@"%@",self.currentusersCount];
    NSLog(@"%@",self.currentusersCount);
    [self.navigationController pushViewController:controller animated:YES];*/
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma  -mark -disappear annotation view




-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    [self.customView1 removeFromSuperview];
    
         NSLog(@"annotation not selected");
    
}


@end
