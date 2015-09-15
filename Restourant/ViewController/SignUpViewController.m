//
//  SignUpViewController.m
//  Restourant
//
//  Created by RAHUL on 9/2/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "SignUpViewController.h"
#import "Database.h"
#import "DataClass.h"
#import "SVProgressHUD.h"


@interface SignUpViewController ()

{
    NSArray *img;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    
    
    img =[[NSArray alloc]initWithObjects:@"sing_user.png",@"sing_user.png",@"mail.png",@"call.png",@"lock.png", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"view will");
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"view did");
    
    for (int i=1; i<6; i++) {
        
        
        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 1, textField.frame.size.width,1.0f);
        bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
        [textField.layer addSublayer:bottomBorder];
        
        textField.leftViewMode=UITextFieldViewModeAlways;
        textField.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView *ivLeftVIew = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,20,20)];
        ivLeftVIew.image = [UIImage imageNamed:(NSString *)[img objectAtIndex:i-1]];
        [textField.leftView addSubview:ivLeftVIew];
        
        /* self.txtEmail.leftViewMode=UITextFieldViewModeAlways;
         self.txtEmail.leftView =[[UIView alloc]initWithFrame:CGRectMake(0  ,0, 40, 40)];
         UIImageView *img1 =[[UIImageView alloc]initWithFrame:CGRectMake(10,10,20,20)];
         img1.image =[UIImage imageNamed:@"mail.png"];
         [self.txtEmail.leftView addSubview:img1];*/
        
        
    }


    [SVProgressHUD dismiss];


}


-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewwill dis");
}




#pragma mark - validation


- (NSString *)validateForm {
    NSString *errorMessage;
    
/*    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *regex = stricterFilter ? stricterFilterString : laxString;*/
    
 //   NSString *regex =@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *regexMobile=@"[0-9]{10}$";
    
    
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSPredicate *mobilePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexMobile];
    
    if (!(self.txtFirstName.text.length >= 1)){
        errorMessage = @"Please enter a first name";
    } else if (!(self.txtLastName.text.length >= 1)){
        errorMessage = @"Please enter a last name";
    } else if (![emailPredicate evaluateWithObject:self.txtEmail.text]){
        errorMessage = @"Please enter a valid email address";
    } else if(![mobilePredicate evaluateWithObject:self.txtMobile.text]){
        errorMessage=@"Please enter a valid Mobile";
    } else if (!(self.txtPassword.text.length >= 1)){
        errorMessage = @"Please enter a valid password";
    }
    
    return errorMessage;
}

- (IBAction)btnLoginClick:(id)sender {
    
    [self.view endEditing:YES];
   // [self.frostedViewController.view endEditing:YES];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark signup

- (IBAction)btnSignupClick:(id)sender {
    
    
    NSLog(@"%@",[[Database getInstance]Select:@"UserInfo"]);
    // next step is to implement validateForm
    
    NSString *errorMessage = [self validateForm];
    
    if (errorMessage) {
        [[[UIAlertView alloc] initWithTitle:@"Alert" message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
        return;
    }
    
    // Send the form values to the server here.
    
    if ([[Database getInstance]validateUser:self.txtEmail.text])
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"User with this email already exists" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];

        return;
    }
    
    
    [[Database getInstance]Insert:self.txtFirstName.text LastName:self.txtLastName.text Email:self.txtEmail.text Mobile:self.txtMobile.text Password:self.txtPassword.text];
    
    DataClass *usrProfile=[DataClass getInstance];
    usrProfile.userFirstName=self.txtFirstName.text;
    usrProfile.userLastName=self.txtLastName.text;
    usrProfile.userEmail=self.txtEmail.text;
    usrProfile.userMobile=self.txtPassword.text;
    usrProfile.userPassword=self.txtPassword.text;
   
    [[[UIAlertView alloc]initWithTitle:@"SignUp" message:@"signed Up Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show];
    NSLog(@"%@",[[Database getInstance]Select:@"Student"]);
    
    self.txtMobile.text=@"";
    self.txtFirstName.text=@"";
    self.txtLastName.text=@"";
    self.txtEmail.text=@"";
    self.txtPassword.text=@"";

    
  

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    
    
    if (buttonIndex == 0  &&[alertView.title isEqual:@"SignUp"]) {
        
  [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        NSLog(@"index problem");
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int length = [currentString length];
    if ( textField.tag ==4 && length > 10) {
        return NO;
    }
    return YES;
}

@end
