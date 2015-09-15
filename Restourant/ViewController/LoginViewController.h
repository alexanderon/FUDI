//
//  LoginViewController.h
//  Restourant
//
//  Created by RAHUL on 9/3/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;


@property (strong, nonatomic) UITapGestureRecognizer *tap;

- (IBAction)btnLoginClick:(id)sender;
- (IBAction)btnRegisterClick:(id)sender;

@end
