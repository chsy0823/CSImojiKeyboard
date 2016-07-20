//
//  ViewController.m
//  CSImojiKeyboard
//
//  Created by SuhyongChoi on 2016. 7. 20..
//  Copyright © 2016년 Elenore. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <EmoSelectDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    showEmo = false;
    isKeyboardHide = true;
    chatItemArray = [NSMutableArray array];
    
    emoImages = [NSArray arrayWithObjects:@"emoji_01_01", @"emoji_01_02", @"emoji_01_03", @"emoji_01_04", @"emoji_01_05", @"emoji_01_06", @"emoji_01_07", @"emoji_01_08", @"emoji_01_09", @"emoji_01_10", @"emoji_01_11", @"emoji_01_12", @"emoji_02_01", @"emoji_02_02", @"emoji_02_03", @"emoji_02_04", @"emoji_02_05", @"emoji_02_06", @"emoji_02_07", @"emoji_02_08", @"emoji_03_01", @"emoji_03_02", @"emoji_03_03", @"emoji_03_04", @"emoji_03_05", @"emoji_03_06", @"emoji_03_07", @"emoji_03_08", @"emoji_03_09", @"emoji_03_10", @"emoji_03_11", @"emoji_03_12", @"emoji_04_01", @"emoji_04_02", @"emoji_04_03", @"emoji_04_04", @"emoji_04_05", @"emoji_04_06", @"emoji_04_07", @"emoji_04_08", @"emoji_04_09", @"emoji_04_10", @"emoji_04_11", @"emoji_04_12", @"emoji_05_01", @"emoji_05_02", @"emoji_05_03", @"emoji_05_04", @"emoji_05_05", @"emoji_05_06", @"emoji_05_07", @"emoji_05_08", @"emoji_05_09", @"emoji_05_10", @"emoji_05_11", @"emoji_05_12", nil];
    
    nibViews = [[NSBundle mainBundle] loadNibNamed:@"EmoView"
                                             owner:self
                                           options:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self registKeyboardNotification];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self unregistKeyboardNotification];
}

- (IBAction)send:(id)sender {
    
    [chatItemArray addObject:[_textField text]];
    [_textField setText:@""];
    [_tableView reloadData];
}

- (IBAction)showEmo:(id)sender {
    
    if(isKeyboardHide)
        [_textField becomeFirstResponder];
    else {
        
        if(showEmo) {
            [_emoButton setSelected:false];
            
            if(emoView != nil) {
                [emoView removeFromSuperview];
            }
            showEmo = false;
        }
        else {
            NSLog(@"show");
            [_emoButton setSelected:true];
            emoView = [nibViews objectAtIndex:0];
            emoView.delegate = self;
            
            CGRect frame = emoView.frame;
            frame.size = CGSizeMake(self.view.frame.size.width, keyboardSize.height);
            frame.origin.x = 0;
            frame.origin.y = self.view.frame.size.height - keyboardSize.height;
            
            emoView.frame = frame;
            [emoView setInitWithEmoticonArray:emoImages];
            //[self.view addSubview:emoView];
            UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
            [window addSubview:emoView];
            [window bringSubviewToFront:emoView];
            showEmo = true;
        }
    }
}

#pragma mark - KEYBOARD settings
- (void)registKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void) unregistKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    
    NSDictionary *userInfo = [aNotification userInfo];
    keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [self setViewMovedUp:YES];
    isKeyboardHide = false;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    
    [self setViewMovedUp:NO];
    isKeyboardHide = true;
    
    if(showEmo) {
        [_emoButton setSelected:false];
        
        if(emoView != nil) {
            [emoView removeFromSuperview];
        }
        showEmo = false;
    }
}

- (void)keyboardHide {
    [self.view endEditing:YES];
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
    
    CGRect rect = self.inputView.frame;
    
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        
        rect.origin.y -= keyboardSize.height;
        _bottomConst.constant += keyboardSize.height;
    }
    else if(!movedUp)
    {
        // revert back to the normal state.
        rect.origin.y += keyboardSize.height;
        _bottomConst.constant -= keyboardSize.height;
    }
    self.inputView.frame = rect;
    
    [UIView commitAnimations];
}

-(void) hideKeyBoard:(UIGestureRecognizer *) sender
{
    [self keyboardHide];
}

- (NSAttributedString*)checkEmoText:(NSString*)inputText {
    
    NSArray *arr = [inputText componentsSeparatedByString:@" "];
    NSMutableAttributedString *myString;
    
    if(![inputText containsString:@"emoji_"]) {
        
        myString = [[NSMutableAttributedString alloc] initWithString:inputText];
    }
    else {
        myString = [[NSMutableAttributedString alloc] init];

        for(NSString *str in arr) {
            
            if([str containsString:@"emoji_"]) {
                
                for(NSString *imageName in emoImages) {
                    
                    NSString *checkEmo = [NSString stringWithFormat:@"[%@]",imageName];
                    
                    if([str isEqualToString:checkEmo]) {
                        
                        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                        attachment.image = [UIImage imageNamed:imageName];
                        attachment.bounds = CGRectMake(0, 0, 25, 25);
                        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                        [myString appendAttributedString:attachmentString];
                    }
                }
            }
            else {
                NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",str]];
                [myString appendAttributedString:string];
            }
            
        }
    }
    
    
    return myString;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return chatItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell.
    cell.textLabel.attributedText = [self checkEmoText:[chatItemArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (void)selectImoWithImageName:(NSString *)imageName {
    
    _textField.text = [NSString stringWithFormat:@"%@ [%@] ",_textField.text, imageName];
    
}
@end
