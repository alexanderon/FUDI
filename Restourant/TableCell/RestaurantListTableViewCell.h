//
//  RestaurantListTableViewCell.h
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAdress;
@property (weak, nonatomic) IBOutlet UILabel *lblcheckinsCount;
@property (weak, nonatomic) IBOutlet UILabel *lbldistance;


@property (weak, nonatomic) IBOutlet UIImageView *imgList;
@property (weak, nonatomic) IBOutlet UILabel *lblusersCount;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;

@end
