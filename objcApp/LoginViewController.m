//
//  ViewController.m
//  objcApp
//
//  Created by Oleksii Mykhalchuk on 6/28/22.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation LoginViewController

NSUserDefaults *userDefaults;
NSString *user;

- (IBAction)loginAction:(id)sender {
    user = [userDefaults stringForKey:@"user"];
    NSString *pass = [userDefaults stringForKey:@"pass"];
    if ([self.userField.text isEqualToString:user] && [self.passwordField.text isEqualToString:pass]) {
        UIViewController *controller = [[self storyboard]instantiateViewControllerWithIdentifier:@"Messager"];
        [userDefaults setBool:true forKey:@"isLoggedIn"];
        [[self navigationController] pushViewController:controller animated:true];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Wrong credantials" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:true completion:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [[NSUserDefaults alloc]init];
    [self setupLoginView];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    bool isLoggedIn = [userDefaults boolForKey:@"isLoggedIn"];
    if (isLoggedIn) {
        UIViewController *controller = [[self storyboard]instantiateViewControllerWithIdentifier:@"Messager"];
        [[self navigationController] pushViewController:controller animated:true];
    }
}
-(void)setupLoginView {
    _loginView.layer.cornerRadius = 20;
    _loginView.layer.shadowColor = UIColor.systemBrownColor.CGColor;
    _loginView.layer.shadowRadius = 10;
    _loginView.layer.shadowOpacity = 0.5;
}

@end

