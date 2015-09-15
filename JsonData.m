//
//  JsonData.m
//  Restourant
//
//  Created by RAHUL on 9/8/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "JsonData.h"



@implementation JsonData

@synthesize  venues;
@synthesize allTableData;
@synthesize filteredTableData;
@synthesize isfilterd;



-(void)loaddata{
    
    NSURL *url =[NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?client_id=02WC0VDTQAZSAW2DYQULJLGA11H0DYEDUKCCYGZTX4KB5Z0S%20&client_secret=XKHDNP140SG33ZE34AG1XCYEQYK5VXXLWQ1N4E0A3PMONLTF&v=20150901&ll=23.0225050,72.5713620&query=restaurant"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval=25;
    request.HTTPMethod=@"GET";
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *err)
     {
         
         id json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSDictionary *dict =[[NSDictionary alloc]init];
         
         dict=[json objectForKey:@"response"];
         venues=[dict objectForKey:@"venues"];
    
         
         NSDictionary *stats =[[NSDictionary alloc]init];
         
         for (int i=0; i<venues.count; i++) {
             
             NSDictionary *van =[venues objectAtIndex:i];
             
             stats=[van objectForKey:@"stats"];
             van =[van objectForKey:@"location"];
             
             NSMutableDictionary *dict_local =[[NSMutableDictionary alloc]init];
             [dict_local setObject:[van valueForKey:@"lat"] forKey:@"lat"];
             [dict_local setObject:[van valueForKey:@"lng"] forKey:@"lng"];
//             
//             
//             [arrLocation addObject:dict_local];
//             
//             
//             [allTableData addObject:[[arr objectAtIndex:i]valueForKey:@"name"]];
//             
//             //             NSLog(@"%@",checkinsCount);
//             //             NSLog(@"%@",stats);
//             
//             [checkinsCount addObject:[stats valueForKey:@"checkinsCount"]];
//             
//             //             NSLog(@"%@",[stats valueForKey:@"checkinsCount"]);
//             //             NSLog(@"%lu",checkinsCount.count);
//             [usersCount addObject:[stats valueForKey:@"usersCount"]];
//             
//             
             
             //    NSLog(@"%@",allTableData);
             
         }
         
         
      //   [self.myTableView reloadData];
         //   NSLog(@"%@",arrLocation);
     }];   
    
}

@end
