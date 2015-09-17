//
//  HomeViewController.m
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "HomeViewController.h"
#import "RestaurantListTableViewCell.h"
#import "DetailViewController.h"
#import "MapViewController.h"
#import "REFrostedViewController.h"
#import "Reachability.h"

@interface HomeViewController (){
    //array containing json objects
    NSArray *arr;
    
    //array of array for saving image from webservice
    NSMutableArray *imgarr;
    NSDictionary *dict;
    NSString *currentAdress;
    NSMutableArray *arrLocation;
    Reachability *networkReachability;
    NetworkStatus networkStatus;
   // MapViewController *controllerx;
  }

-(void)refresh;

//@property (strong, nonatomic) NSMutableArray* allTableData;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property  (strong,nonatomic)   NSMutableArray* checkinsCount;
@property  (strong,nonatomic)  NSMutableArray* usersCount;
@property  (strong,nonatomic)  NSMutableArray *arrAdress;
@property  (strong,nonatomic)  NSMutableArray *distance;
@property  (strong,nonatomic)  NSMutableArray *stat;
@property (atomic)  BOOL isfilterd;

@end

@implementation HomeViewController


@synthesize filteredTableData;
@synthesize checkinsCount;
@synthesize usersCount;
@synthesize arrAdress;
@synthesize distance;
@synthesize stat;

- (void)viewDidLoad {
    
    [super viewDidLoad];   
 
  //  controllerx=( MapViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    
    //reachablity internet
    networkReachability = [Reachability reachabilityForInternetConnection];
    networkStatus = [networkReachability currentReachabilityStatus];

    
    //initializing global arrays
  //  allTableData=[[NSMutableArray alloc]init];
    filteredTableData=[[NSMutableArray alloc]init];
    checkinsCount=[[NSMutableArray alloc]init];
    usersCount=[[NSMutableArray alloc]init];
    arrAdress=[[NSMutableArray alloc]init];
    distance =[[NSMutableArray alloc]init];
    stat =[[NSMutableArray alloc]init];
    
    //Location Array from webservice
    arrLocation =[[NSMutableArray alloc]init];
    
    //delegate for the searchbar
    self.searchBar.delegate=(id)self;
    
    
    if(arr == NULL)
    {
    //Test--loading data
        
        [self loaddata];
  
    }
    
    //make searchbar visible false
    self.searchBar.hidden=YES;
    self.searchBar.superview.hidden=YES;
    self.viewSorting.hidden =YES;
    self.viewSorting.superview.hidden=YES;
    
   }



-(void)refresh{
  
    
    [stat removeAllObjects];
    [distance removeAllObjects];
    [arrLocation removeAllObjects];
    [arrAdress removeAllObjects];
    [usersCount removeAllObjects];
    [checkinsCount removeAllObjects];
    
    
   // NSDictionary *stats =[[NSDictionary alloc]init];
    NSDictionary *stats;
    for (int i=0; i<filteredTableData.count; i++) {
        NSDictionary *van =[filteredTableData objectAtIndex:i];
        stats=[van objectForKey:@"stats"];
        [stat addObject:stats];
        van =[van objectForKey:@"location"];
        [distance addObject:(NSString *)[van valueForKey:@"distance"]];
        NSMutableDictionary *dict_local =[[NSMutableDictionary alloc]init];
        [dict_local setObject:[van valueForKey:@"lat"] forKey:@"lat"];
        [dict_local setObject:[van valueForKey:@"lng"] forKey:@"lng"];
        
        [arrLocation addObject:dict_local];
        [checkinsCount addObject:[stats valueForKey:@"checkinsCount"]];
        [usersCount addObject:[stats valueForKey:@"usersCount"]];
        
        {
            NSDictionary *location =[[filteredTableData objectAtIndex:i]valueForKey:@"location"];
            NSMutableArray *adress=(NSMutableArray *)[[location objectForKey:@"formattedAddress"]mutableCopy];
            NSString * result ;
            result=[adress componentsJoinedByString:@" "];
            [arrAdress addObject:result];
            
        }
        
        
        
    }
    

    }


-(void)loaddata{
    
    [SVProgressHUD show];
    NSURL *url =[NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?client_id=02WC0VDTQAZSAW2DYQULJLGA11H0DYEDUKCCYGZTX4KB5Z0S%20&client_secret=XKHDNP140SG33ZE34AG1XCYEQYK5VXXLWQ1N4E0A3PMONLTF&v=20150901&ll=23.0225050,72.5713620&query=restaurant"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=25;
    request.HTTPMethod=@"GET";
    
    


    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *err)
     {
         
         if (networkStatus == NotReachable) {
             
             [[[UIAlertView alloc]initWithTitle:@"Network not available" message:@"check your connection" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"", nil]show ];
             [SVProgressHUD dismiss];
             return ;
             
         } else {
             NSLog(@"There IS internet connection");
         }
         
         
         if(data ==nil)
         {
           
             [[[UIAlertView alloc]initWithTitle:@"Unable To fetch Data" message:@"check your connection" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"", nil]show ];
           [SVProgressHUD dismiss];
             return ;
         }
         
         id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         dict=[json objectForKey:@"response"];
            arr=[dict objectForKey:@"venues"];
         filteredTableData = [arr mutableCopy];
         {
             NSSortDescriptor *sorter;
             sorter =[[NSSortDescriptor alloc]initWithKey:@"location.distance" ascending:YES];
             NSArray *sortedDescriptors =[[NSArray alloc]initWithObjects:sorter, nil];
             
             filteredTableData =[[arr sortedArrayUsingDescriptors:sortedDescriptors] mutableCopy];
             self.viewSorting.hidden =YES;
             [self refresh];
             [self.myTableView reloadData];
             [SVProgressHUD dismiss];
         }

         }];
    
    
    }




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    DetailViewController *controller=( DetailViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    controller.lblname=[[filteredTableData objectAtIndex:indexPath.row]valueForKey:@"name"];
    controller.vanue=[filteredTableData objectAtIndex:indexPath.row];
    controller.lbladress=(NSString *)[arrAdress objectAtIndex:indexPath.row];
    controller.lblcheckinsCount= [NSString stringWithFormat:@"%@",[[stat objectAtIndex:indexPath.row]valueForKey:@"usersCount"]];

    [self.view endEditing:YES];
    self.searchBar.hidden=YES;
    self.searchBar.superview.hidden=YES;
        
    [self.navigationController pushViewController:controller animated:YES];

    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return filteredTableData.count;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     static NSString *CellIdentifier = @"RestaurantListTableViewCell";
    
     RestaurantListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[RestaurantListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.lblAdress.lineBreakMode=NSLineBreakByWordWrapping;
    cell.lblAdress.numberOfLines=0;
    cell.lblAdress.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-60;
    
    
    cell.lblName.text=[[filteredTableData objectAtIndex:indexPath.row]valueForKey:@"name"];
    NSDictionary *location =[[filteredTableData objectAtIndex:indexPath.row]valueForKey:@"location"];
    NSMutableArray *adress=(NSMutableArray *)[[location objectForKey:@"formattedAddress"]mutableCopy];
    NSString * result ;
    
    result=[adress componentsJoinedByString:@" "];
    currentAdress=result;
    
    
    cell.lblAdress.text=result;
    cell.lblusersCount.text =[NSString stringWithFormat:@"%@",[usersCount objectAtIndex:indexPath.row]];
    cell.lblcheckinsCount.text=[NSString stringWithFormat:@"CheckIn Count: %@",[checkinsCount objectAtIndex:indexPath.row]];
    cell.lbldistance.text =[NSString stringWithFormat:@"Distance: %@",[distance objectAtIndex:indexPath.row]];
    cell.btnMap.tag = (int)indexPath.row;
    [cell.btnMap addTarget:self action:@selector(mapButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
     }

#pragma  mark- map button click

	

- (IBAction)btnMenuShow:(id)sender {
    
    // Dismiss keyboard (optional)
    
    [self.navigationController.view endEditing:YES];
    [self.navigationController.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
    
}

- (IBAction)btnSearchClick:(id)sender {
    
    if(self.searchBar.hidden ==NO){
         self.searchBar.superview.hidden=YES;
         self.searchBar.hidden=YES;
      
        [self.view endEditing:YES];
    }
    else
    {
        self.searchBar.superview.hidden=NO;
        self.searchBar.hidden=NO;
}
    
}

- (IBAction)btnShorting:(id)sender {
    
    
    
    
  
        self.viewSorting.hidden=NO;
        UIButton *btn = (UIButton *)sender;
        NSSortDescriptor *sorter;
        [filteredTableData removeAllObjects];
        
        switch ((int)btn.tag) {
            case 11:
                sorter =[[NSSortDescriptor alloc]initWithKey:@"stats.usersCount" ascending:YES];
                break;
            case 12:
                sorter =[[NSSortDescriptor alloc]initWithKey:@"stats.usersCount" ascending:NO];
                break;
            case 13:
                sorter =[[NSSortDescriptor alloc]initWithKey:@"location.distance" ascending:YES];
                break;
            case 14:
                sorter =[[NSSortDescriptor alloc]initWithKey:@"location.distance" ascending:NO];
                break;
            case 15:
                sorter =[[NSSortDescriptor alloc]initWithKey:@"stats.checkinsCount" ascending:YES];
                break;
            case 16:
                sorter =[[NSSortDescriptor alloc]initWithKey:@"stats.checkinsCount" ascending:NO];
                break;
        }
        
        NSArray *sortedDescriptors =[[NSArray alloc]initWithObjects:sorter, nil];
        
        filteredTableData =[[arr sortedArrayUsingDescriptors:sortedDescriptors] mutableCopy];
        self.viewSorting.hidden =YES;
        self.viewSorting.superview.hidden=YES;
        [self refresh];
        [self.myTableView reloadData];
    
    

    
    
}

- (IBAction)btnSort:(id)sender {
    
    
    if(self.viewSorting.hidden==FALSE){
        self.viewSorting.hidden=TRUE;
        self.viewSorting.superview.hidden =TRUE;
    }
    else{
        self.viewSorting.hidden=FALSE;
        self.viewSorting.superview.hidden=FALSE;
    }
        
    
    
}

#pragma  mark - filtering the searched hotel

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
   
    if (text.length>0)
    {
      
        [filteredTableData removeAllObjects];
        
        NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name contains[c] %@",text];
        filteredTableData = [[arr filteredArrayUsingPredicate:predicate] mutableCopy];
        [self refresh];
        [self.myTableView reloadData];
        
        }
    else
    {
        [filteredTableData removeAllObjects];

        {
            NSSortDescriptor *sorter;
            sorter =[[NSSortDescriptor alloc]initWithKey:@"location.distance" ascending:YES];
            NSArray *sortedDescriptors =[[NSArray alloc]initWithObjects:sorter, nil];
            
            filteredTableData =[[arr sortedArrayUsingDescriptors:sortedDescriptors] mutableCopy];
            self.viewSorting.hidden =YES;
            [self refresh];
            [self.myTableView reloadData];
            
        }

    }
    
}

- (IBAction)mapButtonClick:(id)sender {

    UIButton *btn = (UIButton *)sender;
    NSLog(@"%d",(int)btn.tag);
    
    MapViewController *controller=( MapViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    if(btn.tag>=0)
    {
        controller.arrVanues = [[NSMutableArray alloc]initWithObjects:[filteredTableData objectAtIndex:btn.tag], nil];
    }
    else
    {
      //  controller.arrLocation =arrLocation;  `
        controller.arrVanues =[[NSMutableArray alloc]initWithArray:filteredTableData copyItems:YES];
    }
    [self.navigationController pushViewController:controller animated:YES];

}


@end
