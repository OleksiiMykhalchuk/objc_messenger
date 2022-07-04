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
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MessagerViewController

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
//    [_textField becomeFirstResponder];
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = 10;
    _textField.frame = CGRectMake(_bottomView.frame.origin.x,
                                        _bottomView.frame.origin.y + 330,
                                        _bottomView.frame.size.width,
                                        _bottomView.frame.size.height + 330);
    constraint.identifier = @"bottom";
    constraint.constant = 220;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
}
- (void)keyboardDidShow {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationsEnabled:YES];
    [UIView setAnimationDuration:0.3];
    _textField.frame = CGRectMake(
                                   _bottomView.frame.origin.x,
                                   _bottomView.frame.origin.y + 330,
                                   _bottomView.frame.size.width,
                                   _bottomView.frame.size.height);
    [UIView commitAnimations];
}
- (void)keyboardDidHide {
    _textField.frame = CGRectMake(
                                   _bottomView.frame.origin.x,
                                   _bottomView.frame.origin.y - 330,
                                   _bottomView.frame.size.width,
                                   _bottomView.frame.size.height);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGAffineTransform trans = [_bottomView transform];
    trans.tx = 330;
    trans.ty = 330;
    trans.a = 300;
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
