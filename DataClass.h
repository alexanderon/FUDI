//
//  DataClass.h
//  Restourant
//
//  Created by RAHUL on 9/7/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject

@property (atomic) int userId;
@property (strong,nonatomic)NSString *userEmail;
@property (strong,nonatomic) NSString *userPassword;
@property (strong,nonatomic) NSString *userFirstName;
@property (strong,nonatomic)NSString *userLastName;
@property (strong,nonatomic) NSString *userMobile;
+ (DataClass *)getInstance;

@end
