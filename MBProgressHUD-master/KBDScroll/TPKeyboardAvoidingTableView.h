//
//  TPKeyboardAvoidingTableView.h
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2013 A Tasty Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"


@protocol KBDCellDelegation <NSObject>
@optional
- (void)textFieldDidEndEditing:(UITextField *)textField;
@end

@interface TPKeyboardAvoidingTableView : UITableView <UITextFieldDelegate, UITextViewDelegate>{
    
}
@property(nonatomic, strong) id kbdDelegate;
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;
@end
