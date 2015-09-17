//
//  Validation.m
//  Restourant
//
//  Created by RAHUL on 9/17/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "Validation.h"

@implementation Validation


+ (NSString *)validateForm {
    NSString *errorMessage;
    
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *regexMobile=@"[0-9]{10}$";
    int tag;
    
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSPredicate *mobilePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexMobile];
    
    switch (tag) {
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
            
        default:
            break;
    }
    
    
    
    
  /*  if (!(self.txtFirstName.text.length >= 1)){
        errorMessage = @"Please enter a first name";
    } else if (!(self.txtLastName.text.length >= 1)){
        errorMessage = @"Please enter a last name";
    } else if (![emailPredicate evaluateWithObject:self.txtEmail.text]){
        errorMessage = @"Please enter a valid email address";
    } else if(![mobilePredicate evaluateWithObject:self.txtMobile.text]){
        errorMessage=@"Please enter a valid Mobile";
    } else if (!(self.txtPassword.text.length >= 1)){
        errorMessage = @"Please enter a valid password";
    }*/
    
    return errorMessage;
}

@end
