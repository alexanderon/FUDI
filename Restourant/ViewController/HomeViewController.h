//
//  HomeViewController.h
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"



@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *viewSorting;


- (IBAction)mapButtonClick:(id)sender;
- (IBAction)btnMenuShow:(id)sender;
- (IBAction)btnSearchClick:(id)sender;
- (IBAction)btnSort:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnFilterClick;

@end
