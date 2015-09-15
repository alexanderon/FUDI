//
//  SideMenuTableViewController.h
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface SideMenuTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
