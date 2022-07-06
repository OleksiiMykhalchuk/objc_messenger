//
//  MessagerViewController.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 7/3/22.
//

#import "MessagerViewController.h"
#import "MessageTableViewCell.h"

@interface MessagerViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
//@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MessagerViewController

NSLayoutConstraint *topConstraint;
NSLayoutConstraint *bottomCondtraint;
NSLayoutConstraint *topConstraintWithKeyboard;
NSLayoutConstraint *bottomCondtraintWithKeyboard;

- (IBAction)logOut:(id)sender {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc]init];
    [userDefaults setBool:false forKey:@"isLoggedIn"];
    [[self navigationController]popViewControllerAnimated:true];
}

NSString *messages[];
int count = 1;
NSLayoutConstraint *constraint;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Messanger";
    UINib *nib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"default"];
    _tableView.dataSource = self;
    [_textField addTarget:self action:@selector(addMessage) forControlEvents:UIControlEventEditingDidEndOnExit];
    messages[0] = @"Message 4";
    [_textField becomeFirstResponder];
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = 10;
    [self textFieldSetup];
    [self tableViewSetup];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)textFieldSetup {
    _textField.translatesAutoresizingMaskIntoConstraints = false;
    topConstraint = [_textField.topAnchor constraintEqualToAnchor:_tableView.bottomAnchor constant:10 ];
    topConstraint.active = true;
    bottomCondtraint = [_textField.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor  constant:-60];
    bottomCondtraint.active = true;
    [_textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:10].active = true;
    [_textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10].active = true;

    [self.view bringSubviewToFront:_textField];
}
- (void)tableViewSetup {
    _tableView.translatesAutoresizingMaskIntoConstraints = false;
    [_tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = true;
    [_tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = true;
    [_tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0].active = true;
    [_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-110].active = true;
}
- (void)keyboardDidShow: (NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;

    NSValue *beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self.view convertRect:beginFrameValue.CGRectValue toView:nil];

    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue toView:nil];

    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;

    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;

    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = keyboardBeginFrame.origin.y - viewFrame.origin.y;
    self.view.frame = viewFrame;

    void (^animations)(void) = ^() {

        CGRect viewFrame = self.view.frame;
        viewFrame.size.height = keyboardEndFrame.origin.y - viewFrame.origin.y;
        self.view.frame = viewFrame;
    };

    [UIView animateWithDuration:animationDuration delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:nil];

    NSLog(@"keyBoardDidShow");
}
- (void)keyboardDidHide:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;

    NSValue *beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self.view convertRect:beginFrameValue.CGRectValue toView:nil];

    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue toView:nil];

    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;

    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;

    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = keyboardBeginFrame.origin.y - viewFrame.origin.y;
    self.view.frame = viewFrame;

    void (^animations)(void) = ^() {
        CGRect viewFrame = self.view.frame;
        viewFrame.size.height = keyboardEndFrame.origin.y - viewFrame.origin.y;
        self.view.frame = viewFrame;
    };

    [UIView animateWithDuration:animationDuration delay:0.0 options:(animationCurve << 16) animations:animations completion:nil];

    NSLog(@"keyBoardDidHide");
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)addMessage {
    messages[count] = _textField.text;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(NSInteger)(count) inSection:0];
    NSArray *indexPaths = @[indexPath];
    count += 1;
    [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    NSLog(@"addMessage");
    _textField.text = @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"default" forIndexPath:indexPath];
    cell.message.text = messages[indexPath.row];
    cell.userInteractionEnabled = false;
    cell.backgroundColor = UIColor.systemCyanColor;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
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
