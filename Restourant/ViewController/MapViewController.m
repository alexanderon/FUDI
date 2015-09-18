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
{
    NSArray*    annotations;
}

@property (strong, nonatomic)CLLocationManager *locationManger;
@property (strong,nonatomic)NSString *currentName;
@property (strong,nonatomic)NSString *currentLocation;
@property (strong,nonatomic)NSString *currentAdress;
@property (strong,nonatomic)NSString *currentusersCount;
@property (atomic)CLLocationCoordinate2D currentCoordinate;

@end

@implementation MapViewController

@synthesize map;
@synthesize arrVanues;
@synthesize dictVanue;



- (void)viewDidLoad {
    [super viewDidLoad];
    annotations =[[NSArray alloc]init];
    //gesture recognizer
 
  
    NSDictionary *location;
    for(int i=0;i<arrVanues.count;i++){
         
                dictVanue =[arrVanues objectAtIndex:i];
                self.currentName =[NSString stringWithFormat:@"%@",[dictVanue objectForKey:@"name"]];
                
                location =[dictVanue objectForKey:@"location"];
                
                NSString *lat =[location valueForKey:@"lat"];
                NSString *lng =[location valueForKey:@"lng"];
                
                double lattitude =[lat doubleValue];
                double longitude=[lng doubleValue];
         
                CLLocationCoordinate2D coord =CLLocationCoordinate2DMake(lattitude, longitude);
        self.currentCoordinate=coord;
         
        
        {
            MKPointAnnotation *annot =[[MKPointAnnotation alloc]init];
            [annot setCoordinate:coord];
            annot.title=[NSString stringWithFormat:@"%d",i];
            NSLog(@"%d",i);
            [self.map addAnnotation:annot];
            annotations=@[annot];
        }
        
         
}
  
    
    
        self.locationManger=[[CLLocationManager alloc]init];
        
        if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManger requestWhenInUseAuthorization];
        
        
        self.map.delegate=self;
        self.locationManger.delegate=self;
        self.locationManger.desiredAccuracy=kCLLocationAccuracyBest;
        [self.locationManger startUpdatingLocation];
        self.map.showsUserLocation=YES;
        
    }
    
  //  [self.map showAnnotations:map.annotations animated:YES];
    
   }



/*-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.map removeAnnotations:map.annotations];
    for(int i=0;i<arr.count;i++){
        
        vanue =[arr objectAtIndex:i];
        self.currentName =[NSString stringWithFormat:@"%@",[vanue objectForKey:@"name"]];
        
        NSDictionary *location =[vanue objectForKey:@"location"];
        
        NSString *lat =[location valueForKey:@"lat"];
        NSString *lng =[location valueForKey:@"lng"];
        
        double lattitude =[lat doubleValue];
        double longitude=[lng doubleValue];
        
        CLLocationCoordinate2D coord =CLLocationCoordinate2DMake(lattitude, longitude);
        self.currentCoordinate=coord;
        
        
        {
            MKPointAnnotation *annot =[[MKPointAnnotation alloc]init];
            [annot setCoordinate:coord];
            annot.title=[NSString stringWithFormat:@"%d",i];
            NSLog(@"%d",i);
            [self.map addAnnotation:annot];
            annotations=@[annot];
        }
        
        
    }
    
    
    
    self.locationManger=[[CLLocationManager alloc]init];
    
    if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManger requestWhenInUseAuthorization];
        
        
        self.map.delegate=self;
        self.locationManger.delegate=self;
        self.locationManger.desiredAccuracy=kCLLocationAccuracyBest;
        [self.locationManger startUpdatingLocation];
        self.map.showsUserLocation=YES;
        
    }
    
    [self.map showAnnotations:annotations animated:YES];
}*/

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
     [self.map showAnnotations:map.annotations animated:YES];
    [self.locationManger stopUpdatingLocation];
}

#pragma mark -user location

/*-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5500, 5500);
    [self.map setRegion:[self.map regionThatFits:region] animated:YES];
    
    [self.locationManger stopUpdatingLocation];

}*/


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
        
        
        if (arrVanues.count >1) {
            dictVanue =[arrVanues objectAtIndex:view.tag];

        }else
        {
            dictVanue=[arrVanues objectAtIndex:0];
            
        }
              self.currentName =[NSString stringWithFormat:@"%@",[dictVanue objectForKey:@"name"]];
        
   
        {
            NSDictionary *location =[dictVanue objectForKey:@"location"];
            NSMutableArray *adress=(NSMutableArray *)[[location objectForKey:@"formattedAddress"]mutableCopy];
            NSString * formattedAddress ;
            formattedAddress=[adress componentsJoinedByString:@" "];
            self.currentAdress =formattedAddress;
        }
        
        {
            NSDictionary *stats =[dictVanue objectForKey:@"stats"];
            self.currentusersCount=[stats valueForKey:@"usersCount"];
         
            
        }
        
        self.lblCustomView.text =self.currentName;
        CGRect frame = self.customView1.frame;
        frame.size = CGSizeMake(300, 80);
        self.customView1.frame= frame;
        [view addSubview:self.customView1];
        self.customView1.center = CGPointMake(self.customView1.bounds.size.width*0.1f, -self.customView1.bounds.size.height*0.5f);
        
        
    }
      

}



- (IBAction)btnBack:(id)sender {
    [self.map removeAnnotations:map.annotations];
    [self.customView1 removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)btnDetailClick:(id)sender{
 
    
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[DetailViewController class]]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    DetailViewController *controller =[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    controller.lbladress=self.currentAdress;
    controller.lblname=self.currentName;
    controller.lblcheckinsCount=[NSString stringWithFormat:@"%@",self.currentusersCount];
    controller.vanue=self.dictVanue;
    
    [self.navigationController pushViewController:controller animated:YES];
    
   
}


#pragma  -mark -disappear annotation view

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    [self.customView1 removeFromSuperview];
    [view removeFromSuperview];
}



-(void)dealloc{
    
}
@end
