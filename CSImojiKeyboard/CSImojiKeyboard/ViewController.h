//
//  ViewController.h
//  CSImojiKeyboard
//
//  Created by SuhyongChoi on 2016. 7. 20..
//  Copyright © 2016년 Elenore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmoPageView.h"
@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate> {

    NSMutableArray *chatItemArray;
    NSArray *emoImages;
    NSArray *nibViews;
    CGSize keyboardSize;
    BOOL showEmo;
    BOOL isKeyboardHide;
    EmoPageView *emoView;
    
}

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet UITextField *textField;
@property (nonatomic,weak) IBOutlet UIButton *emoButton;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConst;

- (IBAction)send:(id)sender;
- (IBAction)showEmo:(id)sender;

@end

