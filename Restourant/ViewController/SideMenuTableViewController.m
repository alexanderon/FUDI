//
//  SideMenuTableViewController.m
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "SideMenuTableViewController.h"
#import "SideMenuCellTableViewCell.h"
#import "ProfileViewController.h"
#import "HomeViewController.h"
#import "DEMONavigationController.h"
#import "DataClass.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SideMenuTableViewController ()
{
    NSArray *imageName;
    NSArray *menuTitle;
    BOOL isLogoutSel;
}
@property (assign) int previousTab;
@end

@implementation SideMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    isLogoutSel=false;
    self.previousTab =0;
    
    imageName=[[NSArray alloc]initWithObjects:@"rest.png",@"sing_user.png",@"settings.png",@"sign_out.png", nil];
    menuTitle=[[NSArray alloc]initWithObjects:@"Restaurant",@"MY PROFILE",@"SETTINGS",@"SIGN OUT",nil];
    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuTitle.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DEMONavigationController *NVC =[self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];

    
    
    switch (indexPath.row ) {
        case (0) :
        {
            if (self.previousTab == 0) {
                [self.frostedViewController hideMenuViewController];
                return;
            }
            
            self.frostedViewController.contentViewController = NVC;
            self.previousTab=0;
         
            
        }
            
            break;
        case  1:
        {
            
           
           ProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];


            NVC.viewControllers=@[VC];
            self.frostedViewController.contentViewController = NVC;
            self.previousTab =1;

        }
            break;
            
        case 2:
            break;
            
        case 3:
            {
            
            [[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to logout?" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Ok", nil]show ];
   
            }
            break;
            
           }
    
    [self.frostedViewController hideMenuViewController];

    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SideMenuCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideMenuCellTableViewCell" forIndexPath:indexPath];
  
    
    cell.sideMenuTitle.text=(NSString *)[menuTitle objectAtIndex:indexPath.row];

        cell.backgroundColor=[UIColor clearColor];
    
    cell.sideMenuImage.image=[UIImage imageNamed:[imageName objectAtIndex:indexPath.row]];
    
  //  cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
    }
    else
    {

         UINavigationController *nvc = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
        [[AppDelegate sharedAppDelegate].window setRootViewController:nvc];

    }
    
}

@end
