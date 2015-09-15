//
//  SignUpViewController.h
//  Restourant
//
//  Created by RAHUL on 9/2/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController  <UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)btnSignupClick:(id)sender;
- (NSString *)validateForm;
- (IBAction)btnLoginClick:(id)sender;

@end
