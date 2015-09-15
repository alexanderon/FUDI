//
//  DetailViewController.h
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface DetailViewController : UIViewController <REFrostedViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAdress;
@property (weak, nonatomic) IBOutlet UILabel *lblFullDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblCheckinsCount;
@property   (weak, nonatomic) NSDictionary *dictName;
@property   (weak,nonatomic) NSString    *lblname;
@property   (weak,nonatomic)NSString    *lbladress;
@property   (weak,nonatomic)NSString    *lblcheckinsCount;
@property (weak,nonatomic)NSDictionary *vanue;

- (IBAction)backButtonClick:(id)sender;
- (IBAction)btnMapClick:(id)sender;

@end
