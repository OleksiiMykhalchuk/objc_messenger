//
//  MessagerViewController.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/3/22.
//

#import "MessengerViewController.h"
#import "MessengeTableViewCell.h"
#import "SenderTableViewCell.h"

@interface MessengerViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) NSLayoutConstraint *bottomViewConstraint;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@end

@implementation MessengerViewController

NSLayoutConstraint *topConstraint;
NSLayoutConstraint *bottomCondtraint;
NSLayoutConstraint *topConstraintWithKeyboard;
NSLayoutConstraint *bottomCondtraintWithKeyboard;
bool isKeyboardPressented = false;

- (IBAction)logOut:(id)sender {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc]init];
    [userDefaults setBool:false forKey:@"isLoggedIn"];
    [[self navigationController]popViewControllerAnimated:true];
}
-(IBAction)senderReceiverSwitch:(id)sender {
    NSLog(@"%d", self.switchButton.isOn);
}

NSMutableArray *messages;
NSArray *reversed;
NSLayoutConstraint *constraint;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Messenger";
    UINib *nib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"default"];
    nib = [UINib nibWithNibName:@"SenderTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"sender"];
    _tableView.dataSource = self;
    [_textField addTarget:self action:@selector(addMessage) forControlEvents:UIControlEventEditingDidEndOnExit];
    messages = [[NSMutableArray alloc]init];

    [messages addObject:@"Message 4"];
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = 10;
    [self textFieldSetup];
    [self tableViewSetup];
    [self bottomViewSetup];
    [self switchButtonSetup];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
-(void)bottomViewSetup {
    _bottomView.translatesAutoresizingMaskIntoConstraints = false;
    [_bottomView.topAnchor constraintEqualToAnchor:_tableView.bottomAnchor constant:0].active = true;
    _bottomViewConstraint = [_bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0];
    _bottomViewConstraint.active = true;
    [_bottomView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = true;
    [_bottomView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = true;
}
- (void)textFieldSetup {
    _textField.translatesAutoresizingMaskIntoConstraints = false;
    topConstraint = [_textField.topAnchor constraintEqualToAnchor:_bottomView.topAnchor constant:20 ];
    topConstraint.active = true;
    bottomCondtraint = [_textField.bottomAnchor constraintEqualToAnchor:_bottomView.bottomAnchor  constant:-60];
    bottomCondtraint.active = true;
    [_textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = true;
    [_textField.trailingAnchor constraintEqualToAnchor:_switchButton.leadingAnchor constant:-10].active = true;

    [self.view bringSubviewToFront:_textField];
}
- (void)switchButtonSetup {
    _switchButton.translatesAutoresizingMaskIntoConstraints = false;
    [_switchButton.topAnchor constraintEqualToAnchor:_bottomView.topAnchor constant:20].active = true;
    [_switchButton.trailingAnchor constraintEqualToAnchor:_bottomView.trailingAnchor constant:-10].active = true;
}
- (void)tableViewSetup {
    _tableView.translatesAutoresizingMaskIntoConstraints = false;
    [_tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = true;
    [_tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = true;
    [_tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0].active = true;

    _tableView.transform = CGAffineTransformMakeScale(1, -1);
}
- (void)keyboardWillShow: (NSNotification*)notification {

        NSDictionary *userInfo = notification.userInfo;

        NSValue *beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardBeginFrame = [self.view convertRect:beginFrameValue.CGRectValue toView:nil];

        NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue toView:nil];

        NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval animationDuration = durationValue.doubleValue;

        NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
        UIViewAnimationCurve animationCurve = curveValue.intValue;


        CGSize keyboardSize = [[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;
    _bottomViewConstraint.constant = -keyboardEndFrame.size.height;

        void (^animations)(void) = ^() {
            [self.view layoutIfNeeded];
        };

        [UIView animateWithDuration:animationDuration delay:0.0 options:(animationCurve << 16) animations:animations completion:nil];

        NSLog(@"keyBoardDidShow");

}
- (void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;

    NSValue *beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self.view convertRect:beginFrameValue.CGRectValue toView:nil];

    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue toView:nil];

    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;

    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;

    _bottomViewConstraint.constant = 0;

    void (^animations)(void) = ^() {
        [self.view layoutIfNeeded];
    };

    [UIView animateWithDuration:animationDuration delay:0.0 options:(animationCurve << 16) animations:animations completion:nil];

    NSLog(@"keyBoardDidHide");

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)addMessage {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[messages count] inSection:0];

    [messages addObject: _textField.text];
    NSArray *indexPaths = @[indexPath];
    reversed = [[indexPaths reverseObjectEnumerator]allObjects];
    [_tableView insertRowsAtIndexPaths:reversed withRowAnimation:UITableViewRowAnimationLeft];
    NSLog(@"addMessage");
    _textField.text = @"";
}
-(void)reverseArray:(NSString*)array {

}
- (void)updateTableContentInset {
    NSInteger numRows = [self.tableView numberOfRowsInSection:0];
    CGFloat contentInsetTop = self.tableView.bounds.size.height;
    for (NSInteger i = 0; i < numRows; i++) {
        contentInsetTop -= [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if (contentInsetTop <= 0) {
            contentInsetTop = 0;
            break;
        }
    }
    self.tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.switchButton.isOn) {
        MessengeTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"default" forIndexPath:indexPath];
        cell.message.text = [messages objectAtIndex: indexPath.row];
        cell.userInteractionEnabled = false;

        cell.contentView.transform = CGAffineTransformMakeScale(1, -1);

        return cell;
    } else {
        SenderTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"sender" forIndexPath:indexPath];
        cell.message.text = [messages objectAtIndex: indexPath.row];
        cell.userInteractionEnabled = false;

        cell.contentView.transform = CGAffineTransformMakeScale(1, -1);
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"Insert");
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
