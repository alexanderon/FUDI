//
//  AppDelegate.h
//  Restourant
//
//  Created by RAHUL on 9/2/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSString * userEmail;
+(AppDelegate *) sharedAppDelegate;
@end

